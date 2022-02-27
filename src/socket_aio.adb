--with Ada.Text_IO; use Ada.Text_IO;


package body Socket_AIO is

   ---------------
   -- To_String --
   ---------------

   function To_String (Elements : in Stream_Element_Array) return String
   is
      String_Buffer : String (1 .. Integer (Elements'Length));
      String_Index  : Positive := 1;

   begin
      for Elements_Index in Elements'Range loop
         String_Buffer (String_Index) :=
           Character'Val (Elements (Elements_Index));
         --  Convert each stream element into its corresponding ASCII character.
         String_Index := String_Index + 1;
      end loop;

      return String_Buffer;
   end To_String;

   ----------------
   -- Write_Line --
   ----------------

   overriding procedure Write_Line
     (Self : in out Socket_Channel_Type;
      Data : in     String)
   is
   begin
      Self.Write (Data & To_String (Line_Endings (Self.Line_Ending).all));
   end Write_Line;

   -----------
   -- Write --
   -----------

   procedure Write
     (Self : in out Socket_Channel_Type;
      Data : in     String)
   is
      Line_Start : constant Stream_Element_Offset :=
        Stream_Element_Offset (Data'First);

      Line_End : constant Stream_Element_Offset :=
        Stream_Element_Offset (Data'Last);

      Socket_Data : Stream_Element_Array (Line_Start .. Line_End);
      Last_Index  : Stream_Element_Offset := Line_Start;

   begin
      for Index in Data'Range loop
         Socket_Data (Stream_Element_Offset (Index)) :=
           Character'Pos (Data (Index));
      end loop;

      loop
         GNAT.Sockets.Send_Socket
           (Socket => Self.Socket,
            Item   => Socket_Data (Last_Index .. Line_End),
            Last   => Last_Index);

         if Last_Index = Socket_Data'Last then
            --  Finished sending all data.
            exit;

         elsif Last_Index = Last_Index - 1 then
            --  Socket was closed by peer.
            Self.Connected := False;
            exit;

         end if;
      end loop;

   exception
      when GNAT.Sockets.Socket_Error =>
         --  ! Does the socket need to be closed here?
         Self.Connected := False;
         return;

   end Write;

   -----------------------------
   -- To_Stream_Element_Array --
   -----------------------------

   function To_Stream_Element_Array
     (S : in String) return Ada.Streams.Stream_Element_Array
   is
      Elements : Ada.Streams.Stream_Element_Array
        (SE_Offset (S'First) .. SE_Offset (S'Last));
      --  ! If we are ever to make `Elements` have an initial index
      --    of 0, we must subtract 1 from the provided string's length
      --    in order to avoid creating an empty, extra index.

      Elements_Index : Ada.Streams.Stream_Element_Offset := Elements'First;

   begin
      for String_Index in S'Range loop
         Elements (Elements_Index) :=
           Stream_Element (Character'Pos (S (String_Index)));
         Elements_Index := Elements_Index + 1;
      end loop;
      return Elements;
   end To_Stream_Element_Array;

   ---------------
   -- Read_Line --
   ---------------

   overriding function Read_Line
     (Self  : in out Socket_Channel_Type;
      Error :    out Agnostic_IO.Read_Error_Kind) return String
   is (Self.Read (Delimiter => Line_Endings (Self.Line_Ending).all,
                  Error     => Error));

   ------------------------
   -- Contains_Delimiter --
   ------------------------

   function Contains_Delimiter
     (Delimiter : in     Stream_Element_Array;
      In_Buffer : in     Stream_Element_Array;
      Position  :    out Stream_Element_Offset) return Boolean
   is
      Delimiter_Index : Stream_Element_Offset := Delimiter'First;

   begin
      for Buffer_Index in In_Buffer'Range loop

         if In_Buffer (Buffer_Index) = Delimiter (Delimiter_Index) then

            if Delimiter_Index = Delimiter'Last then
               Position := Buffer_Index;
               return True;
            end if;
            Delimiter_Index := Delimiter_Index + 1;

         else

            Delimiter_Index := Delimiter'First;

         end if;

      end loop;

      Position := 0;
      return False;

   end Contains_Delimiter;

   ------------------------------
   -- Recursive_Receive_Socket --
   ------------------------------

   function Recursive_Receive_Socket
     (Self            : in out Socket_Channel_Type;
      Delimiter       : in     Stream_Element_Array;
      Buffer_Size     : in     Stream_Element_Offset; --  ! Try to use `Self.Buffer_Start_Size` instead?
      Error           :    out Agnostic_IO.Read_Error_Kind;
      Just_Peek       : in     Boolean := True;
      Recursion_Count : in     Natural := 0) return String
   is
      --  ! Try to re-nest inside procedure `Read`?

      Buffer : Ada.Streams.Stream_Element_Array (0 .. Buffer_Size);

      Last_Index         : Stream_Element_Offset;
      Delimiter_Position : Stream_Element_Offset;

   begin
      GNAT.Sockets.Receive_Socket
        (Socket => Self.Socket,
         Item   => Buffer,
         Last   => Last_Index,
         Flags  => (if Just_Peek then
                       GNAT.Sockets.Peek_At_Incoming_Data
                    else
                       GNAT.Sockets.No_Request_Flag));

      if Last_Index = (Buffer'First - 1) then
         --  Socket was closed by peer (doesn't apply to when
         --  the socket is closed from our end).
         Self.Connected := False;
         Error := Agnostic_IO.Remote_Socket_Closure_Error;
         return "";

      else
         --  Data was successfully read...

         if not Just_Peek then
            --  and recursion is complete, return the data
            --  read excluding the delimiter.

            Error := Agnostic_IO.No_Error;
            return To_String
              (Buffer (Buffer'First .. Last_Index - Delimiter'Length));

         elsif Contains_Delimiter
                 (Delimiter => Delimiter,
                  In_Buffer => Buffer (Buffer'First .. Last_Index),
                  Position  => Delimiter_Position)
         then
            --  and the delimiting data was found. Perform one more recursion.

            return Self.Recursive_Receive_Socket
              (Buffer_Size     => Delimiter_Position,
               Delimiter       => Delimiter,
               Error           => Error,
               Just_Peek       => False,
               Recursion_Count => Recursion_Count + 1);

         else
            --  although more data is needed...

            if Recursion_Count = Self.Recursion_Limit then
               --  but the recursion limit was reached.

               Error := Agnostic_IO.Recursion_Limit_Error;
               return "";

            else
               --  and we are still within the recusion limit.

               return Self.Recursive_Receive_Socket
                 (Buffer_Size     => Buffer_Size + Buffer_Size,
                  Delimiter       => Delimiter,
                  Error           => Error,
                  Just_Peek       => True,
                  Recursion_Count => Recursion_Count + 1);
            end if;
         end if;
      end if;

   exception
      when GNAT.Sockets.Socket_Error =>
         --  ! Does the socket need to be closed here?
         Self.Connected := False;
         Error := Agnostic_IO.Source_Read_Error;
         return "";

   end Recursive_Receive_Socket;

   ----------
   -- Read --
   ----------

   function Read
     (Self      : in out Socket_Channel_Type;
      Delimiter : in     Stream_Element_Array;
      Error     :    out Agnostic_IO.Read_Error_Kind) return String
   is (Self.Recursive_Receive_Socket (Buffer_Size => Self.Buffer_Start_Size,
                                      Delimiter   => Delimiter,
                                      Error       => Error));

   ----------------
   -- Set_Socket --
   ----------------

   procedure Set_Socket
     (Self   : in out Socket_Channel_Type;
      Socket : in     GNAT.Sockets.Socket_Type)
   is
   begin
      --  ! WARNING: THIS STATEMENT'S POSITION MAY CAUSE PROBLEMS
      --             IN THE FUTURE UNKNOWINGLY.
      Self.Connected := True;
      Self.Socket    := Socket;
   end Set_Socket;

   ---------------
   -- To_Socket --
   ---------------

   function To_Socket
     (Self : in Socket_Channel_Type) return GNAT.Sockets.Socket_Type
   is (Self.Socket);

   -----------
   -- Close --
   -----------

   procedure Close (Self : in out Socket_Channel_Type) is
   begin
      Self.Connected := False;
      GNAT.Sockets.Close_Socket (Self.Socket);
   end Close;

   ------------------
   -- Is_Connected --
   ------------------

   function Is_Connected (Self : in Socket_Channel_Type) return Boolean
   is (Self.Connected);

end Socket_AIO;
