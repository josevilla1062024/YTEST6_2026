CLASS ycl_s4d401_0036_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_S4D401_0036_26JV IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.

    TRY.

        DATA(carrier) = NEW lcl_passenger_flight( c_carrier_id ).

        DATA(flight_raw) = carrier->get_flights_by_carrier( c_carrier_id ).

        out->write( 'Flights_by_carrier' ).
        out->write( flight_raw ).

      CATCH cx_abap_invalid_value.
        out->write( | Carrier { c_carrier_id } does not exist | ).
    ENDTRY.

    TRY.

        DATA(carrier2) = NEW lcl_carrier( c_carrier_id ).

        out->write( | Carrier { carrier2->get_name(  ) } has currency { carrier2->get_currency( ) }| ).

      CATCH cx_abap_invalid_value.
        out->write( | Carrier { c_carrier_id } does not exist | ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
