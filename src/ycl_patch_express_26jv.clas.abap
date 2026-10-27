CLASS ycl_patch_express_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_patch_express_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

SELECT FROM YCDS_PUBLIC_ASSOC_26JV AS PublicAssoc
      FIELDS PublicAssoc~AgencyId,
             PublicAssoc~TravelId
*             ,
*             _Agency-name AS Name
      WHERE PublicAssoc~AgencyId EQ '070032'
      INTO TABLE @DATA(lt_results)
      UP TO 10 ROWS.

    if sy-subrc eq 0.
      out->write( lt_results ).
    endif.

  ENDMETHOD.

ENDCLASS.
