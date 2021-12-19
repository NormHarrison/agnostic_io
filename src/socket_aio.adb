--with Ada.Text_IO; use Ada.Text_IO;


package body Socket_AIO is

   use Ada.Streams;

   ----------------------
   -- Line_Ending_Code --
   ----------------------

   function Line_Ending_Code
     (Line_Ending : in Line_Ending_Type) return Stream_Element_Array
   with Inline
   is
   begin
      case Line_Ending is
         when Line_Feed                 => return (0 => 10);
         when Carriage_Return           => return (0 => 13);
         when Carriage_Return_Line_Feed => return (0 => 13, 1 => 10);
      end case;
   end Line_Ending_Code;

   ----------------
   -- Write_Line --
   ----------------

   overriding procedure Write_Line
     (Self : in out Socket_Channel_Type;
      Data : in     String)
   is
      subtype SE_Offset is Ada.Streams.Stream_Element_Offset;

      Line_Ending_Length : constant Stream_Element_Offset :=
        Line_Ending_Lengths (Self.Line_Ending);

      Line_Length : constant Stream_Element_Offset :=
        Stream_Element_Offset (Data'Last) + Line_Ending_Length;

      Socket_Data : Stream_Element_Array (1 .. Line_Length);
      Last_Index  : Stream_Element_Offset := 1;

   begin
      for Index in Data'Range loop
         Socket_Data (SE_Offset (Index)) := Character'Pos (Data (Index));
      end loop;

      Socket_Data (SE_Offset (Data'Last) + 1 .. Socket_Data'Last) :=
        Line_Ending_Code (Self.Line_Ending);

      loop
         GNAT.Sockets.Send_Socket
           (Socket => Self.Socket,
            Item   => Socket_Data (Last_Index .. Socket_Data'Last),
            Last   => Last_Index);
         --  ! Can raise `Socket_Error` exception, possibly add error handling.

         if Last_Index = Socket_Data'Last then
            --  Finished sending all data.
            exit;

         elsif Last_Index = Last_Index - 1 then
            --  Socket was closed by peer.
            Self.Close;
            exit;
         end if;
      end loop;

   exception
      when GNAT.Sockets.Socket_Error =>
         Self.Close;

   end Write_Line;

   ---------------
   -- Read_Line --
   ---------------

   overriding function Read_Line
     (Self : in out Socket_Channel_Type) return String
   is

      -----------------------
      -- Found_Line_Ending --
      -----------------------

      function Found_Line_Ending
        (Buffer   : in     Stream_Element_Array;
         Position :    out Stream_Element_Offset) return Boolean
      is
         Slice_End : constant Stream_Element_Offset :=
           (Line_Ending_Lengths (Self.Line_Ending) - 1);

      begin
         for Index in Buffer'Range loop

            exit when (Index + Slice_End) > Buffer'Last;

            if Buffer (Index .. (Index + Slice_End)) =
               Line_Ending_Code (Self.Line_Ending)
            then
               Position := (Index + Slice_End);
               return True;
            end if;

         end loop;

         return False;

      end Found_Line_Ending;

      ---------------
      -- To_String --
      ---------------

      function To_String
        (Buffer  : in Stream_Element_Array;
         Stop_At : in Stream_Element_Offset) return String
      is
         String_Buffer : String (1 .. Integer (Stop_At));

      begin
         if Stop_At = 0 then
            --  Received data only consisted of the delimiting character.
            return "";
         end if;

         for Index in Buffer'Range loop

            String_Buffer (Integer (Index)) := Character'Val (Buffer (Index));

            if Index = Stop_At then
               return String_Buffer;
            end if;

         end loop;

         return "";
      end To_String;

      --------------
      -- Get_Data --
      --------------

      function Get_Data
        (Buffer_Size : in Stream_Element_Offset;
         Just_Peek   : in Boolean) return String
      is
         Line_Ending_Length : constant Stream_Element_Offset :=
           Line_Ending_Lengths (Self.Line_Ending);

         Buffer : Ada.Streams.Stream_Element_Array (1 .. Buffer_Size);

         Socket_Flag : GNAT.Sockets.Request_Flag_Type :=
            GNAT.Sockets.Peek_At_Incoming_Data;

         Last_Index   : Stream_Element_Offset;
         Line_End_Pos : Stream_Element_Offset;

      begin
         if not Just_Peek then
            Socket_Flag := GNAT.Sockets.No_Request_Flag;
         end if;

         GNAT.Sockets.Receive_Socket
           (Socket => Self.Socket,
            Item   => Buffer,
            Last   => Last_Index,
            Flags  => Socket_Flag);

         if Last_Index = (Buffer'First - 1) then
            --  Socket was closed by peer.
            Self.Close;
            return "";

         elsif not Just_Peek then
            --  Complete line found, end recursion.

            return To_String (Buffer, Buffer'Last - Line_Ending_Length);
            --  ! Substract the line ending's length from the buffer's size
            --    to prevent inclusion of the line end character(s) in the
            --    final string. This will need to be dynamic when this package
            --    is eventually adapted to support any delmiting character(s).

         elsif Found_Line_Ending (Buffer (1 .. Last_Index), Line_End_Pos) then
            --  Complete line found, do one more recursive call.

            return Get_Data
              (Buffer_Size => Line_End_Pos,
               Just_Peek   => False);

         else
            --  Complete line not found yet, more data is needed.

            return Get_Data
              (Buffer_Size => Buffer_Size + Buffer_Size,
               Just_Peek   => True);
         end if;

      exception
         when GNAT.Sockets.Socket_Error =>
            Self.Close;
            return ""; --  ! Is it worth trying to return was already gathered?
      end Get_Data;

   --  Start of `Read_Line`.

   begin
      return Get_Data
        (Buffer_Size => Self.Buffer_Start_Size,
         Just_Peek   => True);
   end Read_Line;

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
      GNAT.Sockets.Close_Socket (Self.Socket);
      Self.Connected := False;
   end Close;

   ------------------
   -- Is_Connected --
   ------------------

   function Is_Connected (Self : in Socket_Channel_Type) return Boolean
   is (Self.Connected);

end Socket_AIO;
