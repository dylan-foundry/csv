module: csv
synopsis: Some shared code for dealing with CSV files.
author: Bruce Mitchener
copyright: 2012, Data Fueled, LLC.

define constant $csv-quote-minimal = 0;
define constant $csv-quote-all = 1;
define constant $csv-quote-non-numeric = 2;
define constant $csv-quote-none = 3;

define constant <csv-quoting> = one-of(
  $csv-quote-all,
  $csv-quote-minimal,
  $csv-quote-non-numeric,
  $csv-quote-none);

define class <csv-dialect> (<object>)
  constant slot csv-delimiter :: <string> = ",",
    init-keyword: delimiter:;
  constant slot csv-double-quote? :: <boolean> = #t,
    init-keyword: double-quote:;
  constant slot csv-escape-character :: false-or(<character>) = #f,
    init-keyword: escape-character:;
  constant slot csv-quote-character :: <character> = '"',
    init-keyword: quote-character:;
  constant slot csv-quoting :: <csv-quoting> = $csv-quote-minimal,
    init-keyword: quoting:;
end;

define constant $excel-dialect = make(<csv-dialect>);
define constant $excel-tsv-dialect = make(<csv-dialect>, delimiter: "\t");
