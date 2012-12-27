module: csv
synopsis: Routines for writing CSV files.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define class <csv-writer> (<object>)
  constant slot csv-stream :: <stream>, required-init-keyword: stream:;
  constant slot csv-dialect :: <csv-dialect>, required-init-keyword: dialect:;
end;

define method write-row (writer :: <csv-writer>, row :: <sequence>)
  let stream = csv-stream(writer);
  let dialect = csv-dialect(writer);
  internal-write-row(stream, dialect, row);
end;

define method write-rows (writer :: <csv-writer>, rows)
  let stream = csv-stream(writer);
  let dialect = csv-dialect(writer);
  for (row in rows)
    internal-write-row(stream, dialect, row);
  end for;
end;

define inline function internal-write-row (stream :: <stream>, dialect :: <csv-dialect>, row :: <sequence>)
  for (field in row,
       first? = #t then #f)
    unless (first?)
      write(stream, dialect.csv-delimiter);
    end;
    write(stream, as-csv-string(field));
  end for;
  write(stream, "\r\n");
end;

define generic as-csv-string (field) => (s :: <string>);

define method as-csv-string (field :: <integer>)
 => (s :: <string>)
  integer-to-string(field)
end;

define method as-csv-string (field :: <float>)
 => (s :: <string>)
  float-to-string(field)
end;

define method as-csv-string (field :: <string>)
 => (s :: <string>)
  field
end;

define method as-csv-string (field)
 => (s :: <string>)
   format-to-string("%s", field)
end;
