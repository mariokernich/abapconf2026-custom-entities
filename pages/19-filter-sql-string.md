# The shortcut: ready-made SQL string

## Let the framework build the `WHERE` for you

```abap
" The filter tree becomes a ready-to-use SQL WHERE clause
DATA(where_clause) = io_request->get_filter( )->get_as_sql_string( ).

SELECT FROM zproduct
  FIELDS productid, name, price, currency, stock
  WHERE (where_clause)               "<-- dynamic WHERE
  INTO TABLE @DATA(lt_data).
```

<div class="two-col pt-2">

<div>

### ✅ Why it's nice

- ✍️ **One line** — no `LOOP`, no `RANGE` plumbing
- 🔁 Handles **all** operators (`EQ`, `BT`, `CP`, ...)
- ⚡ Pushes the filter straight into the `SELECT`

</div>

<div>

### ⚠️ The catch

- 🔗 Filter **field names must match DB columns** 1:1
- 🧱 Differing names? → map via `get_as_ranges( )` instead
- 🛡️ Only safe with the **framework-built** string — never concatenate your own

</div>

</div>
