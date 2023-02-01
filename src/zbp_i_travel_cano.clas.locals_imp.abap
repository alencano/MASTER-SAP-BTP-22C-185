CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS createTravelByTemplate FOR MODIFY
      IMPORTING keys FOR ACTION Travel~createTravelByTemplate RESULT result.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateStatus.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD acceptTravel.
  ENDMETHOD.

  METHOD createTravelByTemplate.

*     keys[ 1 ]-
*    result[ 1 ]
*    mapped-
*    failed-
*    reported-
    READ ENTITIES OF z_i_travel_cano
         ENTITY Travel
         FIELDS ( TravelId AgencyId CustomerId BookingFee TotalPrice currency_code )
         WITH VALUE #( FOR row_key IN keys ( %key = row_key-%key )  )
         RESULT DATA(lt_entity_travel)
         FAILED failed
         REPORTED reported.

*    READ ENTITY z_i_travel_cano
*         FIELDS ( TravelId AgencyId CustomerId BookingFee TotalPrice currency_code )
*         WITH VALUE #( FOR row_key IN keys ( %key = row_key-%key )  )
*         RESULT lt_entity_travel
*         FAILED failed
*         REPORTED reported.

    CHECK failed IS INITIAL.

    DATA lt_create_travel TYPE TABLE FOR CREATE z_i_travel_cano\\Travel.

    SELECT MAX( travel_id ) FROM ztravel_log
           INTO @DATA(lv_travel_id).

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    lt_create_travel = VALUE #( FOR create_row IN lt_entity_travel INDEX INTO idx
                              ( TravelId    = lv_travel_id + idx
                                AgencyId    = create_row-AgencyId
                                CustomerId  = create_row-CustomerId
                                BeginDate   =  lv_today
                                EndDate     = lv_today + 30
                                BookingFee = create_row-BookingFee
                                TotalPrice = create_row-TotalPrice
                                currency_code = create_row-currency_code
                                description = 'Add comments'
                                OverallStatus = 'O' ) ).

    MODIFY ENTITIES OF z_i_travel_cano
           IN LOCAL MODE ENTITY travel
           CREATE FIELDS ( TravelId
                           AgencyId
                           CustomerId
                           BeginDate
                           EndDate
                           BookingFee
                           TotalPrice
                           currency_code
                           description
                           OverallStatus )
           WITH lt_create_travel
           MAPPED mapped
           FAILED failed
           REPORTED reported.

    result = VALUE #( FOR result_row IN lt_create_travel INDEX INTO idx
                        ( %cid_ref = keys[ idx ]-%cid_ref
                          %key = keys[ idx ]-%key
                          %param = CORRESPONDING #(
                          result_row ) ) ).

  ENDMETHOD.

  METHOD rejectTravel.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDates.
  ENDMETHOD.

  METHOD validateStatus.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_I_TRAVEL_CANO DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_I_TRAVEL_CANO IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
