with Ada.Text_IO; use Ada.Text_IO;

with GNAT.Sockets;

with Agnostic_IO;
with Text_Pipe_AIO;
with Socket_AIO;

procedure Main is

   Agnostic_Channel : Agnostic_IO.Root_AIO_Channel_Access;

   procedure Test_Text_AIO is
      Text_Channel   : Text_Pipe_AIO.Text_Channel_Type;

   begin
      Put_Line ("Testing text pipe AIO:");

      Text_Channel.Set_Input  (To_Pipe => Standard_Input);
      Text_Channel.Set_Output (To_Pipe => Standard_Output);

      Agnostic_Channel := Text_Channel.To_Channel_Access;

      Agnostic_Channel.Write_Line ("Test123");
      Put ("Type something >");
      Agnostic_Channel.Write_Line ("You typed: " & Agnostic_Channel.Read_Line);
   end Test_Text_AIO;


   procedure Test_Socket_AIO is
      Bind_Address : constant GNAT.Sockets.Sock_Addr_Type :=
        (Family => GNAT.Sockets.Family_Inet,
         Port   => 1234,
         Addr   => (Family => GNAT.Sockets.Family_Inet,
                    Sin_V4 => (127, 0, 0, 1)));

      Peer_Address : GNAT.Sockets.Sock_Addr_Type;

      Socket         : GNAT.Sockets.Socket_Type;
      Connection     : GNAT.Sockets.Socket_Type;
      Socket_Channel : Socket_AIO.Socket_Channel_Type;

   begin
      Put_Line ("Testing socket AIO:");

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

      Socket_Channel.Write_Line ("Test123");

      while Socket_Channel.Is_Connected loop
         declare
            Data : constant String := Socket_Channel.Read_Line;
         begin
            Put_Line ("Count: " & Integer'Image (Data'Length));
            Put_Line (Data);
         end;
      end loop;

      GNAT.Sockets.Close_Socket (Connection);
   end Test_Socket_AIO;

begin
   Test_Text_AIO;
   Test_Socket_AIO;
end Main;
