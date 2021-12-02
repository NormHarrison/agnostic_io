package body Text_Pipe_AIO is

   function To_Channel_Access (Channel : in Text_Channel_Type)
     return Agnostic_IO.Root_AIO_Channel_Access
   is (Channel'Unrestricted_Access);

   overriding procedure Write_Line
     (Channel : in out Text_Channel_Type;
      Data    : in     String)
   is
   begin
      Ada.Text_IO.Put_Line (Channel.Output_Pipe, Data);
   end Write_Line;

   overriding function Read_Line
     (Channel : in out Text_Channel_Type) return String
   is (Ada.Text_IO.Get_Line);

   procedure Set_Input
     (On_Channel : in out Text_Channel_Type;
      To_Pipe    : in     Ada.Text_IO.File_Access)
   is
   begin
      On_Channel.Input_Pipe := To_Pipe;
   end Set_Input;

   procedure Set_Output
     (On_Channel : in out Text_Channel_Type;
      To_Pipe    : in     Ada.Text_IO.File_Access)
   is
   begin
      On_Channel.Output_Pipe := To_Pipe;
   end Set_Output;



end Text_Pipe_AIO;
