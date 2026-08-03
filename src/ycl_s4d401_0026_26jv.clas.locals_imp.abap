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

*    TYPES:
*      BEGIN OF st_connections_buffer,
*        carrier_id      TYPE /dmo/carrier_id,
*        connection_id   TYPE /dmo/connection_id,
*        airport_from_id TYPE /dmo/airport_from_id,
*        airport_to_id   TYPE /dmo/airport_to_id,
*        departure_time  TYPE /dmo/flight_departure_time,
*        arrival_time    TYPE /dmo/flight_departure_time,
*        duration        TYPE i,
*      END OF st_connections_buffer.

    TYPES:
      BEGIN OF st_connections_buffer,
        carrier_id      TYPE /dmo/carrier_id,
        connection_id   TYPE /dmo/connection_id,
        airport_from_id TYPE /dmo/airport_from_id,
        airport_to_id   TYPE /dmo/airport_to_id,
        departure_time  TYPE /dmo/flight_departure_time,
        arrival_time    TYPE /dmo/flight_departure_time,
        timzone_from    TYPE timezone,
        timzone_to      TYPE timezone,
        duration        TYPE i,
      END OF st_connections_buffer.

    TYPES:
      BEGIN OF st_connection_details,
        airport_from_id TYPE /dmo/airport_from_id,
        airport_to_id   TYPE /dmo/airport_to_id,
        departure_time  TYPE /dmo/flight_departure_time,
        arrival_time    TYPE /dmo/flight_departure_time,
        duration        TYPE i,
      END OF st_connection_details.

    CLASS-DATA: flights_buffer TYPE TABLE OF st_flights_buffer.
    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING i_carrier_id TYPE /dmo/carrier_id
      RAISING   cx_abap_invalid_value.

    METHODS get_flights_by_carrier
      IMPORTING i_carrier_id    TYPE /dmo/carrier_id
      RETURNING VALUE(r_result) TYPE st_flights_buffer
      .

    METHODS get_description
      RETURNING VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA: connections_buffer TYPE TABLE OF st_connections_buffer.
    CLASS-DATA: connection_details TYPE TABLE OF st_connections_buffer.

ENDCLASS.

CLASS lcl_passenger_flight IMPLEMENTATION.

  METHOD class_constructor.

*    SELECT
*          FROM /dmo/airport
*          FIELDS airport_id
**      , timzone
*          INTO TABLE @DATA(airports).


*    SELECT
*          FROM /dmo/connection
*          FIELDS carrier_id, connection_id,
*                 airport_from_id, airport_to_id, departure_time, arrival_time
*          INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

*  SELECT
*    FROM /dmo/connection AS c
*    FIELDS carrier_id, connection_id,
*           airport_from_id, airport_to_id, departure_time, arrival_time
*    INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

*  SELECT
*    FROM /dmo/connection AS c
*    LEFT OUTER JOIN /dmo/airport AS f
*    ON c~airport_from_id = f~airport_id
*    FIELDS carrier_id, connection_id,
*           airport_from_id, airport_to_id, departure_time, arrival_time
*    INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

*  SELECT
*    FROM /dmo/connection AS c
*    LEFT OUTER JOIN /dmo/airport AS f
*      ON c~airport_from_id = f~airport_id
*    LEFT OUTER JOIN /dmo/airport AS t
*      ON c~airport_to_id = t~airport_id
*    FIELDS carrier_id, connection_id,
*           airport_from_id, airport_to_id, departure_time, arrival_time
*    INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

    SELECT
      FROM /dmo/connection AS c
      LEFT OUTER JOIN /dmo/airport AS f
        ON c~airport_from_id = f~airport_id
      LEFT OUTER JOIN /dmo/airport AS t
        ON c~airport_to_id = t~airport_id
      FIELDS carrier_id, connection_id,
             airport_from_id, airport_to_id, departure_time, arrival_time
*           ,
*           f~timzone AS timzone_from,
*           t~timzone AS timzone_to
      INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

    DATA(today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT connections_buffer INTO DATA(connection).

* CONVERT DATE today
*      TIME connection-departure_time
**      TIME ZONE airports[ airport_id = connection-airport_from_id ]-timzone
*      INTO UTCLONG DATA(departure_utclong).

      CONVERT DATE today
        TIME connection-departure_time
*    TIME ZONE airports[ airport_id = connection-airport_from_id ]-timzone
        TIME ZONE connection-timzone_from
        INTO UTCLONG DATA(departure_utclong).

* CONVERT DATE today
*      TIME connection-arrival_time
*      TIME ZONE airports[ airport_id = connection-airport_to_id ]-timzone
*      INTO UTCLONG DATA(arrival_utclong).

      CONVERT DATE today
        TIME connection-arrival_time
*    TIME ZONE airports[ airport_id = connection-airport_to_id ]-timzone
        TIME ZONE connection-timzone_to
        INTO UTCLONG DATA(arrival_utclong).

      connection-duration = utclong_diff(
                                  high = arrival_utclong
                                  low  = departure_utclong
                                             ) / 60.

      MODIFY connections_buffer FROM connection TRANSPORTING duration.

    ENDLOOP.

  ENDMETHOD.

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


*  SELECT SINGLE
*    FROM /lrn/connection
*    FIELDS airport_from_id, airport_to_id,
*           departure_time, arrival_time
*    WHERE carrier_id    = @carrier_id
*      AND connection_id = @connection_id
*    INTO @connection_details.

*  connection_details = CORRESPONDING #(
*                         connections_buffer[
*                           carrier_id    = i_carrier_id
*                           connection_id = ''
*                           ]
*                                      ).

    MOVE-CORRESPONDING connections_buffer[] TO connection_details[].

  ENDMETHOD.

  METHOD get_description.

*  APPEND |Duration:       { connection_details-duration } minutes| TO r_result.

  ENDMETHOD.

ENDCLASS.
