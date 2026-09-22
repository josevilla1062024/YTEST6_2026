CLASS ycl_s4d430_0001_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0001_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA var TYPE string.

    SELECT FROM /dmo/flight_legacy "/lrn/s4d430_ind
             FIELDS *
               INTO TABLE @DATA(result)
               UP TO 10 ROWS.

    out->write( 'result' ).
    out->write( result ).

  ENDMETHOD.

ENDCLASS.
