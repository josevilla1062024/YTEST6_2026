CLASS ycl_s4d400_0029_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_S4D400_0029_26JV IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*agencyid =
*070001

*name =
*Sunshine Travel
*    agencies_upd = VALUE #( ( agencyid = '070001' name = 'Some fancy new name' ) ).


    DATA agencies_upd TYPE TABLE FOR UPDATE /dmo/i_agencytp.

*    agencies_upd = VALUE #( ( agencyid = '0700##' name = 'Some fancy new name' ) ).
    agencies_upd = VALUE #( ( agencyid = '070001' name = 'Some fancy new name' ) ).

    MODIFY ENTITIES OF /dmo/i_agencytp
      ENTITY /dmo/agency
      UPDATE FIELDS ( name )
        WITH agencies_upd.

    IF ( sy-subrc <> 0 ).
      out->write( `Something wrong error ???`  ).

    ELSE.
      COMMIT ENTITIES.

      out->write( `Method execution finished!`  ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
