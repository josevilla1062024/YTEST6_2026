CLASS ycl_s4d430_0002_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    "Estructuras
    TYPES: BEGIN OF gtyt_customer.
             INCLUDE TYPE /dmo/customer.
    TYPES: END   OF gtyt_customer.

    TYPES: BEGIN OF gtyt_flight.
             INCLUDE TYPE /dmo/flight.
    TYPES: END   OF gtyt_flight.

    TYPES: BEGIN OF gtyt_fecha.
    TYPES: fecha TYPE yde_birth_date_26jv.
    TYPES: END   OF gtyt_fecha.

    TYPES: BEGIN OF gtyt_employee.
             INCLUDE TYPE ytb_employ_26jv.
    TYPES: END   OF gtyt_employee.

    "Tipos
    TYPES: gtyd_customer TYPE STANDARD TABLE OF gtyt_customer WITH DEFAULT KEY.
    TYPES: gtyd_flight TYPE STANDARD TABLE OF gtyt_flight WITH DEFAULT KEY.
    TYPES: gtyd_fecha TYPE STANDARD TABLE OF gtyt_fecha WITH DEFAULT KEY.
    TYPES: gtyd_employee TYPE STANDARD TABLE OF gtyt_employee WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0002_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lv_tabix TYPE sy-tabix.
    DATA: lv_tabix2 TYPE sy-tabix.
    DATA: lv_fecha TYPE yde_birth_date_26jv.
    DATA: lv_texto TYPE string.

    DATA: lti_customer TYPE gtyd_customer.
    DATA: lti_flight TYPE gtyd_flight.
    DATA: lti_fecha TYPE gtyd_fecha.
    DATA: lti_employee TYPE gtyd_employee.

    DATA: lwa_fecha LIKE LINE OF lti_fecha[].
    DATA: lwa_customer LIKE LINE OF lti_customer[].
    DATA: lwa_flight LIKE LINE OF lti_flight[].
    DATA: lwa_employee LIKE LINE OF lti_employee[].


    lv_fecha = '19600101'.

    DO 728 TIMES.
      lv_tabix = sy-index.

      lwa_fecha-fecha = lv_fecha + lv_tabix.

      APPEND lwa_fecha TO lti_fecha[].
      CLEAR lwa_fecha.

    ENDDO.

    SELECT
    a~*
    FROM /dmo/customer AS a
    INTO CORRESPONDING FIELDS OF TABLE @lti_customer
    UP TO  728 ROWS.

    SELECT
    a~*
    FROM /dmo/flight AS a
    INTO CORRESPONDING FIELDS OF TABLE @lti_flight
    UP TO  728 ROWS.

    DO 728 TIMES.
      lv_tabix = sy-index.

      lv_tabix2 = lv_tabix2 + 1.
      IF ( lv_tabix2 > 40 ).
        lv_tabix2 = 1.
      ENDIF.

      CLEAR lwa_customer.
      READ TABLE lti_customer INTO lwa_customer INDEX lv_tabix.
      IF sy-subrc = 0.
        lwa_employee-employee_id = lwa_customer-customer_id.
        lwa_employee-first_name = lwa_customer-first_name.
        lwa_employee-last_name = lwa_customer-last_name.
      ENDIF.

      CLEAR lwa_fecha.
      READ TABLE lti_fecha INTO lwa_fecha INDEX lv_tabix.
      IF sy-subrc = 0.
        lwa_employee-birth_date = lwa_fecha-fecha.
      ENDIF.

      CLEAR lwa_flight.
      READ TABLE lti_flight INTO lwa_flight INDEX lv_tabix2.
      IF sy-subrc = 0.
        lwa_employee-entry_date = lwa_flight-flight_date.
        lwa_employee-annual_salary = lwa_flight-price.
        lwa_employee-currency_code = lwa_flight-currency_code.
      ENDIF.

      APPEND lwa_employee TO lti_employee[].
      CLEAR lwa_employee.

    ENDDO.

    MODIFY ytb_employ_26jv FROM TABLE @lti_employee[].

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
