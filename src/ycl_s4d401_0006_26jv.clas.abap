CLASS ycl_s4d401_0006_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0006_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(flights) = lcl_data=>get_flights(  ).

    SORT flights BY flight_date DESCENDING.

    out->write(
      EXPORTING
        data   = flights
        name   = 'List of all Flights'
*  RECEIVING
*    output =
    ).

  ENDMETHOD.

ENDCLASS.
