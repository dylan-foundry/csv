module: dylan-user

define library csv-test-suite
  use common-dylan;
  use io;
  use csv;
  use testworks;

  export csv-test-suite;
end library;

define module csv-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use csv;
  use testworks;

  export csv-test-suite;
end module;
