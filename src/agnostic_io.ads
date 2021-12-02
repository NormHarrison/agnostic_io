package Agnostic_IO is

   --pragma Pure;

   type Root_AIO_Channel_Type is abstract tagged limited private;
   --  ! Can an Ada interface type benefit us here? Maybe not, since
   --  we want to have an actual null record that is descended from.

   type Root_AIO_Channel_Access is access all Root_AIO_Channel_Type'Class;

   procedure Write_Line
     (Channel : in out Root_AIO_Channel_Type;
      Data    : in     String) is abstract;

   function Read_Line
     (Channel : in out Root_AIO_Channel_Type) return String is abstract;

private

   type Root_AIO_Channel_Type is abstract tagged limited null record;

end Agnostic_IO;
