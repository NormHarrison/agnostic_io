package body Socket_AIO is

   ----------------
   -- Write_Line --
   ----------------

   overriding procedure Write_Line
     (Channel : in out Socket_Channel_Type;
      Data    : in     String)
   is
      Line_Feed : constant Character := Character'Val (10);

   begin
      String'Write (GNAT.Sockets.Stream (Channel.Socket), Data & Line_Feed);
      --  ! Might leak memeory?
   end Write_Line;

   ---------------
   -- Read_Line --
   ---------------

   overriding function Read_Line
     (Channel : in out Socket_Channel_Type) return String
   is
      use Ada.Streams;

      ---------------------
      -- Found_Line_Feed --
      ---------------------

      function Found_Line_Feed
        (Buffer   : in     Stream_Element_Array;
         Position :    out Stream_Element_Offset) return Boolean
      is
         Line_Feed_Code : constant Stream_Element := 10;

      begin
         for Index in Buffer'Range loop
            if Buffer (Index) = Line_Feed_Code then
               Position := Index;
               return True;
            end if;
         end loop;

         return False;
      end Found_Line_Feed;

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
         Buffer : Ada.Streams.Stream_Element_Array (1 .. Buffer_Size);

         Socket_Flag : GNAT.Sockets.Request_Flag_Type :=
            GNAT.Sockets.Peek_At_Incoming_Data;

         Last_Index    : Stream_Element_Offset;
         Line_Feed_Pos : Stream_Element_Offset;

      begin
         if not Just_Peek then
            Socket_Flag := GNAT.Sockets.No_Request_Flag;
         end if;

         GNAT.Sockets.Receive_Socket
           (Socket => Channel.Socket,
            Item   => Buffer,
            Last   => Last_Index,
            Flags  => Socket_Flag);

         --  ! Subtraction of `Buffer'First` will need to be dynamic
         --    when this subprogram is eventually adapted to delimit
         --    messages by characters other than line feed.
         if Last_Index = (Buffer'First - 1) then
            --  Socket was closed by peer.

            Channel.Connected := False;
            --GNAT.Sockets.Close_Socket (Channel.Socket);
            return "";

         elsif not Just_Peek then
            --  Complete line found, end recursion.

            return To_String (Buffer, Buffer'Last - 1);
            --  Substract 1 from the buffer's size to prevent
            --  inclusion of the line feed character in the final string.

         elsif Found_Line_Feed (Buffer (1 .. Last_Index), Line_Feed_Pos) then
            --  Complete line found, do one more recursive call.

            return Get_Data
              (Buffer_Size => Line_Feed_Pos,
               Just_Peek   => False);

         else
            --  Complete line not found yet, more data is needed.

            return Get_Data
              (Buffer_Size => Buffer_Size + Buffer_Size,
               Just_Peek   => True);
         end if;
      end Get_Data;

   --  Start of `Read_Line`.

   begin
      return Get_Data
        (Buffer_Size => Channel.Buffer_Start_Size,
         Just_Peek   => True);
   end Read_Line;

   ----------------
   -- Set_Socket --
   ----------------

   procedure Set_Socket
     (Channel : in out Socket_Channel_Type;
      Socket  : in     GNAT.Sockets.Socket_Type)
   is
   begin
      --  ! WARNING: THIS STATEMENT'S POSITION MAY CAUSE PROBLEMS
      --             IN THE FUTURE UNKNOWINGLY.
      Channel.Connected := True;
      Channel.Socket    := Socket;
      --  ! Forcefully close the previous socket when re-setting?
   end Set_Socket;

   ---------------
   -- To_Socket --
   ---------------

   function To_Socket (Channel : in Socket_Channel_Type)
     return GNAT.Sockets.Socket_Type
   is (Channel.Socket);

   -----------
   -- Close --
   -----------

   procedure Close (Channel : in out Socket_Channel_Type) is
   begin
      GNAT.Sockets.Close_Socket (Channel.Socket);
      Channel.Connected := False;
   end Close;

   ------------------
   -- Is_Connected --
   ------------------

   function Is_Connected (Channel : in Socket_Channel_Type) return Boolean
   is (Channel.Connected);

end Socket_AIO;
