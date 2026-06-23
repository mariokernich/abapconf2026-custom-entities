# A `create` implementation

## Read entities, mutate, fill `mapped`

```abap
METHOD create FOR MODIFY
  IMPORTING entities FOR CREATE Product.

  LOOP AT entities INTO DATA(entity).

    DATA(new_id) = |P-{ cl_system_uuid=>create_uuid_c22_static( ) }|.

    INSERT zproduct FROM @( VALUE #(
      productid = new_id
      name      = entity-Name
      price     = entity-Price
      currency  = entity-Currency ) ).

    APPEND VALUE #(
      %cid      = entity-%cid
      ProductId = new_id ) TO mapped-product.

  ENDLOOP.
ENDMETHOD.
```

<div class="opacity-60 text-sm pt-2">
Same shape for <code>update</code> and <code>delete</code> — read keys, mutate, fill <code>mapped</code> / <code>failed</code> / <code>reported</code>.
</div>
