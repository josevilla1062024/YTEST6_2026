CLASS ycl_s4d430_0006_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    "Estructuras
    TYPES: BEGIN OF gtyt_employee.
             INCLUDE TYPE ytb_employ_26jv.
    TYPES: END   OF gtyt_employee.

    TYPES: BEGIN OF gtyt_depment.
             INCLUDE TYPE ytb_depment_26jv.
    TYPES: END   OF gtyt_depment.

    "Tipos
    TYPES: gtyd_employee TYPE STANDARD TABLE OF gtyt_employee WITH DEFAULT KEY.
    TYPES: gtyd_depment TYPE STANDARD TABLE OF gtyt_depment WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0006_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lv_tabix TYPE sy-tabix.

    DATA: lti_employee TYPE gtyd_employee.
    DATA: lti_depment TYPE gtyd_depment.

    DATA: lwa_employee LIKE LINE OF lti_employee[].
    DATA: lwa_depment LIKE LINE OF lti_depment[].

    FIELD-SYMBOLS: <lfs_employee> LIKE LINE OF lti_employee[].
    FIELD-SYMBOLS: <lfs_depment> LIKE LINE OF lti_depment[].



    DELETE FROM ytb_depment_26jv.
    IF sy-subrc EQ 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.

      out->write( 'Data delete successful for depment'  ).

    ENDIF.



    DO 5 TIMES.
      lv_tabix = sy-index.

      lwa_depment-id = lv_tabix.
      CONDENSE lwa_depment-id NO-GAPS.
      lwa_depment-head_id = lv_tabix.

      CASE lv_tabix.
        WHEN 1.
          lwa_depment-description = 'Departamento de Finanzas'.
          lwa_depment-assistant_id = 14.
        WHEN 2.
          lwa_depment-description = 'Departamento de Compras'.
          lwa_depment-assistant_id = 20.
        WHEN 3.
          lwa_depment-description = 'Departamento de Ventas'.
          lwa_depment-assistant_id = 34.
        WHEN 4.
          lwa_depment-description = 'Departamento de Logistica'.
          lwa_depment-assistant_id = 48.
        WHEN 5.
          lwa_depment-description = 'Departamento de Logistica'.
          lwa_depment-assistant_id = 54.
      ENDCASE.


      APPEND lwa_depment TO lti_depment[].
      CLEAR lwa_depment.

    ENDDO.

    MODIFY ytb_depment_26jv FROM TABLE @lti_depment[].

    IF sy-subrc = 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.

      out->write( 'Data save successful for depment'  ).

    ELSE.
      out->write( 'Data save wrong for depment'  ).

    ENDIF.

    SELECT
    a~*
    FROM ytb_employ_26jv AS a
    INTO CORRESPONDING FIELDS OF TABLE @lti_employee.

    LOOP AT lti_employee ASSIGNING <lfs_employee>.
      CLEAR <lfs_employee>-department_id.
    ENDLOOP.

    LOOP AT lti_depment ASSIGNING <lfs_depment>.

      LOOP AT lti_employee ASSIGNING <lfs_employee>
                               WHERE employee_id = <lfs_depment>-head_id
                                 OR  employee_id = <lfs_depment>-assistant_id.
        <lfs_employee>-department_id = <lfs_depment>-id.
      ENDLOOP.

    ENDLOOP.

    CLEAR lv_tabix.

    LOOP AT lti_employee ASSIGNING <lfs_employee>
                             WHERE employee_id IS NOT INITIAL.

      lv_tabix = lv_tabix + 1.
      IF ( lv_tabix = 6 ).
        lv_tabix = 1.
      ENDIF.

      CLEAR lwa_depment.
      READ TABLE lti_depment INTO lwa_depment INDEX lv_tabix.
      IF sy-subrc = 0.
        <lfs_employee>-department_id = lwa_depment-id.
      ENDIF.

    ENDLOOP.

    MODIFY ytb_employ_26jv FROM TABLE @lti_employee[].

    IF sy-subrc = 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.

      out->write( 'Data save successful for employee'  ).

    ELSE.
      out->write( 'Data save wrong for employee'  ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
