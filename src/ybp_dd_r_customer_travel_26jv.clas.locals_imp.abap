CLASS lhc_YDD_R_CUSTOMER_TRAVEL_26JV DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF customer_travel_status,
        open     TYPE c LENGTH 1 VALUE 'O',   " Open
        accepted TYPE c LENGTH 1 VALUE 'A',   " Accepted
        rejected TYPE c LENGTH 1 VALUE 'X',   " Rejected
      END OF customer_travel_status.


    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR ydd_r_customer_travel_26jv RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR ydd_r_customer_travel_26jv RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR ydd_r_customer_travel_26jv RESULT result.

    METHODS acceptClients FOR MODIFY
       keys FOR ACTION ydd_r_customer_travel_26jv~acceptClients RESULT result.

    METHODS rejectClients FOR MODIFY
       keys FOR ACTION ydd_r_customer_travel_26jv~rejectClients RESULT result.

    METHODS setDescription FOR DETERMINE ON SAVE
       keys FOR ydd_r_customer_travel_26jv~setDescription.

    METHODS validateCustomer FOR VALIDATE ON SAVE
       keys FOR ydd_r_customer_travel_26jv~validateCustomer.

ENDCLASS.

CLASS lhc_YDD_R_CUSTOMER_TRAVEL_26JV IMPLEMENTATION.

  METHOD get_instance_features.
    " Read root entity entries
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_root_entity)
      FAILED failed.

    " Change the action behavior by status
    result = VALUE #( FOR ls_root_entity IN lt_root_entity
                      ( %tky                  = ls_root_entity-%tky
                        %action-acceptClients = COND #( WHEN ls_root_entity-OverallStatus = customer_travel_status-open
                                                        THEN if_abap_behv=>fc-o-enabled
                                                        ELSE if_abap_behv=>fc-o-disabled )
                        %action-rejectClients = COND #( WHEN ls_root_entity-OverallStatus = customer_travel_status-open
                                                        THEN if_abap_behv=>fc-o-enabled
                                                        ELSE if_abap_behv=>fc-o-disabled ) ) ).
  ENDMETHOD.


  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD acceptClients.
    DATA: lt_updated_root_entity TYPE TABLE FOR UPDATE ydd_r_customer_travel_26jv,
          lv_discount            TYPE /DMO/BT_DiscountPercentage,
          lv_disc_percent        TYPE f.

    " Read root entity entries
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_root_entity)
      FAILED failed.

    " Get parameter discount percent and apply
    LOOP AT lt_root_entity ASSIGNING FIELD-SYMBOL(<ls_root_entity>).
      lv_discount     = keys[ KEY id %tky = <ls_root_entity>-%tky ]-%param-travel_discount.
      lv_disc_percent = lv_discount / 100.

      <ls_root_entity>-Price         = <ls_root_entity>-Price * ( 1 - lv_disc_percent ).
      <ls_root_entity>-OverallStatus = customer_travel_status-accepted.

      APPEND VALUE #( %tky          = <ls_root_entity>-%tky
                      Price         = <ls_root_entity>-Price
                      OverallStatus = <ls_root_entity>-OverallStatus ) TO lt_updated_root_entity.
    ENDLOOP.

    UNASSIGN <ls_root_entity>.

    " Modify status in Root Entity
    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      UPDATE FIELDS ( Price OverallStatus )
      WITH lt_updated_root_entity.

    FREE lt_root_entity. " Free entries in lt_root_entity

    " Read root entity entries updated
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT lt_root_entity
      FAILED failed.

    " Update User Interface
    result = VALUE #( FOR ls_Customer_Travel IN lt_root_entity
                      ( %tky   = ls_Customer_Travel-%tky
                        %param = ls_Customer_Travel ) ).
  ENDMETHOD.


  METHOD rejectClients.
    " Modify status in Root Entity
    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_key IN keys
                    ( %tky          = ls_key-%tky
                      OverallStatus = customer_travel_status-rejected ) ).

    " Read root entity entries updated
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_Customer_Travel)
      FAILED failed.

    " Update User Interface
    result = VALUE #( FOR ls_Customer_Travel IN lt_Customer_Travel
                      ( %tky   = ls_Customer_Travel-%tky
                        %param = ls_Customer_Travel ) ).
  ENDMETHOD.


  METHOD setDescription.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

ENDCLASS.
