module: dylan-user

define library csv
  use common-dylan;
  use io;

  export csv;
end library;

define module csv
  use common-dylan;
  use streams;

  export <csv-reader>;

  export <csv-writer>, write-row, write-rows;
end module;
