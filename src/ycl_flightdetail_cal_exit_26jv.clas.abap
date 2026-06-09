CLASS ycl_flightdetail_cal_exit_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
* INTERFACES if_sadl_exit_filter_transform.
* INTERFACES if_sadl_exit_sort_transform.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_flightdetail_cal_exit_26jv IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_original_data TYPE STANDARD TABLE OF yi_flightdetail_26jv WITH DEFAULT KEY.

    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).

      CALL FUNCTION 'YFM_GET_WEEKDAY_NAME_26JV'
        EXPORTING
          date     = <fs_original_data>-FlightDate
          language = sy-langu
*         weekday_number = ' '
        IMPORTING
*         langu_back  =
          longtext = <fs_original_data>-FlightDateWeekday
*         shorttext   =
*        EXCEPTIONS
*         calendar_id = 1
*         date_error  = 2
*         not_found   = 3
*         wrong_input = 4
*         OTHERS   = 5
        .

      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
* WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    IF iv_entity <> 'YI_FLIGHTDETAIL_26JV'.
      TRY.
          RAISE EXCEPTION TYPE ycx_sadl_exit_26jv.
        CATCH ycx_sadl_exit_26jv.
          "handle exception
      ENDTRY.
    ENDIF.
    LOOP AT it_requested_calc_elements
    ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
      CASE <fs_calc_element>.
        WHEN 'FLIGHTDATEWEEKDAY'.
          APPEND 'FLIGHTDATE' TO et_requested_orig_elements.
        WHEN OTHERS.
          TRY.
              RAISE EXCEPTION TYPE ycx_sadl_exit_26jv.
            CATCH ycx_sadl_exit_26jv.
              "handle exception
          ENDTRY.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
