# Use the Power of autocompletion

<div class="two-col">

<div>

```abap
TYPES:
      BEGIN OF ty_filter,
        productid TYPE RANGE OF ZCE_DemoProduct-ProductId,
      END OF ty_filter.

" ...

CLASS zcl_my_query_provider IMPLEMENTATION.

  METHOD if_rap_query_provider~select.

    mo_request = io_request.

    DATA(ls_keys) = extract_filters( ).
    DATA(lv_productid) = ls_keys-productid.

  ENDMETHOD.

ENDCLASS.
```

</div>

<div>

<img
  src="/images/filter-key-autocomplete.png"
  alt="Code completion showing the typed filter fields on ls_keys"
/>

<div class="opacity-60 text-sm pt-2">
The typed structure gives you full code completion on every filter field.
</div>

<img
  src="/images/meme4.png"
  class="rounded-lg shadow-lg max-h-[30vh] mt-4 mx-auto"
  style="width:200px;"
/>

</div>

</div>
