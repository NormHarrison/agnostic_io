-- TODO:

--  - Allow user to provide custom message delimiters, instead of being
--    forced to end the read or write with a line ending. This would require
--    a near complete reworking of the `Text_Pipe_AIO` package, but it could
--    share a lot of the same code with `Socket_AIO`.

--  - Possibly make reading/writing thread safe via use of a
--    mutex. Different operations could occur simultaneously, but
--    the same operations would be forced to wait until the current
--    completes. Making the channel type itself a protected type wouldn't
--    work, since reading would block writing.

--------


package Agnostic_IO is

   --pragma Pure;

   type Root_Channel_Type is limited interface;

   type Root_Channel_Access is access all Root_Channel_Type'Class;

   procedure Write_Line
     (Self : in out Root_Channel_Type;
      Data : in     String) is abstract;

   function Read_Line
     (Self : in out Root_Channel_Type) return String is abstract;

end Agnostic_IO;
