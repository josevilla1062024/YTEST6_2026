CLASS ycl_s4d401_0007_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0007_26jv IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(connections) = lcl_data=>get_connections( ).

    SORT connections BY carrier_id ASCENDING
                        connection_id ASCENDING.

    LOOP AT connections INTO DATA(connection).

      DATA(city_from) = lcl_data=>get_airport_city( connection-airport_from_id  ).
      DATA(city_to) = lcl_data=>get_airport_city( connection-airport_to_id  ).

      DATA(text) = |Flight { connection-carrier_id } { connection-connection_id } | &&
                   |from { city_from } to { city_to }  |.


      out->write( '----------------------------------------------------------------------' ).
      out->write( text ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
