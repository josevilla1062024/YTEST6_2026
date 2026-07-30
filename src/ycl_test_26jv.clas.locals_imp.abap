*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_prueba DEFINITION.

  PUBLIC SECTION.

    "Estructuras
    TYPES: BEGIN OF gtyt_currencies.
    TYPES: Price           TYPE YI_Flight_26JV-Price,
           CurrencyISOCode TYPE I_Currency-CurrencyISOCode.
    TYPES: END   OF gtyt_currencies.

    TYPES: BEGIN OF gtyt_cargofli.
             INCLUDE TYPE ys4d401_cargofli.
    TYPES: END   OF gtyt_cargofli.

    "Tipos
    TYPES: gtyd_currencies TYPE STANDARD TABLE OF gtyt_currencies WITH DEFAULT KEY.
    TYPES: gtyd_cargofli TYPE STANDARD TABLE OF gtyt_cargofli WITH DEFAULT KEY.

    METHODS m_test_0001
      EXPORTING
        lv_test       TYPE string
        lv_first_name TYPE string
        lv_full_name  TYPE string
        currencies    TYPE gtyd_currencies.

    METHODS m_test_0002
      RETURNING VALUE(r_result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_prueba IMPLEMENTATION.

  METHOD m_test_0001.

*    DATA: lv_full_name TYPE string VALUE 'Stan Wilson'.
*    DATA: lv_first_name TYPE string.
    DATA: lv_last_name TYPE string.
*    DATA: lv_test TYPE string.

    lv_full_name = 'Stan Wilson'.

    SPLIT lv_full_name AT '' INTO lv_first_name lv_last_name.

    SELECT Price, \_Currency-CurrencyISOCode
    FROM YI_Flight_26JV
    WHERE \_Currency-Decimals = 0
    INTO TABLE @currencies.
*    INTO TABLE @DATA(currencies).

**    SELECT * FROM I_USER
**    WITH PRIVILEGED ACCESS
**    INTO TABLE @DATA(user).
*
    lv_test = 'B'.

  ENDMETHOD.

  METHOD m_test_0002.

    DATA: lv_tabix TYPE sy-tabix.

    DATA: lti_cargofli TYPE gtyd_cargofli.

    FIELD-SYMBOLS: <lfs_cargofli> LIKE LINE OF lti_cargofli[].

    SELECT
     a~carrier_id, a~connection_id, a~flight_date, "key
     b~airport_from_id, b~airport_to_id
     FROM /dmo/flight AS a
     LEFT OUTER JOIN /dmo/connection AS b
      ON b~carrier_id = a~carrier_id
     AND b~connection_id = a~connection_id
     INTO CORRESPONDING FIELDS OF TABLE @lti_cargofli
     UP TO 5 ROWS
     .

    LOOP AT lti_cargofli ASSIGNING <lfs_cargofli>.
      lv_tabix = sy-tabix.

      CASE lv_tabix.
        WHEN 1.
          <lfs_cargofli>-maximum_load = 20.
          <lfs_cargofli>-actual_load = 10.
        WHEN 2.
          <lfs_cargofli>-maximum_load = 20.
          <lfs_cargofli>-actual_load = 8.
        WHEN 3.
          <lfs_cargofli>-maximum_load = 20.
          <lfs_cargofli>-actual_load = 5.
        WHEN OTHERS.

      ENDCASE.

    ENDLOOP.

    MODIFY ys4d401_cargofli FROM TABLE @lti_cargofli[].
    IF sy-subrc = 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.

      r_result = 'Data save successful'.

    ELSE.
      r_result = 'Data save wrong'.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
