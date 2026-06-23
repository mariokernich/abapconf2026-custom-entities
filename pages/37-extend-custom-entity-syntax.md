# Extend a custom entity

## The `extend custom entity` syntax

```abap
" Add new fields to an existing custom entity
extend custom entity ZC_DemoProduct with
{
  Currency;
  Discount;
}
```

```abap
" UI annotations live in a metadata extension — just like standard CDS
@Metadata.layer: #CORE
annotate entity ZC_DemoProduct with
{
  @UI.facet      : [ { id: 'Product', purpose: #STANDARD,
                       type: #IDENTIFICATION_REFERENCE, label: 'Product' } ]

  @UI.lineItem       : [ { position: 10 } ]
  @UI.selectionField : [ { position: 10 } ]
  @UI.identification : [ { position: 10 } ]
  ProductId;

  @UI.lineItem       : [ { position: 20 } ]
  Name;
}
```

- `extend custom entity ... with { ... }` — adds **new fields**, but **no keys**.
- `annotate entity ... with { ... }` — the **metadata extension** holding `@UI.*`.
- Original entity stays untouched; the service exposes fields **plus** annotations.

Documentation: https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/ABENCDS_EXTEND_CUSTOM_ENTITY.html
