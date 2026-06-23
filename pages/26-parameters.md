# Custom entities with parameters (Context info)

## Extra input — beyond filter, sort & paging

A parameter is a **mandatory input** the consumer must supply — *not* a key and
*not* a row filter. It feeds your logic **(target currency, key date, language)**
and shapes the data you serve back for the **same** entity.

<div class="two-col pt-2">

<div>

### 🎯 What they are

- 🧮 **Input** to how rows are produced
- 🔁 Drive conversions, "as-of" reads, variants
- 📥 Always **required** — consumer must pass a value
- 🧩 Entity stays the **same** — no extra keys involved

</div>

<div>

### 🆚 Not a filter, not a key

- 🚫 **Not a key** — doesn't identify a row
- 🚫 **Not a filter** — doesn't restrict the result set
- ➕ Filter narrows · parameter **informs**
- 🛠️ Read via `get_parameters( )`, not `get_filter( )`

</div>

</div>

<div class="opacity-70 text-sm pt-2">
Think "give me products <b>converted to EUR as of today</b>" — same entity, extra serving information.
</div>
