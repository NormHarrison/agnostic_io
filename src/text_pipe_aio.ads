with Ada.Text_IO;

with Agnostic_IO;


package Text_Pipe_AIO is

   type Text_Channel_Type is
     limited new Agnostic_IO.Root_Channel_Type with private;

   procedure Write_Line
     (Self : in out Text_Channel_Type;
      Data : in     String);

   function Read_Line
     (Self  : in out Text_Channel_Type;
      Error :    out Agnostic_IO.Read_Error_Kind) return String;

   procedure Set_Pipes
     (Self   : in out Text_Channel_Type;
      Input  : in Ada.Text_IO.File_Access;
      Output : in Ada.Text_IO.File_Access);

   --  ! This isn't needed really, and if we keep it, it should
   --    be moved to the parent package (`Agnostic_IO`).
   --function To_Channel_Access (Channel : in Text_Channel_Type)
   --  return Agnostic_IO.Root_Channel_Access;

private

   type Text_Channel_Type is
     limited new Agnostic_IO.Root_Channel_Type with record
        Input_Pipe  : Ada.Text_IO.File_Access;
        Output_Pipe : Ada.Text_IO.File_Access;
     end record;

end Text_Pipe_AIO;
