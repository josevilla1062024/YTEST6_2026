CLASS ycl_insert_customer_rap_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_insert_customer_rap_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " Clean up records in persistence and draft tables
    DELETE FROM ycusto_user_26jv. "zcustomers_USER.
    DELETE FROM ycus_d_user_26jv. "zcustomers_d_USER.

    " Inserting records into the persistence table
    INSERT ycusto_user_26jv FROM ( "insert zcustomers_USER from (
      SELECT FROM /dmo/travel
        FIELDS uuid( ) AS customer_uuid,
               customer_id,
               description,
               createdby      AS local_created_by,
               createdat      AS local_created_at,
               lastchangedby  AS local_last_changed_by,
               lastchangedat  AS local_last_changed_at
        WHERE travel_id LE 1000 ).

    IF sy-subrc EQ 0.
      out->write( |Customers inserted: { sy-dbcnt }.| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
