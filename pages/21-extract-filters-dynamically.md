# Dynamically extract filters by `ty_filter` type def

<div class="text-sm">

```abap
METHOD extract_filters.
  DATA(lo_struct) = CAST cl_abap_structdescr(
      cl_abap_typedescr=>describe_by_data( rs_filter ) ).
  DATA(lt_filter_cond) = mo_request->get_filter( )->get_as_ranges( ).

  LOOP AT lo_struct->components INTO DATA(ls_comp).

    ASSIGN COMPONENT ls_comp-name
        OF STRUCTURE rs_filter
        TO FIELD-SYMBOL(<fs_value>).

    READ TABLE lt_filter_cond
      WITH KEY name = ls_comp-name
      ASSIGNING FIELD-SYMBOL(<fs_cond>).

    IF sy-subrc <> 0.
      " raise exception because key / filter is not set that is in ty_filter defined
    ENDIF.

    " read filter value
    <fs_value> = <fs_cond>-range[ 1 ]-low.

  ENDLOOP.
ENDMETHOD.
```

</div>

<div class="opacity-70 text-sm pt-2">
RTTI walks the <code>ty_filter</code> components and matches each one against the request ranges — add a field to the type and it is picked up automatically, no extra code.
</div>
