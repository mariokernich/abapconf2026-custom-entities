# Sorting

## `$orderby` → dynamic `ORDER BY`

```abap
METHOD if_rap_query_provider~select.

  DATA(lt_sort) = io_request->get_sort_elements( ).

  SELECT FROM zproduct
    FIELDS productid, name, price
    ORDER BY (lv_order)
    INTO TABLE @DATA(lt_data).

  SORT lt_data BY lt_SORT.

  io_response->set_data( lt_data ).

ENDMETHOD.
```

<div class="opacity-70 text-sm pt-2">

`get_sort_elements( )` returns one row per field with `element_name` +
`descending`. Element names match the **entity** — map to DB columns if they differ, and fall back to a default sort when the list is empty.

</div>
