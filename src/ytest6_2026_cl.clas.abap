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

    SPLIT lv_full_name AT '' INTO lv_first_name lv_last_name.

    out->write( |user { lv_first_name }| ).

  ENDMETHOD.

ENDCLASS.
