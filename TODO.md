### TODO:###

- Set `Error` out parameter to `Agnostic_IO.No_Error` at the beginning
of the `Read/Write` subprograms?

- `Socket_AIO` package now closes socket connections whenever an abnormal
condition occurrs, along with when the recursion limit is reached. Previously
the user would be tasked with closing the socket afterwards. If TCP sockets
are not closed after such conditions occur they usually are leaked in the
`CLOSE_WAIT` state. We should still revise this futher, as it was done mostly
to fit the needs of the `Asterisk.AGI` package, which needs to be re-designed.

- Instead of using a custom enumeration type for errors, return
  a value of `GNAT.Sockets.Error_Type`, although how would we report
  the occurrence of the recursion limit being reached?...

- Consider renaming `Read_Error_Kind` to `Read_Error_Type` or
  `Read_Error_Reason`.

- Add write errors that resemble the read errors.
