# Reading the parent key in the child

## The association shows up as a filter

```abap
METHOD if_rap_query_provider~select.
  DATA(filter) = io_request->get_filter( ).

  " The parent key (ProductId) is pushed down as a filter
  DATA(ranges) = filter->get_as_ranges( ).
  " ranges now contains PRODUCTID = 'P-001'

  SELECT FROM zreview
    FIELDS productid, reviewid, rating, comment
    WHERE productid IN @( VALUE #( FOR r IN ranges
                                   WHERE ( name = 'PRODUCTID' )
                                   ( r-range ) ) )
    INTO TABLE @DATA(reviews).
  " ... set_data( reviews )
ENDMETHOD.
```

<div class="opacity-70 text-sm pt-2">
Treat a navigation exactly like a filtered list request — same code shape.
</div>
