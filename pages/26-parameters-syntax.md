# Parameters — define & read

## `with parameters` + `get_parameters( )`

<div class="two-col">

<div>

### Define on the entity

```abap
@ObjectModel.query.implementedBy:
  'ABAP:ZCL_DEMO_PRODUCT_QUERY'
define root custom entity ZCE_DemoProductP
  with parameters
    P_TargetCurrency : abap.cuky;
    P_KeyDate        : abap.dats;
{
  key ProductId : abap.char(10);
      Name      : abap.char(40);
      Price     : abap.dec(15,2);
      Currency  : abap.cuky;
}
```

</div>

<div>

### Read in the provider

```abap
METHOD if_rap_query_provider~select.

  " Parameters arrive as their own getter
  DATA(lt_param) =
    io_request->get_parameters( ).

  LOOP AT lt_param INTO DATA(ls_param).
    CASE ls_param-parameter_name.
      WHEN 'P_TARGETCURRENCY'.
        DATA(lv_curr) = ls_param-value.
      WHEN 'P_KEYDATE'.
        DATA(lv_date) = ls_param-value.
    ENDCASE.
  ENDLOOP.

  " ... use lv_curr / lv_date to build result

ENDMETHOD.
```

</div>

</div>

<div class="opacity-70 text-sm pt-2">
Parameters are <b>mandatory</b> — a missing value is rejected before your code runs. Consume them, just like filter and paging.
</div>
