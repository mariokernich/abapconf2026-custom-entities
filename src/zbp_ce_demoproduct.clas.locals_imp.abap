CLASS lhc_ZCE_DemoProduct DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZCE_DemoProduct RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZCE_DemoProduct RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE ZCE_DemoProduct.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ZCE_DemoProduct.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ZCE_DemoProduct.

    METHODS read FOR READ
      IMPORTING keys FOR READ ZCE_DemoProduct RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK ZCE_DemoProduct.

ENDCLASS.

CLASS lhc_ZCE_DemoProduct IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCE_DEMOPRODUCT DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCE_DEMOPRODUCT IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
