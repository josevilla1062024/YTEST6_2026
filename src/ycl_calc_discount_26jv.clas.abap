CLASS ycl_calc_discount_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS get_discount FOR SCALAR FUNCTION ysf_calc_discount_26jv.

    CLASS-METHODS get_real_price FOR SCALAR FUNCTION ysf_din_calc_discount_26jv.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_calc_discount_26jv IMPLEMENTATION.

  METHOD get_discount BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  .

    declare discount decimal(16, 2);
       IF pClientCucky = 'EUR' THEN
         discount = pDiscount * 0.10;
       else
         discount = pDiscount * 0.05;
       end if;
       result = discount;

  endmethod.

  METHOD get_real_price BY DATABASE FUNCTION FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  .

    result = p1 - p2;

  ENDMETHOD.

ENDCLASS.
