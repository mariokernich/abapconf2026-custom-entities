# Service & UI

## Wire it up

```abap
@EndUserText.label: 'Demo Product Service'
define service ZUI_DemoProduct {
  expose ZC_DemoProduct as Product;
}
```

Create a **Service Binding** of type *OData V2 — UI* and hit **Preview**.

```mermaid {scale: 0.85}
flowchart LR
    SD[Service Definition] --> SB[Service Binding<br/>OData V2 UI]
    SB --> P[Fiori Elements Preview]
    P --> A[Standalone App]

    classDef box fill:#fff,stroke:#000,color:#000
    class SD,SB,P,A box
```

You now have a working Fiori app backed by hand-written ABAP.
