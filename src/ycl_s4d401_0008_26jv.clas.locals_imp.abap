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

    METHODS get_currency
      RETURNING VALUE(r_result) TYPE /dmo/currency_code.

    METHODS find_cargo_flight
      IMPORTING i_airport_from_id TYPE /dmo/airport_from_id
                i_airport_to_id   TYPE /dmo/airport_to_id
                i_from_date       TYPE /dmo/flight_date
                i_cargo           TYPE i
      EXPORTING
                e_flight          TYPE string
                e_days_later      TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA carrier_data TYPE /dmo/carrier.

ENDCLASS.

CLASS lcl_carrier IMPLEMENTATION.

  METHOD constructor.

    SELECT SINGLE *
    FROM /dmo/carrier
    WHERE carrier_id = @i_carrier_id
    INTO @me->carrier_data.

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

  METHOD find_cargo_flight.

    SELECT
    a~*
    FROM ys4d401_cargofli AS a
    WHERE a~airport_from_id = @i_airport_from_id
    AND   a~airport_to_id = @i_airport_to_id
    AND   a~flight_date = @i_from_date
    INTO TABLE @DATA(lti_cargo).

    IF ( lines( lti_cargo[] ) <> 0 ).

      READ TABLE lti_cargo INTO DATA(lwa_cargo) INDEX 1.
      IF sy-subrc = 0.
*  DATA(days_later) = i_from_date - flight->flight_date.
        DATA(days_later) = lwa_cargo-flight_date - i_from_date.
        e_days_later = days_later.

      ELSE.
        e_days_later = 0.
      ENDIF.

      e_flight = 'Prueba con exito'.

    ELSE.
      e_flight = 'Prueba con error'.
      e_days_later = 0.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
