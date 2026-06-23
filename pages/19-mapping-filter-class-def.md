# 💡 Pro Tip: Mapping filters to a typed data def

<div class="two-col pt-2" style="grid-template-columns: 1.4fr 1fr;">

<div>

```abap
CLASS zcl_my_query_provider DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.

  PROTECTED SECTION.
    " Save request instance class wide
    DATA mo_request TYPE REF TO if_rap_query_request.

    " Inline type definition of key fields
    TYPES:
      BEGIN OF ty_filter,
        productid TYPE RANGE OF ZCE_DemoProduct-ProductId,
      END OF ty_filter.

    METHODS extract_filters
      RETURNING VALUE(rs_filter) TYPE ty_filter
      RAISING   cx_rap_query_provider.
ENDCLASS.
```

</div>

<div>

### Preperation

- 💾 Store the **request** instance class-wide → reuse it everywhere
- 🧩 Declare a **typed `ty_filter`** for the fields you care about
- 🔑 Especially handy for **key fields**
- ⚙️ Sets up generic, type-driven extraction (next slide)

</div>

</div>
