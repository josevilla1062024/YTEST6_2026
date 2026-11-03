CLASS ycl_amdp_airport_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    INTERFACES if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_table,
        airport_id TYPE /dmo/airport_id,
        name       TYPE /dmo/airport_name,
        city       TYPE /dmo/city,
        country    TYPE land1,
      END OF ty_table,
      lt_table TYPE TABLE OF ty_table.

    CLASS-METHODS get_airport FOR TABLE FUNCTION ytf_airports_26jv.

    CLASS-METHODS read_cds
      AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
*      AMDP OPTIONS CDS SESSION CLIENT current
      EXPORTING VALUE(et_return) TYPE lt_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_amdp_airport_26jv IMPLEMENTATION.

  METHOD get_airport BY DATABASE FUNCTION FOR HDB
   LANGUAGE SQLSCRIPT
   OPTIONS READ-ONLY
   USING /dmo/airport
  .

    RETURN select *
                 from "/DMO/AIRPORT" as a
*                where a.client = :pClient
                where a.client = session_context('CDS_CLIENT')
                  AND a.city   = :pCity
                ORDER BY a.city desc;

  endmethod.

  METHOD read_cds BY DATABASE PROCEDURE FOR HDB
  LANGUAGE SQLSCRIPT
    OPTIONS READ-ONLY
    USING YCDS_AIRPORT_AMDP_26JV.

    et_return = select top 10 a.airportid as airport_id,
                              a.name,
                              a.city,
                              a.country
                  from YCDS_AIRPORT_AMDP_26JV as a;

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    ycl_amdp_airport_26jv=>read_cds(
          IMPORTING et_return = DATA(lt_table) ).

    out->write( lt_table ).

  ENDMETHOD.

ENDCLASS.
