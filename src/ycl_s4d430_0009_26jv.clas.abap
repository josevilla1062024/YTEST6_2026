CLASS ycl_s4d430_0009_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0009_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    SELECT
      FROM ycds_c_employeequeryp_26jv(
                 p_target_curr = 'USD'
*                 ,
*                 p_date = @sy-datum
                )
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,

           departmentdescription,
           assistantname,
           \_department\_head-lastname AS headname,

           MonthlySalaryConverted,
           CurrencyCode,
           CompanyAffiliation

    INTO TABLE @DATA(result).

* Output
**********************************************************************
    out->write(  data = result
                 name = 'Selection result' ).

  ENDMETHOD.

ENDCLASS.
