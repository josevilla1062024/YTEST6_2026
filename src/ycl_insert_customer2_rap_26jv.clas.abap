CLASS ycl_insert_customer2_rap_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_insert_customer2_rap_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

DATA: lti_travel TYPE STANDARD TABLE OF YCUSTOMERS2_26JV.

    " Clean up records in persistence and draft tables
    DELETE FROM YCUSTOMERS2_26JV. "zcustomers_USER.
    DELETE FROM YCUSTOMERS2_D_26. "zcustomers_d_USER.

    " Inserting records into the persistence table
      SELECT FROM /dmo/travel
        FIELDS uuid( ) AS customer_uuid,
               customer_id,
               description,
               createdby      AS local_created_by,
               createdat      AS local_created_at,
               lastchangedby  AS local_last_changed_by,
               lastchangedat  AS local_last_changed_at
        WHERE travel_id LE 1000
        INTO CORRESPONDING FIELDS OF TABLE @lti_travel.

    MODIFY YCUSTOMERS2_26JV FROM TABLE @lti_travel[].
    IF sy-subrc = 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.

      out->write( |Data save successful: { sy-dbcnt }.| ).

    ENDIF.

 " Update Persistent table
    data lv_date type d.
    lv_date = cl_abap_context_info=>get_system_date( ).

    update YCUSTOMERS2_26JV set flight_date    = @lv_date,
                                price          = 200,
                                currency_code  = 'USD',
                                overall_status = 'O'.

    if sy-subrc eq 0.
      out->write( |Customers updated: { sy-dbcnt }.| ).
    endif.

  ENDMETHOD.

ENDCLASS.
