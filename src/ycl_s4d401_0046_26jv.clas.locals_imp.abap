*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_carrier DEFINITION.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING i_carrier_id TYPE /dmo/carrier_id
      RAISING   cx_abap_invalid_value.

    METHODS get_name
      RETURNING VALUE(r_result) TYPE /dmo/carrier_name.

    METHODS get_average_free_seats
      IMPORTING carrier_id TYPE /dmo/carrier_id.

    METHODS get_free_seats
      IMPORTING carrier_id      TYPE /dmo/carrier_id
      RETURNING VALUE(r_result) TYPE i
      .

    METHODS get_currency
      RETURNING VALUE(r_result) TYPE /dmo/currency_code.


  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA carrier_data TYPE /dmo/carrier.

ENDCLASS.

CLASS lcl_carrier IMPLEMENTATION.

  METHOD constructor.

*    SELECT SINGLE *
*    FROM /dmo/carrier
*    WHERE carrier_id = @i_carrier_id
*    INTO @me->carrier_data.

    SELECT SINGLE
      FROM /dmo/carrier
*    FIELDS  name, currency_code
      FIELDS concat_with_space( carrier_id, name, 1 ), currency_code
      WHERE carrier_id = @i_carrier_id
      INTO ( @me->carrier_data-name, @me->carrier_data-currency_code ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

  ENDMETHOD.

  METHOD get_name.
    r_result = me->carrier_data-name.
  ENDMETHOD.

  METHOD get_currency.
    r_result = me->carrier_data-currency_code.
  ENDMETHOD.

  METHOD get_average_free_seats.

*  SELECT FROM /dmo/flight
*    FIELDS SUM( seats_max - seats_occupied ) AS sum,
*           COUNT(*) AS count
*    WHERE carrier_id = @carrier_id
*    INTO @DATA(aggregates).
*
* DATA(r_result) = aggregates-sum / aggregates-count.

    SELECT FROM /dmo/flight
       FIELDS CAST( AVG( seats_max - seats_occupied ) AS INT4 )
       WHERE carrier_id = @carrier_id
       INTO @DATA(r_result).

    SELECT FROM /dmo/flight
       FIELDS *
       WHERE carrier_id = @carrier_id
       INTO TABLE @DATA(passenger_flights).


*  r_result = REDUCE #(
*               INIT i = 0
*               FOR flight IN passenger_flights
*               NEXT i = i + flight->get_free_seats( )
*             )
*             / lines( passenger_flights ).

  ENDMETHOD.

  METHOD get_free_seats.

  ENDMETHOD.

ENDCLASS.


CLASS lcl_passenger_flight DEFINITION.

  PUBLIC SECTION.

*    TYPES: BEGIN OF st_flights_buffer,
*             carrier_id     TYPE /dmo/flight-carrier_id,
*             connection_id  TYPE /dmo/flight-connection_id,
*             flight_date    TYPE /dmo/flight-flight_date,
*             plane_type_id  TYPE /dmo/flight-plane_type_id,
*             seats_max      TYPE /dmo/flight-seats_max,
*             seats_occupied TYPE /dmo/flight-seats_occupied,
*             price          TYPE /dmo/flight-price,
*             currency_code  TYPE /dmo/flight-currency_code,
*           END OF st_flights_buffer.

    TYPES: BEGIN OF st_flights_buffer,
             carrier_id     TYPE /dmo/flight-carrier_id,
             connection_id  TYPE /dmo/flight-connection_id,
             flight_date    TYPE /dmo/flight-flight_date,
             plane_type_id  TYPE /dmo/flight-plane_type_id,
             seats_max      TYPE /dmo/flight-seats_max,
             seats_occupied TYPE /dmo/flight-seats_occupied,
             seats_free     TYPE i,
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
      IMPORTING i_carrier_id    TYPE /dmo/carrier_id
                i_connection_id TYPE /dmo/connection_id
                i_flight_date   TYPE /dmo/flight_date
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

*    SELECT
*      FROM /dmo/connection AS c
*      LEFT OUTER JOIN /dmo/airport AS f
*        ON c~airport_from_id = f~airport_id
*      LEFT OUTER JOIN /dmo/airport AS t
*        ON c~airport_to_id = t~airport_id
*      FIELDS carrier_id, connection_id,
*             airport_from_id, airport_to_id, departure_time, arrival_time
**           ,
**           f~timzone AS timzone_from,
**           t~timzone AS timzone_to
*      INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

    DATA(today) = cl_abap_context_info=>get_system_date( ).

*   SELECT
*    FROM /dmo/connection AS c
*    LEFT OUTER JOIN /dmo/airport AS f
*      ON c~airport_from_id = f~airport_id
*    LEFT OUTER JOIN /dmo/airport AS t
*      ON c~airport_to_id = t~airport_id
*    FIELDS carrier_id, connection_id,
*           airport_from_id, airport_to_id,
*           departure_time, arrival_time
**           ,
**           f~timzone AS timezone_from,
**           t~timzone AS timezone_to,
**           tstmp_seconds_between(
**             tstmp1 = dats_tims_to_tstmp(
**                        date  = @today,
**                        time  = c~departure_time,
**                        tzone = f~timzone ),
**             tstmp2 = dats_tims_to_tstmp(
**                        date  = @today,
**                        time  = c~arrival_time,
**                        tzone = t~timzone )
**                                )
*    INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

    SELECT
        FROM /dmo/connection AS c
        LEFT OUTER JOIN /dmo/airport AS f
          ON c~airport_from_id = f~airport_id
        LEFT OUTER JOIN /dmo/airport AS t
          ON c~airport_to_id = t~airport_id
        FIELDS carrier_id, connection_id,
               airport_from_id, airport_to_id,
               departure_time, arrival_time
*           ,
*           f~timzone AS timezone_from,
*           t~timzone AS timezone_to,
*           div(
*             tstmp_seconds_between(
*               tstmp1 = dats_tims_to_tstmp(
*                          date  = @today,
*                          time  = c~departure_time,
*                          tzone = f~timzone ),
*               tstmp2 = dats_tims_to_tstmp(
*                          date = @today,
*                          time = c~arrival_time,
*                          tzone = t~timzone )
*                                  ),
*             60 ) AS duration
        INTO CORRESPONDING FIELDS OF TABLE @connections_buffer.

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

*    SELECT
*        FROM /dmo/flight
*        FIELDS carrier_id, connection_id, flight_date,
*               plane_type_id, seats_max, seats_occupied,
*               price, currency_code
*        WHERE carrier_id = @i_carrier_id
**        INTO TABLE @DATA(keys).
*        INTO CORRESPONDING FIELDS OF TABLE @flights_buffer.

*  SELECT
*    FROM /dmo/flight
*    FIELDS carrier_id, connection_id, flight_date,
*           plane_type_id, seats_max, seats_occupied,
*           seats_max - seats_occupied AS seats_free,
*           price, currency_code
*    WHERE carrier_id = @i_carrier_id
*    INTO CORRESPONDING FIELDS OF TABLE @flights_buffer.

    TRY.

*        SELECT
*            FROM /dmo/flight
*            FIELDS carrier_id, connection_id, flight_date,
*                   plane_type_id, seats_max, seats_occupied,
*                   seats_max - seats_occupied AS seats_free,
*                   currency_conversion(
*                     amount             = price,
*                     source_currency    = currency_code,
*                     target_currency    = 'USD', "@currency,
*                     exchange_rate_date = flight_date,
*                     on_error           =
*                       @sql_currency_conversion=>c_on_error-set_to_null
*                                      ) AS price,
**           @currency
*                   'USD' AS currency_code
*            WHERE carrier_id = @i_carrier_id
*            INTO CORRESPONDING FIELDS OF TABLE @flights_buffer.

*        SELECT
*            FROM /dmo/flight
*            FIELDS carrier_id, connection_id, flight_date,
*                   plane_type_id, seats_max, seats_occupied,
*                   seats_max - seats_occupied AS seats_free,
*                   currency_conversion(
*                     amount             = price,
*                     source_currency    = currency_code,
*                     target_currency    = 'USD', "@currency,
*                     exchange_rate_date = flight_date,
*                     on_error           =
*                       @sql_currency_conversion=>c_on_error-set_to_null
*                                      ) AS price,
**           @currency AS currency_code
*                   'USD' AS currency_code
*            WHERE carrier_id = @i_carrier_id
*            ORDER BY flight_date ASCENDING
*            INTO CORRESPONDING FIELDS OF TABLE @flights_buffer.

        IF NOT line_exists( flights_buffer[ carrier_id = i_carrier_id ] ).

          SELECT
            FROM /dmo/flight
            FIELDS carrier_id, connection_id, flight_date,
                   plane_type_id, seats_max, seats_occupied,
                   seats_max - seats_occupied AS seats_free,
                   currency_conversion(
                     amount             = price,
                     source_currency    = currency_code,
                     target_currency    = 'USD', "@currency,
                     exchange_rate_date = flight_date,
                     on_error           =
                       @sql_currency_conversion=>c_on_error-set_to_null
                                      ) AS price,
*           @currency AS currency_code
                   'USD' AS currency_code
            WHERE carrier_id = @i_carrier_id
*          ORDER BY flight_date ASCENDING
*    INTO TABLE @flights_buffer.
            APPENDING CORRESPONDING FIELDS OF TABLE @flights_buffer.

          SORT flights_buffer BY carrier_id connection_id flight_date.
*    DELETE ADJACENT DUPLICATES FROM flights_buffer
*      COMPARING carrier_id connection_id flight_date.

        ENDIF.

      CATCH cx_root.
    ENDTRY.



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

*  LOOP AT flights_buffer INTO DATA(flight)
*    WHERE carrier_id = i_carrier_id.
*
*    APPEND NEW lcl_passenger_flight( i_carrier_id    = flight-carrier_id
*                                     i_connection_id = flight-connection_id
*                                     i_flight_date   = flight-flight_date )
*      TO r_result.
*  ENDLOOP.

    DATA(r_result2) = flights_buffer[].

    CLEAR r_result2[].

*r_result2 = VALUE #(
*             FOR flight IN flights_buffer
*               WHERE ( carrier_id = i_carrier_id ) (
*                 NEW lcl_passenger_flight(
*                       i_carrier_id    = flight-carrier_id
*                       i_connection_id = flight-connection_id
*                       i_flight_date   = flight-flight_date
*                       )
*                                                   )
*           ).

  ENDMETHOD.

  METHOD constructor.

*    SELECT SINGLE
*        FROM /dmo/flight
*        FIELDS plane_type_id, seats_max, seats_occupied,
*               price, currency_code
*        WHERE carrier_id    = @i_carrier_id
**      AND connection_id = @i_connection_id
**      AND flight_date   = @i_flight_date
*        INTO @DATA(lwa_flight).

*  SELECT SINGLE
*    FROM /dmo/flight
*    FIELDS plane_type_id,
*           seats_max, seats_occupied,
*           seats_max - seats_occupied AS seats_free,
*           price, currency_code
*    WHERE carrier_id    = @i_carrier_id
**      AND connection_id = @i_connection_id
**      AND flight_date   = @i_flight_date
**    INTO CORRESPONDING FIELDS OF @flight_raw.
*    INTO @DATA(flight_raw).

    TRY.

        SELECT SINGLE
            FROM /dmo/flight
            FIELDS plane_type_id,
                   seats_max, seats_occupied,
                   seats_max - seats_occupied AS seats_free,
*           price,
                   currency_conversion(
                     amount             = price,
                     source_currency    = currency_code,
                     target_currency    = 'USD', "@currency,
                     exchange_rate_date = flight_date,
                     on_error           =
                       @sql_currency_conversion=>c_on_error-set_to_null
                                      ) AS price,
*           currency_code
*           @currency AS currency_code
                   'USD' AS currency_code
            WHERE carrier_id    = @i_carrier_id
*      AND connection_id = @i_connection_id
*      AND flight_date   = @i_flight_date
*    INTO CORRESPONDING FIELDS OF @flight_raw.
            INTO @DATA(flight_raw).

      CATCH cx_root.
    ENDTRY.

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

    DATA(planetype) = flight_raw-plane_type_id.
    DATA(seats_max) = flight_raw-seats_max.
    DATA(seats_occ) = flight_raw-seats_occupied.
*  seats_free = flight_raw-seats_max - flight_raw-seats_occupied.
    DATA(seats_free) = flight_raw-seats_free.

  ENDMETHOD.

  METHOD get_description.

*  APPEND |Duration:       { connection_details-duration } minutes| TO r_result.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_cargo_flight DEFINITION.

  PUBLIC SECTION.

*    TYPES: BEGIN OF st_flights_buffer,
*             include TYPE ys4d401_cargofli,
*           END OF st_flights_buffer.

    CLASS-DATA: flights_buffer TYPE TABLE OF ys4d401_cargofli.

    METHODS constructor.

    METHODS get_flights_by_carrier
      IMPORTING i_carrier_id TYPE /dmo/carrier_id.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_cargo_flight IMPLEMENTATION.

  METHOD constructor.


  ENDMETHOD.

  METHOD get_flights_by_carrier.

    SELECT
      FROM ys4d401_cargofli "/dmo/flight
      FIELDS carrier_id, connection_id, flight_date,
*           plane_type_id,
             maximum_load, actual_load,
*           load_unit,
             airport_from_id, airport_to_id
*           ,
*           departure_time,
*           arrival_time
      WHERE carrier_id = @i_carrier_id
      ORDER BY flight_date ASCENDING
      INTO CORRESPONDING FIELDS OF TABLE @flights_buffer.

  ENDMETHOD.

ENDCLASS.
