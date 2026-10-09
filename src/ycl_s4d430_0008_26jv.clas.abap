CLASS ycl_s4d430_0008_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0008_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


*    SELECT
*      FROM YCDS_C_EMPLOYEEQUERY_26JV
*    FIELDS employeeid,
*           firstname,
*           lastname,
*           departmentid,
*           departmentdescription,
*           assistantname
*    INTO TABLE @DATA(result).


    SELECT
      FROM YCDS_C_EMPLOYEEQUERY_26JV
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           departmentdescription,
           assistantname,
           \_department\_head-lastname AS headname
    INTO TABLE @DATA(result).



* Output
**********************************************************************
    out->write(  data = result
                 name = 'Selection result' ).

  ENDMETHOD.

ENDCLASS.
