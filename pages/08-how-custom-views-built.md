# How Custom CDS Views are built

## Three moving parts

<div class="my-8">

```mermaid {scale: 0.85}
flowchart LR
    A[Custom Entity<br/>+ provider class] --> B[Interface<br/>IF_RAP_QUERY_PROVIDER]
    B --> C[Service Definition<br/>+ Binding]
    C --> D[Fiori UI]

    classDef box fill:#fff,stroke:#000,color:#000
    class A,B,C,D box
```

</div>

1. A **custom view entity** with `@ObjectModel.query.implementedBy`
2. Freestyle defined fields without database dependence
3. An **ABAP class** implementing `IF_RAP_QUERY_PROVIDER`
4. A **service** exposing it
