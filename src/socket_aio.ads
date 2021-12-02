with Ada.Streams;

with GNAT.Sockets;

with Agnostic_IO;


package Socket_AIO is

   subtype SE_Offset is Ada.Streams.Stream_Element_Offset;

   type Socket_Channel_Type (Buffer_Start_Size : SE_Offset := 300) is
     new Agnostic_IO.Root_AIO_Channel_Type with private;

   overriding procedure Write_Line
     (Channel : in out Socket_Channel_Type;
      Data    : in     String);

   overriding function Read_Line
     (Channel : in out Socket_Channel_Type) return String;

   procedure Set_Socket
     (Channel : in out Socket_Channel_Type;
      Socket  : in     GNAT.Sockets.Socket_Type);

   function Is_Connected (Channel : in Socket_Channel_Type) return Boolean;

private

   type Socket_Channel_Type (Buffer_Start_Size : SE_Offset := 300) is
     new Agnostic_IO.Root_AIO_Channel_Type with record
        Socket    : GNAT.Sockets.Socket_Type := GNAT.Sockets.No_Socket;
        Connected : Boolean                  := False;
     end record;

end Socket_AIO;
