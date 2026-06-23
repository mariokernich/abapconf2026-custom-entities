# Extend a custom entity

## Add fields without touching the original

Use an **`extend custom entity`** object to layer **additional fields** on top
of an existing custom entity — keeping the original definition untouched. For
**UI metadata**, use a **metadata extension**, exactly like you would for a
standard CDS view.

<div class="two-col pt-2">

<div>

### 👍 Why extend?

- ➕ Add **new fields** to an existing entity
- 🧼 Keep the **core entity** free of clutter
- 🧩 Separate **structure** from **presentation**
- 🔁 Reuse the same entity for **different** UIs / services

</div>

<div>

### 🚧 The rules

- ➕ **Fields only** — you can add elements
- 🔑 **No new keys** — keys can't be extended
- 🎨 **UI annotations** → use a **metadata extension**
- 🔗 Bound to **one** target custom entity

</div>

</div>

<div class="opacity-70 text-sm pt-2">
Same mental model as standard CDS: extend for fields, metadata extension for UI annotations.
</div>

Documentation: https://help.sap.com/doc/abapdocu_cp_index_htm/CLOUD/en-US/ABENCDS_EXTEND_CUSTOM_ENTITY.html