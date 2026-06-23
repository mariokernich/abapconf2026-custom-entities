# Search

## `$search` → free-text search expression

<div class="two-col pt-2" style="grid-template-columns: 1.1fr 1fr;">

<div>

```sql
@Search.searchable: true
define root custom entity ZCE_WEATHER
{
      @Search.defaultSearchElement: true
  key city        : abap.string;

      temperature : abap.dec(5,2);
}
```

<br/>

```abap
METHOD if_rap_query_provider~select.

  DATA(lv_search) = io_request->get_search_expression( ).

  " Pass lv_search to your Weather API call …

ENDMETHOD.
```

</div>

<div>

### 🔑 Key points

- 🏷️ `@Search.searchable` **enables** search on the entity
- ⭐ `@Search.defaultSearchElement` marks the **default** field(s)
- 🔍 `get_search_expression( )` → the **raw term** the user typed

</div>

</div>