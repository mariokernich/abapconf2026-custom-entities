# Reading filters the smart way

## Convert the OData filter tree into a RANGE table

<div class="two-col pt-2" style="grid-template-columns: 1.3fr 1fr;">

<div>

```abap
DATA(filter_cond) = io_request->get_filter( ).
DATA(ranges) = filter_cond->get_as_ranges( ).

" flat list per field → SELECT ... WHERE field IN range
LOOP AT ranges INTO DATA(r) WHERE name = 'PRODUCTID'.
  lt_id_range = r-range.
ENDLOOP.

SELECT FROM zproduct
  FIELDS productid, name, price
  WHERE productid IN @lt_id_range
  INTO TABLE @DATA(lt_data)
  UP TO @lv_top ROWS
  OFFSET @lv_skip.
```

</div>

<div>

### Keep in mind

- 🔑 Filters also carry the **key values** — keys & filters are **optional**
- 🔢 Key set → cardinality **0..1**; no key → **0..n** — result is **always a table**
- ➡️ No filter/key → **return everything**

</div>

</div>