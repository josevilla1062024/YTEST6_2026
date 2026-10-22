CLASS lhc_YDD_R_CUSTOMER_TRAVEL_26JV DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

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
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD acceptClients.
  ENDMETHOD.

  METHOD rejectClients.
  ENDMETHOD.

  METHOD setDescription.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

ENDCLASS.
