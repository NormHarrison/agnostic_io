with Ada.Text_IO; use Ada.Text_IO;
--with Ada.Streams;

with GNAT.Sockets;

with Agnostic_IO;
with Text_Pipe_AIO;
with Socket_AIO;

procedure Main is

   Agnostic_Channel : Agnostic_IO.Root_Channel_Access;

   procedure Test_Text_AIO is
      Text_Channel : Text_Pipe_AIO.Text_Channel_Type;
      Read_Error   : Agnostic_IO.Read_Error_Kind;

   begin
      Put_Line ("Testing text pipe AIO:");

      Text_Channel.Set_Pipes
        (Input  => Standard_Input,
         Output => Standard_Output);

      Agnostic_Channel := Text_Channel'Unrestricted_Access;

      Agnostic_Channel.Write_Line ("Test123");

      Put ("Type something >");

      Agnostic_Channel.Write_Line ("You typed: "
        & Agnostic_Channel.Read_Line (Read_Error));

   end Test_Text_AIO;


   function Return_Slice (Variant : in Positive) return String is
      Random_Text : constant String := "123456789";

   begin
      case Variant is
         when 1      => return Random_Text (1 .. 3);
         when 2      => return Random_Text (3 .. 5);
         when 3      => return Random_Text (4 .. 9);
         when others => return Random_Text (8 .. 9);
      end case;
   end Return_Slice;


   procedure Test_Socket_AIO is
      use type Agnostic_IO.Read_Error_Kind;

      The_String : constant String := Return_Slice (1)
        & "0000000000000000000000000000000000000000000000000000000000000000"
        & "0000000000000000000000000000000000000000000000000000000000000000"
        & "0000000000000000000000000000000000000000000000000000000000000001"
        & Return_Slice (3) & Return_Slice (2) & Return_Slice (3);

      Bind_Address : constant GNAT.Sockets.Sock_Addr_Type :=
        (Family => GNAT.Sockets.Family_Inet,
         Port   => 1234,
         Addr   => (Family => GNAT.Sockets.Family_Inet,
                    Sin_V4 => (127, 0, 0, 1)));

      Peer_Address : GNAT.Sockets.Sock_Addr_Type;

      Socket         : GNAT.Sockets.Socket_Type;
      Connection     : GNAT.Sockets.Socket_Type;
      Socket_Channel : Socket_AIO.Socket_Channel_Type
        (Buffer_Start_Size => 30,
         Line_Ending       => Socket_AIO.Line_Feed,
         Recursion_Limit   => 2);


      --Custom_Delimiter : constant Ada.Streams.Stream_Element_Array :=
        --Socket_AIO.To_Stream_Element_Array ("!!!");

      Read_Error : Agnostic_IO.Read_Error_Kind;

      --task Concurrent_Close is
         --entry Start;
      --end Concurrent_Close;

      --task body Concurrent_Close is
      --begin
         --accept Start;

         --Put_Line ("Closing socket in 5 seconds...");
         --delay 5.0;

         --Socket_Channel.Close;
      --end Concurrent_Close;

   begin
      Put_Line ("Testing socket AIO, connect to "
        & GNAT.Sockets.Image (Bind_Address));

      Put_Line ("The client should see the following.");
      Put_Line (The_String);

      GNAT.Sockets.Create_Socket
        (Socket => Socket,
         Family => GNAT.Sockets.Family_Inet,
         Mode   => GNAT.Sockets.Socket_Stream);

      GNAT.Sockets.Bind_Socket (Socket, Bind_Address);

      GNAT.Sockets.Listen_Socket (Socket);

      GNAT.Sockets.Accept_Socket
        (Server  => Socket,
         Socket  => Connection,
         Address => Peer_Address);

      Socket_Channel.Set_Socket (Connection);

      Socket_Channel.Write_Line (The_String);

      --Concurrent_Close.Start;

      while Socket_Channel.Is_Connected loop
         declare
            Data : constant String := Socket_Channel.Read_Line
              (Error => Read_Error);
         begin
            exit when Read_Error /= Agnostic_IO.No_Error;
            Put_Line ("Count: " & Integer'Image (Data'Length));
            Put_Line (Data);
         end;
      end loop;

      Socket_Channel.Close;
   end Test_Socket_AIO;

begin
   Test_Text_AIO;
   Test_Socket_AIO;
end Main;
