### TODO:###

- Consider adding a `Result`/`Success` out parameter to
  `Read/Write_Line` that indicates whether the read or write succeeded.
  Currently, they both just set the `Connected` component to `False`
  when reading or writing fails (with `Read` returning an empty string).
