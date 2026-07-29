*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

*"--------------------------------------------------------------
*" SUPERCLASS: LCL_FLIGHT(ABSTRACT CLASS)
*"--------------------------------------------------------------
CLASS lcl_flight DEFINITION ABSTRACT.

  PUBLIC SECTION.
    TYPES: BEGIN OF st_connection_details,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             departure_time  TYPE /dmo/flight_departure_time,
             arrival_time    TYPE /dmo/flight_departure_time,
             duration        TYPE i,
           END OF st_connection_details.

    DATA carrier_id    TYPE /dmo/carrier_id READ-ONLY.
    DATA connection_id TYPE /dmo/connection_id READ-ONLY.
    DATA flight_date   TYPE /dmo/flight_date READ-ONLY.

    DATA currency_code TYPE /dmo/currency_code.
*DATA currency_code TYPE /dmo/currency_code ##NEEDED.

    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE /dmo/carrier_id
        iv_connection_id TYPE /dmo/connection_id
        iv_flight_date   TYPE /dmo/flight_date.

    METHODS get_connection_details
      RETURNING VALUE(r_result) TYPE st_connection_details.

    METHODS get_description
      RETURNING VALUE(r_result) TYPE string_table.

  PROTECTED SECTION.

    DATA planetype TYPE /dmo/plane_type_id.
    DATA connection_details TYPE st_connection_details.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_flight IMPLEMENTATION.

  METHOD constructor.
    carrier_id = iv_carrier_id.
    connection_id = iv_connection_id.
    flight_date = iv_flight_date.
  ENDMETHOD.

  METHOD get_connection_details.
    r_result = connection_details.
  ENDMETHOD.

  METHOD get_description.
    " Common flight detail descriptions
    APPEND |Flight: { carrier_id } { connection_id } on { flight_date }| TO r_result.
    APPEND |Plane type: { planetype }| TO r_result.
  ENDMETHOD.

ENDCLASS.


*"------------------------------------------------------------
*"  SUBCLASS: LCL_PASSANGER_FLIGHT
*"------------------------------------------------------------

CLASS lcl_passenger_flight DEFINITION INHERITING FROM lcl_flight.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE /dmo/carrier_id
        iv_connection_id TYPE /dmo/connection_id
        iv_flight_date   TYPE /dmo/flight_date
        iv_seats         TYPE i.

    METHODS get_description REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA seats TYPE i.

ENDCLASS.

CLASS lcl_passenger_flight IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_carrier_id = iv_carrier_id iv_connection_id = iv_connection_id iv_flight_date = iv_flight_date ).
    seats = iv_seats.
    planetype = 'A350'. "Example initialization
  ENDMETHOD.

  METHOD get_description.
    " Fetch base description from the superclass
    r_result = super->get_description(  ).
    " Append specific passenger details
    APPEND |Passenger seats: { seats } | TO r_result.
  ENDMETHOD.

ENDCLASS.


*"-----------------------------------------------------------
*" SUPERCLASS: LCL_CARGO_PLANE
*"-----------------------------------------------------------

CLASS lcl_cargo_flight DEFINITION INHERITING FROM lcl_flight.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE /dmo/carrier_id
        iv_connection_id TYPE /dmo/connection_id
        iv_flight_date   TYPE /dmo/flight_date
        iv_cargo_weight  TYPE i.

    METHODS get_description REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA cargo_weight TYPE i.
ENDCLASS.

CLASS lcl_cargo_flight IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_carrier_id = iv_carrier_id iv_connection_id = iv_connection_id iv_flight_date = iv_flight_date ).
    cargo_weight = iv_cargo_weight.
    planetype = 'B77F'. " Example initialization
  ENDMETHOD.

  METHOD get_description.
    " fetch base description from the superclass
    r_result = super->get_description(  ).
    " Append specific cargo details
    APPEND |Cargo capacity: { cargo_weight } | TO r_result.
  ENDMETHOD.

ENDCLASS.
