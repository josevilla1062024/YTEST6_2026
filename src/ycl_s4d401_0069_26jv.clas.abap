CLASS ycl_s4d401_0069_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0069_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.

    TRY.


DATA(carrier)  = lcl_carrier=>get_instance( i_carrier_id = c_carrier_id ).

    out->write( `Carrier Overview`
*                name = `Carrier Overview`
*                data = carrier->get_output(  )
                ).

*      CATCH cx_abap_invalid_value INTO DATA(exc_inv).

*    out->write( |Carrier { c_carrier_id } does not exist| ).
*        out->write( exc_inv->get_text( ) ).

*      CATCH cx_abap_auth_check_exception INTO DATA(exc_auth).
*      CATCH cx_abap_auth_check_exception.
        "handle exception
*    out->write( |No authorization to display carrier { c_carrier_id }| ).
*        out->write( exc_auth->get_text( ) ).

CATCH YCX_S4D401_0069_26JV INTO DATA(exc_fail).
      out->write( exc_fail->get_text( ) ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
