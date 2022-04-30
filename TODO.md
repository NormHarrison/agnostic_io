### TODO:###

- The socket isn't being closed when errors occur, even though (at least in
some cases) it could be. Which seems to leak TCP socket/file descriptors in
the `CLOSE_WAIT` state.

- Instead of using a custom enumeration type for errors, return
  a value of `GNAT.Sockets.Error_Type`, although how would we report
  the occurrence of the recursion limit being reached?...

- Consider renaming `Read_Error_Kind` to `Read_Error_Type` or
  `Read_Error_Reason`.

- Add write errors that resemble the read errors.
