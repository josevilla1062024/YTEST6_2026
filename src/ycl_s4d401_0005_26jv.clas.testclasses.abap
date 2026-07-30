*"* use this source file for your ABAP unit test classes
CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_get_name FOR TESTING RAISING cx_static_check.
    METHODS setup.
    METHODS test_get_currency FOR TESTING.

    DATA carrier TYPE REF TO lcl_carrier.

ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD test_get_name.
    cl_abap_unit_assert=>fail( 'Implement your first test here' ).

    DATA(name) = me->carrier->get_name( ).

    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = name
        msg              = 'Result of method get_name( )'
*    level            = if_abap_unit_constant=>severity-medium
        quit             = if_abap_unit_constant=>quit-no
*  RECEIVING
*    assertion_failed =
    ).

  ENDMETHOD.

  METHOD setup.

* read arbitrary carrier_id from DB table
    SELECT SINGLE
    FROM /dmo/carrier
    FIELDS carrier_id
    where carrier_id = 'LH'
    INTO @DATA(carrier_id).

    IF sy-subrc <> 0.
      cl_abap_unit_assert=>skip(
        msg    = 'No data in /DMO/CARRIER'
        detail = 'Test requires at least one entry in DB table /DMO/CARRIER'
      ).
    ENDIF.

* then creat the instance to be tested

    TRY.
        me->carrier = NEW lcl_carrier( carrier_id ).

      CATCH cx_abap_invalid_value.

        cl_abap_unit_assert=>skip(
          msg    = 'Cannot create instance of lcl_carrier'
          detail = 'Constructor of lcl_carrier raises an exceptipn when it should not'
        ).

    ENDTRY.

    cl_abap_unit_assert=>fail(
      msg    = 'Cannot create instance of lcl_carrier'
*  level  = if_abap_unit_constant=>severity-medium
*  quit   = if_abap_unit_constant=>quit-test
      detail = 'Constructor of lcl_carrier raises an exception when it should not'
    ).

  ENDMETHOD.

  METHOD test_get_currency.

    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = me->carrier->get_currency( )
        msg              = 'Result of method get_currency( )'
*    level            = if_abap_unit_constant=>severity-medium
        quit             = if_abap_unit_constant=>quit-no
*  RECEIVING
*    assertion_failed =
    ).


  ENDMETHOD.

ENDCLASS.
