with Ada.Text_IO; use Ada.Text_IO;

--  TODO:
--    Replace `Overflow` in identifier names with `Excess`.

package body Socket_IO is

   overriding procedure Write_Line
     (Channel : in out Socket_Channel_Type;
      Data    : in     String)
   is
   begin
      String'Write (GNAT.Sockets.Stream (Channel.Socket), Data & Line_Feed);
      --  ! Might leak memeory?
   end Write_Line;

   overriding function Read_Line
     (Channel : in out Socket_Channel_Type) return String
   is
      use Ada.Streams;

      function Find_Line_Feed
        (Buffer   : in     String;
         Position :    out Natural) return Boolean
      is
      begin
         for Index in Buffer'Range loop
            if Buffer (Index) = Line_Feed then
               Position := Index;
               return True;
            end if;
         end loop;

         return False;
      end Find_Line_Feed;

      -----------------------------------------------------

      function To_String
        (Buffer : in Ada.Streams.Stream_Element_Array;
         Last   : in SE_Offset) return String
      is
         String_Buffer : String (1 .. Integer (Last));

      begin
         for Index in Buffer'Range loop
            String_Buffer (Integer (Index)) := Character'Val (Buffer (Index));
            --  ! If the peer closes the socket without sending any data,
            --    `Constraint_Error` is raised here. We need to re-test
            --    what the value of `Last_Index` is when no data is sent
            --    and handle that situation before this function is called.
            exit when Index = Last;
         end loop;

         return String_Buffer;
      end To_String;

      -----------------------------------------------------

      function Get_Data
        (Previous_Buffer      : in String;
         Last_Index_Recursive : in Natural) return String
      is
         Buffer : Ada.Streams.Stream_Element_Array
           (1 .. SE_Offset (Channel.Buffer_Size));

         Last_Index    : SE_Offset;
         Line_Feed_Pos : Natural;

      begin
         --  ! This implementation fails here. For some reason, the call
         --    to `Receive_Socket` when there is data in the
         --    `Channel.Overflow_Buffer` block forever. Is this possibly
         --    because the data in `Channel.Overflow_Buffer` references
         --    the data in the local buffer?
         GNAT.Sockets.Receive_Socket
           (Socket => Channel.Socket,
            Item   => Buffer,
            Last   => Last_Index);

         declare
            Combined : constant String := Previous_Buffer
              & To_String (Buffer, Last_Index);
         begin
            if Find_Line_Feed (Combined, Line_Feed_Pos) then
               --  Complete line read.

               Put_Line ("Line_Feed_Pos: " & Natural'Image (Line_Feed_Pos));

               Put_Line ("Last_Index: " &
                 Natural'Image (Last_Index_Recursive + Natural (Last_Index)));

               if Last_Index_Recursive + Natural (Last_Index) /= Line_Feed_Pos then
                  --  If we began to read the start of the next line,
                  --  then to prevent losing this excess data, we need
                  --  to store it for use upon the next call to `Read_Line`.

                  declare
                     Overflow_End_Index : constant Natural :=
                       (Last_Index_Recursive + Natural (Last_Index)) - (Line_Feed_Pos + 1);
                       --  ! Plus 1 to ignore line feed character.

                     Combined_End_Index : constant Natural :=
                       (Natural (Last_Index) + Last_Index_Recursive) - 1;
                       --  ! Minus 1 in order to ignore line feed character.

                  begin
                     Put_Line ("Overflow_End_Index: "
                       & Natural'Image (Overflow_End_Index));

                     Put_Line ("Combined_End_Index: "
                       & Natural'Image (Combined_End_Index));

                     Put_Line ("Size of Combined buffer: "
                       & Natural'Image (Combined'Length));

                     Channel.Overflow_Buffer (1 .. Overflow_End_Index) :=
                       Combined (Line_Feed_Pos + 1 .. Combined_End_Index);

                     Channel.Buffer_Position := Overflow_End_Index;
                     --  ! We could use `Channel.Buffer_Position` in place of
                     --    `Overflow_End_Index` if we reset it to 0 whenever
                     --    each time this encompassing conditional statement
                     --    is false (i.e. it's `else` case).
                  end;
               end if;

               return Combined (1 .. Line_Feed_Pos - 1);
               --  Subtract 1 from `Line_Feed_Pos` to avoid including
               --  the actual line feed character.

            elsif Last_Index = (Buffer'First - 1) then
               --  Socket was closed.
               return Combined; --  ! Raise an exception here?

            else
               Channel.Buffer_Position := 0;
               return Get_Data (Combined, Last_Index_Recursive + Natural (Last_Index));
            end if;
         end;
      end Get_Data;

   begin
      --  ! WE ARE LOSING DATA WITH THIS METHOD CURRENTLY.
      --    The buffer and its last index position need to be
      --    saved between calls to this function.

      return Get_Data
        (Last_Index_Recursive => 0,
         Previous_Buffer      => Channel.Overflow_Buffer
           (Channel.Overflow_Buffer'First .. Channel.Buffer_Position));

   end Read_Line;

   procedure Set_Socket
     (Channel : in out Socket_Channel_Type;
      Socket  : in     GNAT.Sockets.Socket_Type)
   is
   begin
      Channel.Socket := Socket;
      --  ! Forcefully close the previous socket when re-setting?
   end Set_Socket;


end Socket_IO;
