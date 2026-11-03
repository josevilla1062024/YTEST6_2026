CLASS ycl_fill_city_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_fill_city_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lt_cities TYPE TABLE OF ycity_texts_26jv.

    DELETE FROM ycity_texts_26jv.

*    SELECT DISTINCT airport_id, city FROM /dmo/airport
*    INTO CORRESPONDING FIELDS OF TABLE @lt_cities.

    MODIFY ycity_texts_26jv FROM ( SELECT DISTINCT airport_id, city FROM /dmo/airport ).

*    MODIFY ycity_texts_26jv FROM TABLE @lt_cities.

    out->write( |Records inserted: { sy-dbcnt }| ).

  ENDMETHOD.

ENDCLASS.
