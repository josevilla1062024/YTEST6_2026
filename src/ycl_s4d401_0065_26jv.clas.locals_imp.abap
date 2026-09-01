*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
 CLASS lcl_carrier DEFINITION CREATE PRIVATE.

   PUBLIC SECTION.

     TYPES: tt_carriers TYPE STANDARD TABLE OF REF TO lcl_carrier
                             WITH DEFAULT KEY.

     CLASS-METHODS get_instance
       IMPORTING
         i_carrier_id    TYPE /dmo/carrier_id
       RETURNING
         VALUE(r_result) TYPE REF TO lcl_carrier
       RAISING
         cx_abap_invalid_value
         cx_abap_auth_check_exception.

   PROTECTED SECTION.

   PRIVATE SECTION.

     CLASS-DATA instances TYPE tt_carriers.

     DATA: name TYPE /dmo/carrier_name.
     DATA: currency_code TYPE /dmo/currency_code.

     METHODS constructor
       IMPORTING
         i_carrier_id TYPE /dmo/carrier_id
*    RAISING cx_abap_invalid_value
*            cx_abap_auth_check_exception
       .

 ENDCLASS.

 CLASS lcl_carrier IMPLEMENTATION.


   METHOD get_instance.

*SELECT SINGLE
*      FROM /dmo/carrier
*      FIELDS concat_with_space( carrier_id, name, 1 ), currency_code
*      WHERE carrier_id = @i_carrier_id
*      INTO ( @me->name, @me->currency_code ).

     SELECT SINGLE
         FROM /dmo/carrier
         FIELDS concat_with_space( carrier_id, name, 1 ) AS name,
                currency_code
         WHERE carrier_id = @i_carrier_id
*    INTO ( @me->name, @me->currency_code ).
         INTO @DATA(details).

     IF sy-subrc <> 0.
       RAISE EXCEPTION TYPE cx_abap_invalid_value.
     ENDIF.

     AUTHORITY-CHECK
       OBJECT '/LRN/CARR'
       ID '/LRN/CARR' FIELD i_carrier_id
       ID 'ACTVT'     FIELD '03'.

     IF sy-subrc <> 0.
       RAISE EXCEPTION TYPE cx_abap_auth_check_exception.
     ENDIF.

*r_result = instances[ table_line->carrier_id = i_carrier_id ].

*     r_result = NEW #( i_carrier_id = i_carrier_id ).
*     r_result->name          = details-name.
*     r_result->currency_code = details-currency_code.
*
*     APPEND r_result TO instances.

  TRY.
*    r_result = instances[ table_line->carrier_id = i_carrier_id ].
  CATCH cx_sy_itab_line_not_found.
     r_result = NEW #( i_carrier_id = i_carrier_id ).
     r_result->name          = details-name.
     r_result->currency_code = details-currency_code.

     APPEND r_result TO instances.
  ENDTRY.

   ENDMETHOD.

   METHOD constructor.

   ENDMETHOD.

 ENDCLASS.
