CLASS ycl_s4d430_0003_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0003_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


* Declarations
    DATA travel TYPE /dmo/travel_id.
   DATA travel2 TYPE /dmo/s_travel_key.
*    DATA travel TYPE /dmo/travel.
    DATA travel3 TYPE /dmo/t_travel.

* Assignments
    travel = '123'.                              "elementary
    travel2 = VALUE #(     travel_id = '123'   ). "structure
    travel3 = VALUE #(  (  travel_id = '123' ) ). "table


  ENDMETHOD.

ENDCLASS.
