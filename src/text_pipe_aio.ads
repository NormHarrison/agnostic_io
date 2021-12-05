with Ada.Text_IO;

with Agnostic_IO;


package Text_Pipe_AIO is

   type Text_Channel_Type is
     new Agnostic_IO.Root_AIO_Channel_Type with private;

   --  ! This isn't needed really.
   function To_Channel_Access (Channel : in Text_Channel_Type)
     return Agnostic_IO.Root_AIO_Channel_Access;

   overriding procedure Write_Line
     (Channel : in out Text_Channel_Type;
      Data    : in     String);

   overriding function Read_Line
     (Channel : in out Text_Channel_Type) return String;

   procedure Set_Input
     (On_Channel : in out Text_Channel_Type;
      To_Pipe    : in     Ada.Text_IO.File_Access);

   procedure Set_Output
     (On_Channel : in out Text_Channel_Type;
      To_Pipe    : in     Ada.Text_IO.File_Access);

private

   type Text_Channel_Type is new Agnostic_IO.Root_AIO_Channel_Type with record
      Input_Pipe  : Ada.Text_IO.File_Access;
      Output_Pipe : Ada.Text_IO.File_Access;
   end record;

end Text_Pipe_AIO;
