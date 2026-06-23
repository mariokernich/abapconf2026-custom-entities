CLASS zcl_demo_product_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_demo_product_query IMPLEMENTATION.
  METHOD if_rap_query_provider~select.

  DATA lt_data TYPE TABLE OF ZCE_DemoProduct.

    " 1. Handle Count Request
    IF io_request->is_total_numb_of_rec_requested( ).
      DATA(lv_where_count) = io_request->get_filter( )->get_as_sql_string( ).
      SELECT COUNT( * ) FROM zproduct
        WHERE (lv_where_count)
        INTO @DATA(lv_count).
      io_response->set_total_number_of_records( lv_count ).
    ENDIF.

    " 2. Handle Data Request
    IF io_request->is_data_requested( ).
      " Get Paging Information
      DATA(lo_paging) = io_request->get_paging( ).
      DATA(lv_top)    = lo_paging->get_page_size( ).
      DATA(lv_skip)   = lo_paging->get_offset( ).

      " Get Sorting elements
      DATA(lt_sort_elements) = io_request->get_sort_elements( ).
      DATA(lv_orderby) = REDUCE string(
        INIT s = ``
        FOR ls IN lt_sort_elements
        NEXT s = |{ s }{ COND #( WHEN s IS NOT INITIAL THEN `, ` ) }|
              && |{ ls-element_name } { COND #( WHEN ls-descending THEN `DESCENDING` ELSE `ASCENDING` ) }| ).

      " Fallback orderby (Mandatory for stable paging offset)
      IF lv_orderby IS INITIAL.
        lv_orderby = 'PRODUCTID ASCENDING'.
      ENDIF.

      " SQL Filter String
      DATA(lv_where) = io_request->get_filter( )->get_as_sql_string( ).

      SELECT FROM zproduct
        FIELDS productid, name, price, currency, stock
        WHERE (lv_where)
        ORDER BY (lv_orderby)
        INTO TABLE @DATA(lt_result)
        UP TO @lv_top ROWS
        OFFSET @lv_skip.

      io_response->set_data( lt_result ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
