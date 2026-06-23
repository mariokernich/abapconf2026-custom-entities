# Many calls, one LUW

## Separate `select`s — same transactional context

Each navigation is an **independent read**, but they all run inside the
**same LUW** (Logical Unit of Work) for that request.

<div class="two-col pt-2">

<div>

### What that means

- 🔁 N navigations → **N provider calls**
- 🧵 All share **one** LUW / DB transaction
- 👁️ Same **consistent** data snapshot
- 🚫 No implicit `COMMIT` between reads
- 🧩 Writes land in the **same** `save` sequence

</div>

<div>

```mermaid {scale: 0.6}
flowchart TB
    subgraph LUW["One LUW"]
        direction TB
        A["select( ) Product"]
        B["select( ) _Reviews · P-001"]
        C["select( ) _Reviews · P-002"]
    end
    A --> B --> C

    classDef box fill:#fff,stroke:#000,color:#000
    classDef luw fill:#f5f5f5,stroke:#000,color:#000
    class A,B,C box
    class LUW luw
```

</div>

</div>

<div class="opacity-70 text-sm pt-2">
Don't open your own connection per call — reuse the request's context so reads stay consistent.
</div>
