# The minimal definition

## Custom entity — no `select from`

<div class="my-8">

```abap
@EndUserText.label: 'Demo Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_DEMO_PRODUCT_QUERY'
@UI.headerInfo.typeName: 'Product'
define root custom entity ZC_DemoProduct
{
  key ProductId   : abap.char(10);
      Name        : abap.char(40);
      Price       : abap.dec(15,2);
      Currency    : abap.cuky;
      Stock       : abap.int4;
}
```

</div>

- Starting with `define custom entity`.
- No `select from` — there is no table.
- The annotation **points to the class** that delivers the data.
