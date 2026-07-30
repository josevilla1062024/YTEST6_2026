*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_passenger_flight DEFINITION.

  PUBLIC SECTION.

    TYPES: BEGIN OF st_flights_buffer,
             carrier_id     TYPE /dmo/flight-carrier_id,
             connection_id  TYPE /dmo/flight-connection_id,
             flight_date    TYPE /dmo/flight-flight_date,
             plane_type_id  TYPE /dmo/flight-plane_type_id,
             seats_max      TYPE /dmo/flight-seats_max,
             seats_occupied TYPE /dmo/flight-seats_occupied,
             price          TYPE /dmo/flight-price,
             currency_code  TYPE /dmo/flight-currency_code,
           END OF st_flights_buffer.

    CLASS-DATA: flights_buffer TYPE TABLE OF st_flights_buffer.

    METHODS constructor
      IMPORTING i_carrier_id TYPE /dmo/carrier_id
      RAISING   cx_abap_invalid_value.

    METHODS get_flights_by_carrier
      IMPORTING i_carrier_id    TYPE /dmo/carrier_id
      RETURNING VALUE(r_result) TYPE st_flights_buffer
      .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_passenger_flight IMPLEMENTATION.

  METHOD get_flights_by_carrier.

    DATA: lwa_flights TYPE st_flights_buffer.

    SELECT
        FROM /dmo/flight
        FIELDS carrier_id, connection_id, flight_date,
               plane_type_id, seats_max, seats_occupied,
               price, currency_code
        WHERE carrier_id = @i_carrier_id
*        INTO TABLE @DATA(keys).
        INTO TABLE @flights_buffer.

    CLEAR lwa_flights.
    READ TABLE flights_buffer INTO lwa_flights INDEX 1.

    TRY.
        DATA(flight_raw) = flights_buffer[ carrier_id    = lwa_flights-carrier_id
                                           connection_id = lwa_flights-connection_id
                                           flight_date   = lwa_flights-flight_date ].
      CATCH cx_sy_itab_line_not_found.
        SELECT SINGLE
          FROM /dmo/flight
          FIELDS plane_type_id, seats_max, seats_occupied,
                 price, currency_code
          WHERE carrier_id    = @i_carrier_id
*          AND connection_id = @i_connection_id
*          AND flight_date   = @i_flight_date
          INTO CORRESPONDING FIELDS OF @flight_raw.
    ENDTRY.

    MOVE-CORRESPONDING flight_raw TO r_result.

  ENDMETHOD.

  METHOD constructor.

    SELECT SINGLE
        FROM /dmo/flight
        FIELDS plane_type_id, seats_max, seats_occupied,
               price, currency_code
        WHERE carrier_id    = @i_carrier_id
*      AND connection_id = @i_connection_id
*      AND flight_date   = @i_flight_date
        INTO @DATA(lwa_flight).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
