CLASS ycl_s4d401_0065_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0065_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    CONSTANTS c_carrier_id TYPE /dmo/carrier_id VALUE 'LH'.

    TRY.
          DATA(carrier)  = lcl_carrier=>get_instance(  i_carrier_id = c_carrier_id ).
          DATA(carrier2) = lcl_carrier=>get_instance(  i_carrier_id = c_carrier_id ).
      CATCH cx_abap_invalid_value cx_abap_auth_check_exception.
        "handle exception
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
