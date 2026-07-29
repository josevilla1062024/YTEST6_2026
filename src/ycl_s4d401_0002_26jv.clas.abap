CLASS ycl_s4d401_0002_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0002_26jv IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Create a reference to the abstract superclass
    DATA lo_flight TYPE REF TO lcl_flight.

    " 2. Instantiate and test the passenger flight
    lo_flight = NEW lcl_passenger_flight(
        iv_carrier_id    = 'LH'
        iv_connection_id = '0400'
        iv_flight_date   = cl_abap_context_info=>get_system_date(  )
        iv_seats         = 350
       ).

    out->write( |---- Passenger Flight Details ----| ).
    out->write( lo_flight->get_description(  ) ).

    out->write( cl_abap_char_utilities=>newline ).  "Creates a new blank line

    " 3. Instantiate and test the cargo flight
    lo_flight = NEW lcl_cargo_flight(
       iv_carrier_id    = 'LH'
       iv_connection_id = '8400'
       iv_flight_date   =  cl_abap_context_info=>get_system_date(  )
       iv_cargo_weight  = 45
     ).

    out->write( |---- Cargo Flight Details ----| ).
    out->write( lo_flight->get_description(  ) ).
  ENDMETHOD.

ENDCLASS.
