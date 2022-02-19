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

   type Read_Error_Kind is
   --  ! Should we use subtypes to defines ranges of the below
   --    values for certain packages (i.e. a range for pipe based
   --    IO, and a range for socket based IO)? Another thought was
   --    to add individual values for each exception present in the
   --    package `IO_Exceptions`.

   --  This type represents "exceptions" that the reading functions can
   --  encounter, but don't actually raise. The reason for conveying
   --  errors this way, is due to Ada's inability to handle exceptions
   --  raised inside declaration regions, which is where these functions
   --  will often be used.

     (No_Error,
      --  Indicates that execution of the subprogram was normal
      --  and no exception was raised.

      Recursion_Limit_Error,
      --  Indicates the internal recursion count reached the set limit.

      Read_Error);
      --  Indicates the underlying source of data can't be read from,
      --  due to one of various reasons.

   function Read_Line
     (Self  : in out Root_Channel_Type;
      Error :    out Read_Error_Kind) return String is abstract;

end Agnostic_IO;
