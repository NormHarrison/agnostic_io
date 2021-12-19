package body Text_Pipe_AIO is

   procedure Write_Line
     (Self : in out Text_Channel_Type;
      Data : in     String)
   is
   begin
      Ada.Text_IO.Put_Line (Self.Output_Pipe.all, Data);
   end Write_Line;

   function Read_Line (Self : in out Text_Channel_Type) return String
   is (Ada.Text_IO.Get_Line (Self.Input_Pipe.all));

   procedure Set_Pipes
     (Self   : in out Text_Channel_Type;
      Input  : in     Ada.Text_IO.File_Access;
      Output : in     Ada.Text_IO.File_Access)
   is
   begin
      Self.Input_Pipe  := Input;
      Self.Output_Pipe := Output;
   end Set_Pipes;

end Text_Pipe_AIO;

