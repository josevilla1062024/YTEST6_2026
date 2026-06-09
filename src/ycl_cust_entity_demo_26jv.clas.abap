CLASS ycl_cust_entity_demo_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_cust_entity_demo_26jv IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA(lv_top) = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip) = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause) = io_request->get_filter( )->get_as_sql_string( ).

    TYPES: BEGIN OF gtyt_usname.
    TYPES: username  TYPE text12,
           firstname TYPE ad_namefir,
           lastname  TYPE ad_namelas,
           fullname  TYPE text80.
    TYPES: END   OF gtyt_usname.

*    DATA lt_userlist TYPE STANDARD TABLE OF bapiusname.
    DATA lt_userlist TYPE STANDARD TABLE OF gtyt_usname.
    DATA lt_result TYPE STANDARD TABLE OF ycust_entity_demo_26jv.
    DATA lt_bapiret TYPE STANDARD TABLE OF bapiret2.

    DATA ls_result LIKE LINE OF lt_result[].

    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

    TRY.

        IF io_request->is_data_requested( ).

*CALL FUNCTION 'BAPI_USER_GETLIST'
*  EXPORTING
*    with_username = abap_true
*  TABLES
*    userlist      = lt_userlist
*    return        = lt_bapiret.

* Filter
          LOOP AT lt_userlist INTO DATA(ls_userlist).
            DATA(lv_tabix) = sy-tabix.
            LOOP AT lt_filter_cond INTO DATA(ls_filter_cond).
              CASE ls_filter_cond-name.
                WHEN OTHERS.
              ENDCASE.
            ENDLOOP.
          ENDLOOP.

* Sorting
*          IF lt_sort IS NOT INITIAL.
*            LOOP AT lt_sort INTO DATA(ls_sort).
*            ENDLOOP.
*          ENDIF.

* Paging
          IF lv_top > 0.
            LOOP AT lt_userlist INTO ls_userlist FROM lv_skip
            + 1 TO ( lv_skip + lv_top ).
              MOVE-CORRESPONDING ls_userlist TO ls_result.
              APPEND ls_result TO lt_result.
            ENDLOOP.
          ENDIF.

* Count
          IF io_request->is_total_numb_of_rec_requested( ).
            io_response->set_total_number_of_records( lines( lt_result ) ).
          ENDIF.

          io_response->set_data( lt_result ).

        ELSE.
* no data is requested
        ENDIF.

      CATCH cx_rap_query_provider INTO DATA(lx_exc). "error handling
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
