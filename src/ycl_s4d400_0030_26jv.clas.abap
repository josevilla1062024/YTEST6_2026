CLASS ycl_s4d400_0030_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_S4D400_0030_26JV IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*Copia de clase zcl_01_copy

    CONSTANTS table_name TYPE sxco_dbt_object_name VALUE 'YFLIGHT_26JV'.

    TRY.
        DELETE FROM (table_name).

        INSERT (table_name) FROM ( SELECT * FROM /dmo/flight ).

        out->write( |{ table_name } was filled with data successfully.| ).

      CATCH cx_root INTO DATA(lx_root).
        out->write( lx_root->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
