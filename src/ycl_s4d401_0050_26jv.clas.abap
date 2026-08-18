CLASS ycl_s4d401_0050_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_S4D401_0050_26JV IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Run this class using the ABAP Profiler to measure relative access times for standard, sorted, and hashed tables


    DATA(flights) = NEW lcl_flights( ).
    flights->access_standard( ).
    flights->access_sorted( ).
    flights->access_hashed( ).


    out->write( |Done| ).

  ENDMETHOD.
ENDCLASS.
