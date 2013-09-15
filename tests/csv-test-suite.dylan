module: csv-test-suite
synopsis: Test suite for the csv library.

define constant $simple-excel-tsv = "Year\tTitle\tAuthor\n"
  "1827\tThe Betrothed\tAlessandro Manzoni\n"
  "1979\tIf on a winter's night a traveler\tItalo Calvino";

define suite csv-test-suite ()
  test simple-excel-reader;
  test simple-row-test;
end suite;

define test simple-excel-reader ()
  let tsv = make(<byte-string-stream>,
                 contents: $simple-excel-tsv,
                 direction: #"input");
  let simplereader = make(<csv-reader>,
                          stream: tsv,
                          dialect: $excel-tsv-dialect);
  for (row in simplereader)
    check-equal("count columns", size(row), 3);
  end for;

  tsv.stream-position := 0; // Reset stream

  let jumpreader = make(<csv-reader>,
                        stream: tsv,
                        dialect: $excel-tsv-dialect);
  check-equal("jump to end", jumpreader[2][0], "1979");
  check-equal("jump to line", jumpreader[1][2], "Alessandro Manzoni");
end test simple-excel-reader;

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
