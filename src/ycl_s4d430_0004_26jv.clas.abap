CLASS ycl_s4d430_0004_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    TYPES: BEGIN OF st_address.
    TYPES: street      TYPE /dmo/street,
           postal_code TYPE /dmo/postal_code,
           city        TYPE /dmo/city,
           country     TYPE land1.
    TYPES: END   OF st_address.

    TYPES: BEGIN OF st_name.
    TYPES: first_name TYPE /dmo/first_name,
           last_name  TYPE /dmo/last_name.
    TYPES: END   OF st_name.

    TYPES: BEGIN OF st_person.
    TYPES: name    TYPE st_name,
           address TYPE st_address.
    TYPES: END   OF st_person.

    TYPES: BEGIN OF st_person_inc.
             INCLUDE TYPE st_name AS name.
             INCLUDE TYPE st_address AS address.
    TYPES: END   OF st_person_inc.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0004_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


* Task 1
*****************************************************************
*    DATA address TYPE st_address.
    DATA address TYPE yst_address_26jv.

    address-street      = 'Dietmar-Hopp-Allee 16'.
    address-postal_code = '69190'.
    address-city        = 'Walldorf'.
    address-country     = 'DE'.


* Task 2
***********************************************************
*    DATA person TYPE st_person.
    DATA person TYPE yst_person_26jv.

    person-name-first_name     = 'Dictionary'.
    person-name-last_name      = 'ABAP'.
    person-address-street      = 'Dietmar-Hopp-Allee 16'.
    person-address-postal_code = '69190'.
    person-address-city        = 'Walldorf'.
    person-address-country     = 'DE'.



* Task 3
**********************************************************************
* DATA person2 TYPE st_person_inc.
    DATA person2 TYPE yst_person_inc_26jv.

    person2-name-first_name = 'Dictionary'.
    person2-name-last_name = 'ABAP'.
    person2-address-street = 'Dietmar-Hopp-Allee 16'.
    person2-address-postal_code = '69190'.
    person2-address-city = 'Walldorf'.
    person2-address-country = 'DE'.
* or -------------------------------------------------------
    person2-first_name = 'Dictionary'.
    person2-last_name = 'ABAP'.
    person2-street = 'Dietmar-Hopp-Allee 16'.
    person2-postal_code = '69190'.
    person2-city = 'Walldorf'.
    person2-country = 'DE'.


  ENDMETHOD.

ENDCLASS.
