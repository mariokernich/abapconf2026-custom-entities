# Behavior: create / update / delete

## For custom entities, behavior is "unmanaged"

You implement everything yourself.

```abap
define behavior for ZC_DemoProduct
implementation in class zbp_demo_product unique
{
  create;
  update;
  delete;

  field ( readonly ) ProductId;
}
```
