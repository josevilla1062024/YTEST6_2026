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
    METHODS setStatus FOR DETERMINE ON MODIFY
       keys FOR CustomerTravel~setStatus.
    METHODS updateFlightDate FOR MODIFY
       keys FOR ACTION CustomerTravel~updateFlightDate.

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
    " Declaration of necessary variables
    DATA: lv_update_requested TYPE abap_bool,
          lv_update_granted   TYPE abap_bool,
          lv_delete_requested TYPE abap_bool,
          lv_delete_granted   TYPE abap_bool.

    " Read root entity entries
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_CustomerTravel)
      FAILED failed.

    " Identify current operation to be authorized
    lv_update_requested = COND #( WHEN requested_authorizations-%update      = if_abap_behv=>mk-on OR
                                       requested_authorizations-%action-Edit = if_abap_behv=>mk-on
                                  THEN abap_true
                                  ELSE abap_false ).

    lv_delete_requested = COND #( WHEN requested_authorizations-%delete = if_abap_behv=>mk-on
                                  THEN abap_true
                                  ELSE abap_false ).

    " Iterate through the root entity records
    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).

    LOOP AT lt_CustomerTravel INTO DATA(ls_CustomerTravel).
      " Block update for user CB998EEE141 on USD records
      IF lv_update_requested EQ abap_true.
        IF lv_technical_name EQ 'CB998EEE141' AND ls_CustomerTravel-CurrencyCode EQ 'USD'.
          lv_update_granted = abap_false.

          " Customize error messages
          APPEND VALUE #( %tky = ls_CustomerTravel-%tky
                          %msg = NEW /dmo/cm_flight_messages(
                                   textid   = /dmo/cm_flight_messages=>not_authorized
                                   severity = if_abap_behv_message=>severity-error )
                          %element-CustomerID = if_abap_behv=>mk-on
                        ) TO reported-CustomerTravel.

        ELSE.
          lv_update_granted = abap_true.
        ENDIF.
      ENDIF.

      " Block delete for user CB998EEE141 on USD records
      IF lv_delete_requested EQ abap_true.
        IF lv_technical_name EQ 'CB998EEE141' AND ls_CustomerTravel-CurrencyCode EQ 'USD'.
          lv_delete_granted = abap_false.

          " Customize error messages
          APPEND VALUE #( %tky = ls_CustomerTravel-%tky
                          %msg = NEW /dmo/cm_flight_messages(
                                   textid   = /dmo/cm_flight_messages=>not_authorized
                                   severity = if_abap_behv_message=>severity-error )
                          %element-CustomerID = if_abap_behv=>mk-on
                        ) TO reported-CustomerTravel.

        ELSE.
          lv_delete_granted = abap_true.
        ENDIF.
      ENDIF.

      " Set authorizations to the specified records
      APPEND VALUE #( LET upd_auth = COND #( WHEN lv_update_granted EQ abap_true
                                             THEN if_abap_behv=>auth-allowed
                                             ELSE if_abap_behv=>auth-unauthorized )
                          del_auth = COND #( WHEN lv_delete_granted EQ abap_true
                                             THEN if_abap_behv=>auth-allowed
                                             ELSE if_abap_behv=>auth-unauthorized )
                      IN %tky         = ls_CustomerTravel-%tky
                         %update      = upd_auth
                         %action-Edit = upd_auth
                         %delete      = del_auth ) TO result.
    ENDLOOP.
  ENDMETHOD.


*  METHOD get_global_authorizations.
*    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).
*
*    " Set global authorization for the create operation
*    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.
**    if lv_technical_name eq 'Admin User Name'.
*      IF lv_technical_name EQ 'CB9980001530'.
*        result-%create = if_abap_behv=>auth-allowed.
*      ELSE.
*        result-%create = if_abap_behv=>auth-unauthorized.
*      ENDIF.
*    ENDIF.
*
*    " Set global authorization for the update operation
*    IF requested_authorizations-%update      EQ if_abap_behv=>mk-on OR
*       requested_authorizations-%action-Edit EQ if_abap_behv=>mk-on.
**    if lv_technical_name eq 'Admin User Name'.
*      IF lv_technical_name EQ 'CB9980001530'.
*        result-%update      = if_abap_behv=>auth-allowed.
*        result-%action-Edit = if_abap_behv=>auth-allowed.
*      ELSE.
*        result-%update      = if_abap_behv=>auth-unauthorized.
*        result-%action-Edit = if_abap_behv=>auth-unauthorized.
*      ENDIF.
*    ENDIF.
*
*    " Set global authorization for the delete operation
*    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.
**    if lv_technical_name eq 'Admin User Name'.
*      IF lv_technical_name EQ 'CB9980001530'.
*        result-%delete = if_abap_behv=>auth-allowed.
*      ELSE.
*        result-%delete = if_abap_behv=>auth-unauthorized.
*      ENDIF.
*    ENDIF.
*  ENDMETHOD.

  METHOD get_global_authorizations.
    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).

    " Set global authorization for the create operation
    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.
*    if lv_technical_name eq 'Admin User Name'.
      IF lv_technical_name EQ 'CB9980001530'.
        result-%create = if_abap_behv=>auth-allowed.
      ELSE.
        result-%create = if_abap_behv=>auth-unauthorized.

        " Customize error messages
        APPEND VALUE #( %msg = NEW /dmo/cm_flight_messages(
                                 textid   = /dmo/cm_flight_messages=>not_authorized
                                 severity = if_abap_behv_message=>severity-error )
                      ) TO reported-CustomerTravel.
      ENDIF.
    ENDIF.

    " Set global authorization for the update operation
    IF requested_authorizations-%update      EQ if_abap_behv=>mk-on OR
       requested_authorizations-%action-Edit EQ if_abap_behv=>mk-on.
*    if lv_technical_name eq 'Admin User Name'.
      IF lv_technical_name EQ 'CB9980001530'.
        result-%update      = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.
      ELSE.
        result-%update      = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.

        " Customize error messages
        APPEND VALUE #( %msg = NEW /dmo/cm_flight_messages(
                                 textid   = /dmo/cm_flight_messages=>not_authorized
                                 severity = if_abap_behv_message=>severity-error )
                      ) TO reported-CustomerTravel.
      ENDIF.
    ENDIF.

    " Set global authorization for the delete operation
    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.
*    if lv_technical_name eq 'Admin User Name'.
      IF lv_technical_name EQ 'CB9980001530'.
        result-%delete = if_abap_behv=>auth-allowed.
      ELSE.
        result-%delete = if_abap_behv=>auth-unauthorized.

        " Customize error messages
        APPEND VALUE #( %msg = NEW /dmo/cm_flight_messages(
                                 textid   = /dmo/cm_flight_messages=>not_authorized
                                 severity = if_abap_behv_message=>severity-error )
                      ) TO reported-CustomerTravel.
      ENDIF.
    ENDIF.
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

    " Iterate through the keys records to get parameters for validations
    DATA(lt_keys) = keys.

    LOOP AT lt_keys ASSIGNING FIELD-SYMBOL(<ls_key>)
         WHERE %param-travel_discount IS INITIAL
            OR %param-travel_discount GT 100
            OR %param-travel_discount LE 0.

      " Set failed entries to block transactional state
      APPEND VALUE #( %tky = <ls_key>-%tky ) TO failed-CustomerTravel.

*      " Customize error messages
*      APPEND VALUE #( %tky = <ls_key>-%tky
*                      %msg = NEW /dmo/cm_flight_messages(
*                               textid   = /dmo/cm_flight_messages=>discount_invalid
*                               severity = if_abap_behv_message=>severity-error )
*                      %op-%action-acceptClients = if_abap_behv=>mk-on
*                    ) TO reported-CustomerTravel.

      " Customize error messages
      APPEND VALUE #( %tky = <ls_key>-%tky
                      %msg = NEW /dmo/cm_flight_messages(
                               textid   = /dmo/cm_flight_messages=>discount_invalid
                               severity = if_abap_behv_message=>severity-error )
                      %state_area = 'VALIDATE_COMPONENT'
                      %op-%action-acceptClients = if_abap_behv=>mk-on
                    ) TO reported-CustomerTravel.

    ENDLOOP.

    CHECK sy-subrc NE 0.

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
    " Read root entity entries
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_root_entity).

    DELETE lt_root_entity WHERE Description IS NOT INITIAL.
    CHECK lt_root_entity IS NOT INITIAL.

    " Modify status in Root Entity
    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      UPDATE FIELDS ( Description )
      WITH VALUE #( FOR ls_root_entity IN lt_root_entity
                    ( %tky        = ls_root_entity-%tky
                      Description = |Flight reason:  { ls_root_entity-Description }| ) ).
  ENDMETHOD.


  METHOD validateCustomer.
    " Declaration of necessary variables
    DATA lt_customers TYPE SORTED TABLE OF ycusto_user_26jv "zcustomers_USER
                      WITH UNIQUE KEY client customer_uuid flight_date customer_id.

    " Read root entity entries updated
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      FIELDS ( CustomerID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_root_entity).

    " Delete duplicate entries in root entity
    lt_customers = CORRESPONDING #( lt_root_entity DISCARDING DUPLICATES
                                    MAPPING customer_id = CustomerID
                                    EXCEPT * ).

    DELETE lt_customers WHERE customer_id IS INITIAL.

    IF lt_customers IS NOT INITIAL.
      " Get valid customer from persistent table
      SELECT FROM ycusto_user_26jv     AS ddbb
        INNER JOIN @lt_customers AS http_req
        ON  ddbb~customer_id EQ http_req~customer_id
        FIELDS ddbb~customer_id
        INTO TABLE @DATA(lt_valid_records).
    ENDIF.

    " Iterate through the root entity records
    LOOP AT lt_root_entity INTO DATA(ls_root_entity).
      IF ls_root_entity-CustomerID IS NOT INITIAL AND
         NOT line_exists( lt_valid_records[ customer_id = ls_root_entity-CustomerID ] ).

        " Set failed entries to block transactional state
        APPEND VALUE #( %tky = ls_root_entity-%tky ) TO failed-CustomerTravel.

        " Customize error messages
        APPEND VALUE #( %tky = ls_root_entity-%tky
                        %msg = NEW /dmo/cm_flight_messages(
                                 textid      = /dmo/cm_flight_messages=>customer_unkown
                                 customer_id = ls_root_entity-CustomerId
                                 severity    = if_abap_behv_message=>severity-error )
                        %element-CustomerID = if_abap_behv=>mk-on
                      ) TO reported-CustomerTravel.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


*  METHOD setStatus.
*    " Read root entity entries
*    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
*      ENTITY CustomerTravel
*      ALL FIELDS WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_root_entity).
*
*    DELETE lt_root_entity WHERE OverallStatus IS NOT INITIAL.
*    CHECK lt_root_entity IS NOT INITIAL.
*
*    " Modify status in Root Entity
*    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
*      ENTITY CustomerTravel
*      UPDATE FIELDS ( OverallStatus )
*      WITH VALUE #( FOR ls_root_entity IN lt_root_entity
*                    ( %tky          = ls_root_entity-%tky
*                      OverallStatus = customer_travel_status-open ) ).
*  ENDMETHOD.

  METHOD setStatus.
    " Read root entity entries
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_root_entity).

    DELETE lt_root_entity WHERE OverallStatus IS NOT INITIAL.
    CHECK lt_root_entity IS NOT INITIAL.

    " Modify status in Root Entity
    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      UPDATE FIELDS ( OverallStatus )
      WITH VALUE #( FOR ls_root_entity IN lt_root_entity
                    ( %tky          = ls_root_entity-%tky
                      OverallStatus = customer_travel_status-open ) ).

    " Execute internal action to update Flight Date
    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      EXECUTE updateFlightDate
      FROM CORRESPONDING #( keys ).
  ENDMETHOD.


  METHOD updateFlightDate.
    " Declaration of necessary variables
    DATA lv_date TYPE d.

    " Read root entity entries
    READ ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_root_entity).

    DELETE lt_root_entity WHERE FlightDate IS NOT INITIAL.
    CHECK lt_root_entity IS NOT INITIAL.

    lv_date = cl_abap_context_info=>get_system_date( ).

    " Any logic should be implemented here
    LOOP AT lt_root_entity ASSIGNING FIELD-SYMBOL(<ls_root_entity>).
      <ls_root_entity>-FlightDate = lv_date.
    ENDLOOP.

    " Modify status in Root Entity
    MODIFY ENTITIES OF ydd_r_customer_travel_26jv IN LOCAL MODE
      ENTITY CustomerTravel
      UPDATE FIELDS ( FlightDate )
      WITH CORRESPONDING #( lt_root_entity ).
  ENDMETHOD.


ENDCLASS.
