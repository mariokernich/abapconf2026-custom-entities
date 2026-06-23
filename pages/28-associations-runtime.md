# How associations resolve at runtime

## Each navigation = its own provider call

The framework does **not** join for you. Expanding or drilling into an
association triggers a **separate** `if_rap_query_provider~select` call —
on the **target** entity's provider.

```mermaid {scale: 0.62}
sequenceDiagram
    autonumber
    participant UI as Fiori UI
    participant FW as RAP / OData FW
    participant PQ as ZCL_PRODUCT_QUERY
    participant RQ as ZCL_REVIEW_QUERY

    UI->>FW: GET Product
    FW->>PQ: select( ) — read products
    PQ-->>FW: products

    UI->>FW: GET Product('P-001')/_Reviews
    FW->>RQ: select( ) — filter ProductId = 'P-001'
    RQ-->>FW: reviews
    FW-->>UI: combined response
```

<div class="opacity-70 text-sm pt-2">

⚠️ `$expand=_Reviews` is just **two reads** under the hood — the parent key
arrives as a **filter** in the child's `select( )`.

</div>
