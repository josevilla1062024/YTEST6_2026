*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_data DEFINITION.

  PUBLIC SECTION.

    "Estructuras
    TYPES: BEGIN OF gtyt_flights.
             INCLUDE TYPE /dmo/flight.
    TYPES: END   OF gtyt_flights.

    "Tipos
    TYPES: gtyd_flights TYPE STANDARD TABLE OF gtyt_flights WITH DEFAULT KEY.

    CLASS-METHODS get_flights
      RETURNING VALUE(flights) TYPE gtyd_flights.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_data IMPLEMENTATION.

  METHOD get_flights.

    SELECT
    a~*
    FROM /dmo/flight AS a
    INTO CORRESPONDING FIELDS OF TABLE @flights
    UP TO 50 ROWS.

  ENDMETHOD.

ENDCLASS.
