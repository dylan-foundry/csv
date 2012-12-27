module: csv-test-suite
synopsis: Test suite for the csv library.

define suite csv-test-suite ()
  test simple-row-test;
end suite;

define test simple-row-test ()
  let s :: <byte-string-stream>
    = make(<byte-string-stream>,
     contents: make(<byte-string>, size: 32), direction: #"output");
  let writer = make(<csv-writer>, stream: s, dialect: $excel-dialect);
  write-row(writer, #[1, 2, 3]);
  check-equal("simple row", s.stream-contents, "1,2,3\r\n");
end test simple-row-test;
