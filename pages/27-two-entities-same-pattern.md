# Two entities, same pattern

## ZCE_DemoProduct + ZCE_DemoReview

<div class="two-col">

<div>

### ZCE_DemoProduct

```abap
define root custom entity ZCE_DemoProduct
{
  key ProductId : abap.char(10);
      Name      : abap.char(40);
      Price     : abap.dec(15,2);

      _Reviews  : association [0..*]
                    to ZCE_DemoReview
        on $projection.ProductId
         = _Reviews.ProductId;
}
```

</div>

<div>

### ZCE_DemoReview

```abap
define root custom entity ZCE_DemoReview
{
  key ProductId : abap.char(10);
  key ReviewId  : abap.numc(6);
      Rating    : abap.int1;
      Text   : abap.char(200);

      _Product  : association [1..1]
                    to ZCE_DemoProduct
        on $projection.ProductId
         = _Product.ProductId;
}
```

<div class="opacity-60 text-sm pt-2">
Two entities, two provider classes — same pattern.
</div>

</div>

</div>
