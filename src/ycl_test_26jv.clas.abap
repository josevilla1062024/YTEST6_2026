CLASS ycl_test_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_TEST_26JV IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lv_prueba) = NEW lcl_prueba( ).

    lv_prueba->m_test_0001(
      IMPORTING
        lv_test       = DATA(lv_test)
        lv_first_name = DATA(lv_first_name)
        lv_full_name  = DATA(lv_full_name)
        currencies    = DATA(currencies)
    ).

    CASE lv_test.
      WHEN 'A'.
        out->write( |user { lv_first_name }| ).

      WHEN 'B'.
        out->write( currencies[] ).

      WHEN OTHERS. "no haga nada

    ENDCASE.

    lv_prueba->m_test_0002(
      RECEIVING
        r_result = DATA(r_result)
    ).

    out->write( r_result ).

  ENDMETHOD.
ENDCLASS.
