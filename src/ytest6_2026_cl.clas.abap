CLASS ytest6_2026_cl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ytest6_2026_cl IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_full_name TYPE string VALUE 'Stan Wilson'.
    DATA: lv_first_name TYPE string.
    DATA: lv_last_name TYPE string.
    DATA: lv_test TYPE string.


    SPLIT lv_full_name AT '' INTO lv_first_name lv_last_name.

    SELECT Price, \_Currency-CurrencyISOCode
    FROM YI_Flight_26JV
    WHERE \_Currency-Decimals = 0
    INTO TABLE @DATA(currencies).

*    SELECT * FROM I_USER
*    WITH PRIVILEGED ACCESS
*    INTO TABLE @DATA(user).

    lv_test = 'B'.


    CASE lv_test.
      WHEN 'A'.
        out->write( |user { lv_first_name }| ).

      WHEN 'B'.
        out->write( currencies[] ).

      WHEN OTHERS. "no haga nada

    ENDCASE.



  ENDMETHOD.

ENDCLASS.
