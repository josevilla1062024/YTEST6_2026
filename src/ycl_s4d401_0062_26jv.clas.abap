CLASS ycl_s4d401_0062_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d401_0062_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


*  out->write( name = |Found a suitable passenger flight in { days_later } days:|
**              data = pass_flight->get_description( ) ).
*              data = pass_flight->lif_output~get_output( ) ).

*  out->write( name = |Found a suitable cargo flight in { days_later2 } days:|
**              data = cargo_flight->get_description( ) ).
*              data = cargo_flight->lif_output~get_output( ) ).

*  out->write( name = |Found a suitable passenger flight in { days_later } days:|
**              data = pass_flight->get_description( ) ).
**              data = pass_flight->lif_output~get_output( ) ).
*              data = pass_flight->get_output( ) ).

*  out->write( name = |Found a suitable cargo flight in { days_later2 } days:|
**              data = cargo_flight->get_description( ) ).
**              data = cargo_flight->lif_output~get_output( ) ).
*              data = cargo_flight->get_output( ) ).

  ENDMETHOD.

ENDCLASS.
