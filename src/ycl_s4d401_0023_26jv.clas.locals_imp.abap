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

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

    METHODS get_average_free_seats
      RETURNING VALUE(r_output) TYPE i.

    METHODS  get_description
    RETURNING VALUE(r_result) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA carrier_data TYPE /dmo/carrier.

    DATA passenger_flights TYPE STANDARD TABLE OF /dmo/flight.

    DATA cargo_flights TYPE STANDARD TABLE OF /dmo/flight.

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

  METHOD get_output.

    APPEND |------------------------------| TO r_output.
    APPEND |{ 'Carrier Name:'(001) } { me->carrier_data-name }| TO r_output.
    APPEND |{ 'Passenger Flights:'(002)  } { lines( passenger_flights ) }| TO r_output.
    APPEND |{ 'Average free seats:'(003) } { get_average_free_seats( )  }| TO r_output.
    APPEND |{ 'Cargo Flights:'(004)      } { lines( cargo_flights )     }| TO r_output.

  ENDMETHOD.

  METHOD get_average_free_seats.
    r_output = r_output + 1.
  ENDMETHOD.

  METHOD get_description.

  DATA text TYPE string.

    text = 'Flight &carrid& &connid& on &date& from &from& to &to&'(005).
    text = replace( val = text sub = '&carrid&' with = me->carrier_data-carrier_id ).
*    text = replace( val = text sub = '&connid&' with = me->carrier_data-connection_id ).
*  txt = replace( val = txt sub = '&date&'   with = |{ flight_date DATE = USER }| ).
*  txt = replace( val = txt sub = '&from&'   with = connection_details-airport_from_id ).
*  txt = replace( val = txt sub = '&to&'     with = connection_details-airport_to_id ).

  APPEND text TO r_result.

*    APPEND |{ 'Planetype:'(006)      } { planetype  }| TO r_result.
*    APPEND |{ 'Maximum Seats:'(007)  } { seats_max  }| TO r_result.
*    APPEND |{ 'Occupied Seats:'(008) } { seats_occ  }| TO r_result.
*    APPEND |{ 'Free Seats:'(009)     } { seats_free }| TO r_result.
*    APPEND |{ 'Ticket Price:'(010)   } { price CURRENCY = currency } { currency }| TO r_result.
*
*    APPEND |{ 'Duration:'(011)       } { connection_details-duration } { 'minutes'(012) }| TO r_result.

  ENDMETHOD.

ENDCLASS.
