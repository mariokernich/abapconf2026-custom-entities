CLASS zcl_sample_if_rap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mo_request TYPE REF TO if_rap_query_request.

    TYPES:
      BEGIN OF ty_filter,
        productid TYPE RANGE OF ZCE_DemoProduct-ProductId,
      END OF ty_filter.

    METHODS extract_filters
      RETURNING VALUE(rs_filter) TYPE ty_filter
      RAISING   cx_rap_query_provider.
ENDCLASS.



CLASS zcl_sample_if_rap IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    mo_request = io_request.

    DATA(ls_keys) = extract_filters( ).
    DATA(lv_productid) = ls_keys-productid.

  ENDMETHOD.

  METHOD extract_filters.
    DATA(lo_struct) = CAST cl_abap_structdescr(
        cl_abap_typedescr=>describe_by_data( rs_filter ) ).

    DATA(lt_filter_cond) = mo_request->get_filter( )->get_as_ranges( ).

    LOOP AT lo_struct->components INTO DATA(ls_comp).

      ASSIGN COMPONENT ls_comp-name
          OF STRUCTURE rs_filter
          TO FIELD-SYMBOL(<fs_value>).

      READ TABLE lt_filter_cond
      WITH KEY name = ls_comp-name
      ASSIGNING FIELD-SYMBOL(<fs_cond>).

      IF sy-subrc <> 0.
        " raise exception because key / filter is not set that is in ty_filter defined
      ENDIF.

      " read filter value
      <fs_value> = <fs_cond>-range[ 1 ]-low.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
