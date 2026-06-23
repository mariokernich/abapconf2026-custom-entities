# Many calls, one request

## Separate `select`s — one OData request

A single request (e.g. a list **plus** its `$expand` navigations) triggers
**several independent `select` calls** — one per entity set / navigation.

<div class="two-col pt-2">

<div>

### What that means

- 🔁 N navigations → **N provider calls**
- 🧩 Each call is **self-contained** — its own request object
- 🔍 Each gets its **own** filter, paging & sorting
- 🛠️ Build each result **independently**

</div>

<div>

```mermaid {scale: 0.6}
flowchart TB
    subgraph REQ["One OData request"]
        direction TB
        A["select( ) Product"]
        B["select( ) _Reviews · P-001"]
        C["select( ) _Reviews · P-002"]
    end
    A --> B --> C

    classDef box fill:#fff,stroke:#000,color:#000
    classDef req fill:#f5f5f5,stroke:#000,color:#000
    class A,B,C box
    class REQ req
```

</div>

</div>

<div class="opacity-70 text-sm pt-2">
Each <code>select</code> stands on its own — if you need consistency across calls (especially for remote sources), handle it yourself.
</div>
