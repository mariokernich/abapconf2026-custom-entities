# When Standard CDS gets complex

```sql
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_OrderInsightMess
  as select from snwd_so as so
  association [0..1] to snwd_bpa as _bp
    on so.buyer_guid = _bp.node_key
{
  key so.so_id,
      case when so.gross_amount > 100000
           then case when _bp.bp_role = '01'
                     then case when so.currency_code = 'EUR'
                               then 'VIP-EU' else 'VIP-XX' end
                     else 'BIG' end
           else 'STD' end                                  as segment,
      cast( so.gross_amount * 0.19 as abap.dec(15,2) )     as vat,
      // ... 30 more lines of CASE WHEN ...
      _bp.company_name
}
```

<div class="opacity-60 text-sm pt-2">
This is a real pattern. We can do better.
</div>
