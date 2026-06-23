# The provider interface - One method does it all

```abap
CLASS zcl_demo_product_query DEFINITION PUBLIC FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
ENDCLASS.

CLASS zcl_demo_product_query IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA result TYPE TABLE OF ZC_DemoProduct.

    " 1. Read request (filter / sort / paging)
    " 2. Fetch data (DB, API, calculation, ...)
    " 3. Return result (always a list!)

    result = VALUE #(
      ( ProductId = 'P-001' Name = 'Coffee' Price = '3.50' Currency = 'EUR' Stock = 42 )
      ( ProductId = 'P-002' Name = 'Tea'    Price = '2.80' Currency = 'EUR' Stock = 17 ) ).

    io_response->set_total_number_of_records( lines( result ) ). " should be total amount and not the result
    io_response->set_data( result ).
  ENDMETHOD.
ENDCLASS.

```