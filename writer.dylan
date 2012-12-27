module: csv
synopsis: Routines for reading CSV files.
author: Bruce Mitchener
copyright: 2012, Data Fueled, LLC.

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

define inline function internal-write-row(stream :: <stream>, dialect :: <csv-dialect>, row :: <sequence>)
  for (field in row,
       first? = #t then #f)
    unless (first?)
      write(stream, dialect.delimiter);
    end;
    write(stream, to-csv-string(field));
  end for;
  write(stream, "\r\n");
end;

define function to-csv-string(field :: <object>) => (s :: <string>)
  select (field by instance?)
    <integer> => integer-to-string(field);
    <float> => float-to-string(field);
    <string> => field;
    otherwise => error("invalid datatype");
  end;
end;
