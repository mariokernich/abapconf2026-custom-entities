# Extending the example

## Annotations, associations, behavior

We add:

- UI annotations (`@UI.lineItem`, `@UI.selectionField`, ...)
- An **association** to a second custom entity
- Behavior — **create / update / delete**

```mermaid {scale: 0.95}
flowchart LR
    P[ZC_DemoProduct] -- 1 : N --> R[ZC_DemoReview]

    classDef box fill:#fff,stroke:#000,color:#000
    class P,R box
```
