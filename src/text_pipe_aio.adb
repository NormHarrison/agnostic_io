package body Text_Pipe_AIO is

   procedure Write_Line
     (Self : in out Text_Channel_Type;
      Data : in     String)
   is
   begin
      Ada.Text_IO.Put_Line (Self.Output_Pipe.all, Data);
   end Write_Line;

   function Read_Line
     (Self  : in out Text_Channel_Type;
      Error :    out Agnostic_IO.Read_Error_Kind) return String
   is
   begin
      Error := Agnostic_IO.No_Error;
      return Ada.Text_IO.Get_Line (Self.Input_Pipe.all);
   exception
      when others =>
         Error := Agnostic_IO.Read_Error;
         return "";
   end Read_Line;

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

