# Data vs. count request

## Ask the request what it actually wants

A request may want the **data**, just the **count**, or **both**.
Check before you do expensive work — Fiori tables fire a **separate**
`$count` request to render the item counter.

<div class="two-col pt-2">

<div>

### Two independent flags

- 📄 `is_data_requested( )` → fill `set_data( )`
- 🔢 `is_total_numb_of_rec_requested( )` → fill `set_total_number_of_records( )`
- ⚖️ They are **independent** — handle every combination
- 🐌 Counting can be **cheaper** than fetching — don't read rows you won't return

</div>

<div>

```abap
METHOD if_rap_query_provider~select.
  " Only count? Skip the heavy data read.
  IF io_request->is_total_numb_of_rec_requested( ).
    DATA(count) = fetch_count( ).
    io_response->set_total_number_of_records( count ).
  ENDIF.

  " Data wanted? Read and return rows.
  IF io_request->is_data_requested( ).
    DATA(rows) = fetch_data( io_request ).
    io_response->set_data( rows ).
  ENDIF.
ENDMETHOD.
```

</div>

</div>

<div class="opacity-70 text-sm pt-2">
A `$count` request with no data still needs a number — and a data request still expects rows. Serve exactly what was asked.
</div>
