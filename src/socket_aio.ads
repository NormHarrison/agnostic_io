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
      Line_Ending       : Line_Ending_Type;
      Recursion_Limit   : Positive) is
   limited new Agnostic_IO.Root_Channel_Type with private;

   procedure Set_Socket
     (Self   : in out Socket_Channel_Type;
      Socket : in     GNAT.Sockets.Socket_Type) with Inline;

   function To_Socket (Self: in Socket_Channel_Type)
     return GNAT.Sockets.Socket_Type with Inline;

   procedure Close (Self : in out Socket_Channel_Type) with Inline;

   function Is_Connected (Self : in Socket_Channel_Type) return Boolean
     with Inline;

   -------------
   -- Writing --
   -------------

   overriding procedure Write_Line
     (Self : in out Socket_Channel_Type;
      Data : in     String) with Inline;

   procedure Write (Self: in out Socket_Channel_Type; Data : in String);

   -------------
   -- Reading --
   -------------

   overriding function Read_Line
     (Self  : in out Socket_Channel_Type;
      Error :    out Agnostic_IO.Read_Error_Kind) return String;

   function To_Stream_Element_Array
     (S : in String) return Ada.Streams.Stream_Element_Array;
   --  ! Only supports ASCII characters.

   function Read
     (Self      : in out Socket_Channel_Type;
      Delimiter : in     Ada.Streams.Stream_Element_Array;
      Error     :    out Agnostic_IO.Read_Error_Kind) return String;

   --  Raises `GNAT.Sockets.Socket_Error` for the same reasons that
   --  `GNAT.Sockets.Receive_Socket` does, and raises `Recursion_Limit_Error`
   --  when the function has recursed the amount of times set in the
   --  `Socket_Channel_Type` discriminant `Recursion_Limit`. This exception
   --  may occur because the buffer size or recursion limit are not large
   --  enough, or because the incoming data simply lacks the supplied
   --  `Delimiter` (possibly purposefully by an attacker, see note).

   --------------------------------------------
   --  NOTE: Safely handling unexpected data --
   --------------------------------------------

   --  Please excercise caution when using this function. It is highly
   --  recommended that you set a recursion limit and buffer size on the
   --  `Socket_Channel_Type` instance that corresponds to the amount data you
   --  expect to receive and not any higher. The `Recursion_Limit_Error`
   --  exception can be safely caught, but possibly not stack overflow
   --  exceptions that would arrise from too much recursion.

private

   use Ada.Streams;

   subtype SE_Offset is Ada.Streams.Stream_Element_Offset;

   LF_Delimiter   : aliased constant Stream_Element_Array := (0 => 10);
   CR_Delimiter   : aliased constant Stream_Element_Array := (0 => 13);
   CRLF_Delimiter : aliased constant Stream_Element_Array := (0 => 13, 1 => 10);

   type SE_Array_Access is access constant Ada.Streams.Stream_Element_Array;

   Line_Endings : constant array (Line_Ending_Type) of SE_Array_Access :=
     (Line_Feed                 => LF_Delimiter'Access,
      Carriage_Return           => CR_Delimiter'Access,
      Carriage_Return_Line_Feed => CRLF_Delimiter'Access);

   type Socket_Channel_Type
     (Buffer_Start_Size  : Ada.Streams.Stream_Element_Offset;
      Line_Ending        : Line_Ending_Type;
      Recursion_Limit    : Positive)
   is limited new Agnostic_IO.Root_Channel_Type with record
      Socket    : GNAT.Sockets.Socket_Type := GNAT.Sockets.No_Socket;
      Connected : Boolean                  := False;
   end record;

end Socket_AIO;
