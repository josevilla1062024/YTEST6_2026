CLASS ycl_virtual_discount_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_virtual_discount_26jv IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    CASE iv_entity.
      WHEN 'YCDS_VIRTUAL_DISCOUNT_26JV' OR 'YCDS_PROJ_VIRTUAL_DISC_26JV'.
        LOOP AT it_requested_calc_elements INTO DATA(ls_requested_calc_elements).
          APPEND 'RealPrice' TO et_requested_orig_elements.
        ENDLOOP.
    ENDCASE.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_original_table TYPE STANDARD TABLE OF ycds_virtual_discount_26jv WITH DEFAULT KEY.

    lt_original_table = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_table ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      IF <fs_original_data>-CurrencyCode EQ 'EUR'.
        <fs_original_data>-RealPrice = <fs_original_data>-Price - ( <fs_original_data>-Price * '0.10' ).
      ELSE.
        <fs_original_data>-RealPrice = <fs_original_data>-Price - ( <fs_original_data>-Price * '0.05' ).
      ENDIF.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_table ).

  ENDMETHOD.

ENDCLASS.
