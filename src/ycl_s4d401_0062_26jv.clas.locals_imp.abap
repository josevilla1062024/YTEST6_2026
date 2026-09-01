*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
INTERFACE lif_output.
   TYPES t_output  TYPE string.
   TYPES tt_output TYPE STANDARD TABLE OF t_output
                          WITH NON-UNIQUE DEFAULT KEY.
   METHODS get_output
     RETURNING
       VALUE(r_result) TYPE tt_output.
 ENDINTERFACE.

 CLASS lcl_flight DEFINITION ABSTRACT.

   PUBLIC SECTION.
     INTERFACES lif_output.

    ALIASES get_output for lif_output~get_output.

     TYPES: BEGIN OF st_connection_details,
              airport_from_id TYPE /dmo/airport_from_id,
              airport_to_id   TYPE /dmo/airport_to_id,
              departure_time  TYPE /dmo/flight_departure_time,
              arrival_time    TYPE /dmo/flight_departure_time,
              duration        TYPE i,
            END OF st_connection_details.

     DATA carrier_id    TYPE /dmo/carrier_id    READ-ONLY.
     DATA connection_id TYPE /dmo/connection_id READ-ONLY.
     DATA flight_date   TYPE /dmo/flight_date   READ-ONLY.

     METHODS constructor IMPORTING iv_carrier_id    TYPE /dmo/carrier_id
                                   iv_connection_id TYPE /dmo/connection_id
                                   iv_flight_date   TYPE /dmo/flight_date.

      METHODS: get_connection_details
        RETURNING
          VALUE(r_result) TYPE st_connection_details.

     METHODS get_description
       RETURNING
         VALUE(r_result) TYPE string_table.

   PROTECTED SECTION.
     DATA planetype          TYPE /dmo/plane_type_id.
     DATA connection_details TYPE st_connection_details.

 ENDCLASS.

 CLASS lcl_flight IMPLEMENTATION.

   METHOD lif_output~get_output.
     r_result = get_description( ).
   ENDMETHOD.

   METHOD get_description.
     DATA txt TYPE string.

     txt = 'Flight &carrid& &connid& on &date& from &from& to &to&'(005).
     txt = replace( val = txt sub = '&carrid&' with = carrier_id ).
     txt = replace( val = txt sub = '&connid&' with = connection_id ).
     txt = replace( val = txt sub = '&date&'   with = |{ flight_date DATE = USER }| ).
     txt = replace( val = txt sub = '&from&'   with = connection_details-airport_from_id ).
     txt = replace( val = txt sub = '&to&'     with = connection_details-airport_to_id ).

     APPEND txt TO r_result.
     APPEND |{ 'Planetype:'(006)      } { planetype }| TO r_result.
   ENDMETHOD.

   METHOD constructor.
     me->carrier_id    = iv_carrier_id.
     me->connection_id = iv_connection_id.
     me->flight_date   = iv_flight_date.
   ENDMETHOD.

    METHOD get_connection_details.

      SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id, departure_time, arrival_time
      WHERE carrier_id = @carrier_id
        AND connection_id = @connection_id
        INTO CORRESPONDING FIELDS OF  @r_result.

    ENDMETHOD.

 ENDCLASS.

 CLASS lcl_carrier DEFINITION.

   PUBLIC SECTION.
     INTERFACES lif_output.

     ALIASES: get_output FOR lif_output~get_output.

     METHODS get_average_free_seats RETURNING VALUE(r_result) TYPE i.

   PRIVATE SECTION.
     DATA: name TYPE string.
     DATA: pf_count TYPE i.
     DATA: cf_count TYPE i.

 ENDCLASS.

 CLASS lcl_carrier IMPLEMENTATION.

   METHOD lif_output~get_output.

     APPEND |{ 'Carrier Name:'(001)       } { me->name }| TO r_result.
     APPEND |{ 'Passenger Flights:'(002)  } { pf_count }| TO r_result.
     APPEND |{ 'Average free seats:'(003) } { get_average_free_seats(  ) }| TO r_result.
     APPEND |{ 'Cargo Flights:'(004)      } { cf_count }| TO r_result.

   ENDMETHOD.

   METHOD get_average_free_seats.
     r_result = 5.
   ENDMETHOD.

 ENDCLASS.

   CLASS lcl_passenger_flight DEFINITION INHERITING FROM lcl_flight.

    PUBLIC SECTION.
      METHODS constructor IMPORTING iv_carrier_id    TYPE /dmo/carrier_id
                                    iv_connection_id TYPE /dmo/connection_id
                                    iv_flight_date   TYPE /dmo/flight_date
                                    iv_seats         TYPE i.

      METHODS: get_connection_details REDEFINITION.

    PRIVATE SECTION.
      DATA seats TYPE i.

  ENDCLASS.

  CLASS lcl_passenger_flight IMPLEMENTATION.

    METHOD constructor.

      super->constructor( iv_carrier_id = iv_carrier_id iv_connection_id = iv_connection_id iv_flight_date = iv_flight_date ).
      seats = iv_seats.
    ENDMETHOD.

    METHOD get_connection_details.

      SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id, departure_time, arrival_time
      WHERE carrier_id = @carrier_id
        INTO CORRESPONDING FIELDS OF  @r_result.

    ENDMETHOD.

  ENDCLASS.

  CLASS lcl_cargo_flight DEFINITION INHERITING FROM lcl_flight.

    PUBLIC SECTION.
      METHODS constructor IMPORTING iv_carrier_id    TYPE /dmo/carrier_id
                                    iv_connection_id TYPE /dmo/connection_id
                                    iv_flight_date   TYPE /dmo/flight_date
                                    iv_cargo         TYPE i.

      METHODS get_description REDEFINITION.

      METHODS get_free_capacity RETURNING VALUE(r_result) TYPE i.

    PRIVATE SECTION.
      DATA cargo TYPE i.
      DATA maximum_load TYPE string.
      DATA load_unit TYPE string.

  ENDCLASS.

  CLASS lcl_cargo_flight IMPLEMENTATION.

    METHOD constructor.

      super->constructor( iv_carrier_id = iv_carrier_id iv_connection_id = iv_connection_id iv_flight_date = iv_flight_date ).
      cargo = iv_cargo.
    ENDMETHOD.

    METHOD get_description.

      r_result = super->get_description( ).

      APPEND |Maximum Load:  { maximum_load         } { load_unit }| TO r_result.
      APPEND |Free Capacity: { get_free_capacity( ) } { load_unit }| TO r_result.

    ENDMETHOD.

    METHOD get_free_capacity.
      r_result = 5.

    ENDMETHOD.

  ENDCLASS.
