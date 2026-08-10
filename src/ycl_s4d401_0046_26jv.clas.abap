CLASS ycl_s4d401_0046_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0046_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.
    CONSTANTS c_connection_id TYPE /dmo/connection_id VALUE '0001'.
    CONSTANTS c_flight_date TYPE /dmo/flight_date VALUE '20270317'.

    TRY.

        DATA(carrier) = NEW lcl_passenger_flight(
          i_carrier_id    = c_carrier_id
          i_connection_id = c_connection_id
          i_flight_date   = c_flight_date
        ).

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
