# The CDS Layer

## Two paths into the same Fiori pipeline

<div class="grid">

<div class="layer" :class="$clicks < 1 ? 'is-on' : 'is-off'" style="grid-area: 1/1">

```mermaid {scale: 0.55}
flowchart LR
    DB[(DB Table)] --> I[Interface View<br/>I_*]
    I --> STD[Standard<br/>CDS View]
    STD --> P[Projection<br/>R_*]
    P --> C[Consumption<br/>C_*]
    C --> SD[Service<br/>Definition]

    SD --> SB[Service<br/>Binding]
    SB --> UI[Fiori UI]

    classDef std fill:#fff,stroke:#000,color:#000
    class DB,I,STD,P,C,SD,SB,UI std
```

</div>

<div class="layer" :class="$clicks >= 1 ? 'is-on' : 'is-off'" style="grid-area: 1/1">

```mermaid {scale: 0.55}
flowchart LR
    DB[(DB Table)] --> I[Interface View<br/>I_*]
    I --> STD[Standard<br/>CDS View]
    STD --> P[Projection<br/>R_*]
    P --> C[Consumption<br/>C_*]
    C --> SD[Service<br/>Definition]

    SRC1[(DB Table)] -.-> CLS
    SRC2[API Call] -.-> CLS
    SRC3[Calculation] -.-> CLS
    CLS[ABAP Class<br/>IF_RAP_QUERY_PROVIDER] --> CUST[Custom<br/>CDS Entity]
    CUST -.->|optional| EXT[Extend Custom Entity<br/>annotations only]
    EXT -.-> SD
    CUST --> SD

    SD --> SB[Service<br/>Binding]
    SB --> UI[Fiori UI]

    classDef custom fill:#000,stroke:#000,color:#fff
    classDef std fill:#fff,stroke:#000,color:#000
    class CUST,CLS,EXT custom
    class DB,I,STD,P,C,SD,SB,UI,SRC1,SRC2,SRC3 std
```

</div>

</div>

<style>
.layer { transition: opacity .3s ease; }
.layer.is-off { opacity: 0; pointer-events: none; }
.layer.is-on { opacity: 1; }
</style>

A **Custom CDS Entity** skips the table *and* the projection stack — its data
comes from an ABAP class and it is exposed **directly** by the service definition.

<div v-click="1" class="opacity-70 text-sm">

ℹ️ **No `R_*` / `C_*` on top:** a custom entity has no persisted source, so it
**cannot** be wrapped in a classic `projection` / `consumption` view
(`select from <CustomEntity>` is not allowed). Need an annotation layer?
Put a **second custom entity** in front — not a standard projection view.

</div>
