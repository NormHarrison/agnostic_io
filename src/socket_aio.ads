--  TODO:

--  Consider adding a `Result`/`Success` out parameter to
--  `Read/Write_Line`that indicates whether the read or write succeeded.
--  Currently, they both just set the `Connected` component to `False`
--  when reading or writing fails.

with Ada.Streams;

with GNAT.Sockets;

with Agnostic_IO;


package Socket_AIO is

   type Line_Ending_Type is
     (Line_Feed,
      Carriage_Return,
      Carriage_Return_Line_Feed);

   type Socket_Channel_Type
     (Buffer_Start_Size : Ada.Streams.Stream_Element_Offset;
      Line_Ending       : Line_Ending_Type) is
   limited new Agnostic_IO.Root_Channel_Type with private;

   overriding procedure Write_Line
     (Self : in out Socket_Channel_Type;
      Data : in     String) with Inline;

   overriding function Read_Line
     (Self : in out Socket_Channel_Type) return String;

   procedure Set_Socket
     (Self   : in out Socket_Channel_Type;
      Socket : in     GNAT.Sockets.Socket_Type) with Inline;

   function To_Socket (Self: in Socket_Channel_Type)
     return GNAT.Sockets.Socket_Type with Inline;

   procedure Close (Self : in out Socket_Channel_Type) with Inline;

   function Is_Connected (Self : in Socket_Channel_Type) return Boolean
     with Inline;

private

   type Line_Ending_Length_Array is array (Line_Ending_Type) of
     Ada.Streams.Stream_Element_Offset;

   Line_Ending_Lengths : constant Line_Ending_Length_Array :=
     (Line_Feed                 => 1,
      Carriage_Return           => 1,
      Carriage_Return_Line_Feed => 2);

   type Socket_Channel_Type
     (Buffer_Start_Size : Ada.Streams.Stream_Element_Offset;
      Line_Ending       : Line_Ending_Type)
   is limited new Agnostic_IO.Root_Channel_Type with record
      Socket    : GNAT.Sockets.Socket_Type := GNAT.Sockets.No_Socket;
      Connected : Boolean                  := False;
   end record;

end Socket_AIO;
