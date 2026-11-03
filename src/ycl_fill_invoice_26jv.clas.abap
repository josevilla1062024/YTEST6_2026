CLASS ycl_fill_invoice_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_fill_invoice_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    INSERT ydt_com_inv_26jv FROM TABLE @( VALUE #(
          ( invoice_id    = '0000000001'
            customer_name = 'Manuel'
            inv_amount    = '100'
            currency      = 'USD'
            department    = '01'
            created_by    = cl_abap_context_info=>get_user_technical_name( )
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000002'
            customer_name = 'Wladimir'
            inv_amount    = '200'
            currency      = 'USD'
            department    = '01'
            created_by    = cl_abap_context_info=>get_user_technical_name( )
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000003'
            customer_name = 'Jonathan'
            inv_amount    = '300'
            currency      = 'USD'
            department    = '01'
            created_by    = cl_abap_context_info=>get_user_technical_name( )
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000004'
            customer_name = 'Joel'
            inv_amount    = '400'
            currency      = 'USD'
            department    = '01'
            created_by    = cl_abap_context_info=>get_user_technical_name( )
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000005'
            customer_name = 'Luigi'
            inv_amount    = '500'
            currency      = 'USD'
            department    = '01'
            created_by    = cl_abap_context_info=>get_user_technical_name( )
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000006'
            customer_name = 'Manuel'
            inv_amount    = '100'
            currency      = 'USD'
            department    = '01'
            created_by    = 'CB9980003075'
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000007'
            customer_name = 'Wladimir'
            inv_amount    = '200'
            currency      = 'USD'
            department    = '01'
            created_by    = 'CB9980003075'
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000008'
            customer_name = 'Jonathan'
            inv_amount    = '300'
            currency      = 'USD'
            department    = '01'
            created_by    = 'CB9980003075'
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000009'
            customer_name = 'Joel'
            inv_amount    = '400'
            currency      = 'USD'
            department    = '01'
            created_by    = 'CB9980003075'
            create_date   = cl_abap_context_info=>get_system_date( ) )
          ( invoice_id    = '0000000010'
            customer_name = 'Luigi'
            inv_amount    = '500'
            currency      = 'USD'
            department    = '01'
            created_by    = 'CB9980003075'
            create_date   = cl_abap_context_info=>get_system_date( ) ) ) ).

    IF sy-subrc EQ 0.
      out->write( 'Data insertion successful' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
