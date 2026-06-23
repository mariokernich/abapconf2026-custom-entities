# Total count vs. result count

<div class="two-col pt-2" style="grid-template-columns: 1.2fr 1fr;">

<div>

```abap
" current page (subset)
io_response->set_data( result ).

" full dataset size
io_response->set_total_number_of_records(
  lv_total_count ).
```

</div>

<div>

### Two different numbers

- 📄 **`set_data`** → the current page only
- 🔢 **`set_total_number_of_records`** → the *whole* filtered dataset

</div>

</div>

<div class="opacity-70 text-sm pt-4">
For real database access the total typically needs an extra <code>SELECT COUNT(*)</code> over the full (filtered) dataset — it is <b>obligatory for pagination</b> and must not be mismatched with the result count.
</div>
