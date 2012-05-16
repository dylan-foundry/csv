module: csv
synopsis: Routines for reading CSV files.
author: Bruce Mitchener
copyright: 2012, Data Fueled, LLC.

define class <csv-writer> (<object>)
  constant slot csv-stream :: <stream>;
  constant slot csv-dialect :: <csv-dialect>;
end;

define method write-row (writer :: <csv-writer>, row)
end;

define method write-rows (writer :: <csv-writer>, rows)
end;