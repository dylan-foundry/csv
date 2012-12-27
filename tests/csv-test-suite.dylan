module: csv-test-suite
synopsis: Test suite for the csv library.

define suite csv-test-suite ()
  test simple-row-test;
end suite;

define test simple-row-test ()
  let csv :: <byte-string-stream>
    = make(<byte-string-stream>,
     contents: make(<byte-string>, size: 32), direction: #"output");
  let csv-writer = make(<csv-writer>, stream: csv, dialect: $excel-dialect);
  write-row(csv-writer, #[1, 2, 3]);
  check-equal("simple row", csv.stream-contents, "1,2,3\r\n");

  let tsv :: <byte-string-stream>
    = make(<byte-string-stream>,
     contents: make(<byte-string>, size: 32), direction: #"output");
  let tsv-writer = make(<csv-writer>, stream: tsv, dialect: $excel-tsv-dialect);
  write-row(tsv-writer, #[1, 2, "3"]);
  check-equal("simple row", tsv.stream-contents, "1\t2\t3\r\n");
end test simple-row-test;
