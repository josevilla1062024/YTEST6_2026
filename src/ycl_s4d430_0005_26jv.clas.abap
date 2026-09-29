CLASS ycl_s4d430_0005_26jv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_s4d430_0005_26jv IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


* Task 1
**********************************************************************
*    DATA addresses TYPE tt_addresses.
    DATA addresses TYPE ytt_addresses_26jv.

    addresses =
      VALUE #(
              ( street      = 'Dietmar-Hopp-Allee 16'
                postal_code = '69190'
                city        = 'Walldorf'
                country     = 'DE'
              )
              ( street      = '3999 West Chester Pike'
                postal_code = '19073'
                city        = 'Newtown Square, PA'
                country     = 'US'
              )
             ).


* Task 2
**********************************************************************
*  DATA person TYPE st_person_deep.
    DATA person TYPE yst_person_deep_26jv. "/lrn/s_person_deep.

    person-first_name = 'Dictionary'.
    person-last_name = 'ABAP'.
    person-addresses = addresses.



* Task 3
**********************************************************************
* DATA persons TYPE tt_persons.
    DATA persons TYPE ytt_persons_26jv. "/lrn/t_persons.

    persons =
       VALUE #(
          ( person )
          (
            first_name = 'CDS'
            last_name  = 'ABAP'
            addresses =
              VALUE #(
                ( street      = 'SAP-Allee 29'
                  postal_code = '68789'
                  city        = 'St.Leon-Rot'
                  country     = 'DE'
                )
                ( street      = '35 rue d''Alsace'
                  postal_code = '92300'
                  city        = 'Levallois-Perret'
                  country     = 'FR'
                )
                ( street      = 'Bedfont Road'
                  postal_code = 'TW14 8HD'
                  city        = 'Feltham'
                  country     = 'GB'
                )
               )
              )
            ).


  ENDMETHOD.

ENDCLASS.
