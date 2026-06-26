CLASS ycl_art_001_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    "Estructuras
    TYPES: BEGIN OF gtyt_articulo.
             INCLUDE TYPE ytab_arts_26jv.
    TYPES: END   OF gtyt_articulo.

    "Tipos
    TYPES: gtyd_articulo TYPE STANDARD TABLE OF gtyt_articulo WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_art_001_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lti_articulo TYPE gtyd_articulo.


    lti_articulo = VALUE #(
    (
    client = sy-mandt
    id_art = '1'
    descr = 'Mini colores'
    desc2 = 'Un mini estuche, con mini colores'
    color = 'varios'
    piezas = 12
    stock = 10
    url = 'https://lalibreteria.mx/cdn/shop/files/la-libreteria-blackwing-volumen-343-06_600x.jpg?v=1777420902'
     )

    (
    client = sy-mandt
    id_art = '2'
    descr = 'MONTHLY PLANNER'
    desc2 = 'Ideal para planificar tus metras y proyectos. Tiene un buen diseño.'
    color = 'negro'
    piezas = 1
    stock = 100
    url = 'https://lalibreteria.mx/cdn/shop/files/la-libreteria-agenda-2026-hard-cover-cielo-01_600x.jpg?v=1758959971'
     )

    (
    client = sy-mandt
    id_art = '3'
    descr = 'Marcadores'
    desc2 = 'ZEBRA MIDLINER COLORES PASTELES'
    color = 'negro'
    piezas = 5
    stock = 20
    url = 'https://lalibreteria.mx/cdn/shop/products/la-libreteria-muji_m-07_1f4e12b9-c16e-40f2-9285-a4939507d4dd_700x.jpg?v=1741119089'
     )

    (
    client = sy-mandt
    id_art = '4'
    descr = 'Helvetica Lápiz HB'
    desc2 = 'Su cuerpo redondeado y sus curvas ergonómicas se adaptan perfectamente a la mano.'
    color = 'varios'
    piezas = 6
    stock = 80
    url = 'https://lalibreteria.mx/cdn/shop/files/la-libreteria-helvetica-01_600x.jpg?v=1780420440'
     )

     ).

    MODIFY ytab_arts_26jv FROM TABLE @lti_articulo[].

    IF sy-subrc = 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.

      out->write( 'Data save successful'  ).

    ELSE.
      out->write( 'Data save wrong'  ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
