# Pagination

## `$top` / `$skip` → offset & page size

```abap
DATA(paging) = io_request->get_paging( ).
DATA(lv_skip) = paging->get_offset( ).      " $skip  → OFFSET
DATA(lv_top)  = paging->get_page_size( ).   " $top   → UP TO n ROWS

SELECT FROM zproduct
  FIELDS productid, name, price
  ORDER BY productid
  INTO TABLE @DATA(lt_data)
  UP TO @lv_top ROWS
  OFFSET @lv_skip.
```

<div class="two-col pt-2">

<div>

### 🔑 Key points

- 📄 `get_offset( )` → DB `OFFSET`
- 📐 `get_page_size( )` → `UP TO n ROWS`

</div>

<div>

### ⚠️ Watch out

- 🧭 Paging **needs a stable `ORDER BY`** 
- 💥 Return more than the page size → **runtime dump**
- ✅ Always **consume** `get_paging( )` when data is requested

</div>

</div>
