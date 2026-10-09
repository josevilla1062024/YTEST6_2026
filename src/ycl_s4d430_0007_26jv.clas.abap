CLASS ycl_s4d430_0007_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0007_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


* Data selection
**********************************************************************

    SELECT FROM /dmo/i_connection_R
         FIELDS Airlineid,
                connectionid,

*                 _Airline.Name,
                \_Airline-Name,
*                 _Airline-Name,
*                 _Airline~Name,
*                \_Airline~Name,
*
*                \_Airline-_Currency-CurrencyISOCode,
*                \_Airline-\_Currency-CurrencyISOCode,
                \_Airline\_Currency-CurrencyISOCode,
*                \_Airline~\_Currency~CurrencyISOCode,
*                \_Airline\_Currency~CurrencyISOCode,
*
                \_Airline\_Currency\_Text[                     Language = 'E' ]-CurrencyShortName AS CurrencyNameEN,
                \_Airline\_Currency\_Text[   MANY TO ONE WHERE Language = 'D' ]-CurrencyShortName AS CurrencyNameDE,
*                \_Airline\_Currency\_Text[                     Language = 'E' ]-CurrencyShortName AS CurrencyNameEN,
*                \_Airline-\_Currency-\_Text[ MANY TO ONE WHERE Language = 'D' ]-CurrencyShortName AS CurrencyNameDE,
*                \_Airline~\_Currency~\_Text[ 1:                Language = 'E' ]-CurrencyShortName AS CurrencyNameEN,
                DepartureAirport,
                DestinationAirport

         INTO TABLE @DATA(result).

* Output
**********************************************************************
    out->write(  data = result
                 name = 'Selection result' ).


  ENDMETHOD.

ENDCLASS.
