# Custom CDS Views with Unmanaged Queries in ABAP RAP

> Leveraging `IF_RAP_QUERY_PROVIDER` for full data control
>
> **abapconf 2026 · Session V9**

This repository contains everything for the abapconf 2026 talk on building **Custom
CDS Views** backed by **unmanaged queries** in ABAP RAP. It bundles two things:

1. **The presentation** — a [Slidev](https://sli.dev/) slide deck.
2. **The sample ABAP project** — the demo code shown on stage, packaged as an
   [abapGit](https://abapgit.org/) repository under [`src/`](./src).

---

## 📑 The presentation (Slidev)

The deck lives in [`slides.md`](./slides.md), which stitches together the
individual slides stored in [`pages/`](./pages). Reusable assets are in
[`components/`](./components), [`images/`](./images) and [`snippets/`](./snippets).

### Run it locally

```bash
npm install      # or: pnpm install
npm run dev      # starts Slidev and opens http://localhost:3030
```

### Other scripts

| Command           | Description                                  |
| ----------------- | -------------------------------------------- |
| `npm run dev`     | Start the live presentation server           |
| `npm run build`   | Build a static version of the deck (`dist/`) |
| `npm run export`  | Export the slides to PDF                     |

Learn more about Slidev in the [documentation](https://sli.dev/).

---

## 🧩 The sample ABAP project (abapGit)

The demo objects shown during the session are serialized as an abapGit
repository in [`src/`](./src). Pull them into your own system with
[abapGit](https://docs.abapgit.org/) (starting folder `/src/`, folder logic
`FULL`, as configured in [`.abapgit.xml`](./.abapgit.xml)).

### What's the idea?

A custom CDS view (a `custom entity`) declares its structure but delegates **all
data retrieval** to a query implementation class via
`@ObjectModel.query.implementedBy`. That class implements
`IF_RAP_QUERY_PROVIDER`, giving you full control over filtering, paging, sorting,
parameters, counting and associations — instead of letting the database resolve a
standard CDS `SELECT`.

### Key objects

| Object                                                        | Type             | Role                                                            |
| ------------------------------------------------------------ | ---------------- | -------------------------------------------------------------- |
| `ZCE_DemoProduct` ([def](./src/zce_demoproduct.ddls.asddls)) | Custom entity    | Root custom CDS view for products, query handled in ABAP       |
| `ZCE_DemoReview` ([def](./src/zce_demoreview.ddls.asddls))   | Custom entity    | Child custom CDS view for reviews, associated to products      |
| `ZCE_Weather` ([def](./src/zce_weather.ddls.asddls))         | Custom entity    | Standalone example custom entity                               |
| `ZCL_DEMO_PRODUCT_QUERY`                                      | Query class      | Implements `IF_RAP_QUERY_PROVIDER` for `ZCE_DemoProduct`       |
| `ZCL_DEMO_REVIEW_QUERY`                                       | Query class      | Implements `IF_RAP_QUERY_PROVIDER` for `ZCE_DemoReview`        |
| `ZCL_WEATHER_QUERY`                                           | Query class      | Implements `IF_RAP_QUERY_PROVIDER` for `ZCE_Weather`           |
| `ZCL_SAMPLE_IF_RAP`                                           | Sample class     | Minimal `IF_RAP_QUERY_PROVIDER` skeleton used in the slides    |
| `ZBP_CE_DEMOPRODUCT`                                          | Behavior class   | Unmanaged behavior (CUD) implementation for the product entity |
| `ZCE_DemoProduct.bdef`                                        | Behavior def.    | Behavior definition for the product custom entity              |
| `ZUI_DEMOPRODUCT`                                             | Service def./bnd | OData service definition and binding for the demo UI           |
| `ZPRODUCT` / `ZREVIEW`                                        | Tables           | Persistence backing the demo data                              |
| `ZCL_PRODUCT_SEED`                                            | Helper class     | Seeds demo product/review data                                 |

### What the demo demonstrates

- A **minimal** custom entity + query provider that returns hard-coded data.
- Reading and applying **filters / ranges** from the request, including building
  dynamic `WHERE` clauses.
- **Pagination** (paging, top/skip) and **sorting** driven by the request.
- **Parameters** on custom entities and how to read them.
- Multiple entities following the **same pattern** plus **associations** resolved
  at runtime (reading a parent key for the child query).
- **Data vs. count** requests and handling many calls within one LUW.
- Adding **unmanaged CUD behavior** on top of a custom entity.

---

## 📁 Repository structure

```
slidev/
├── slides.md            # Slidev entry point (imports pages/*)
├── pages/               # Individual slides (01-title.md … 39-thank-you.md)
├── components/          # Vue components used in slides
├── images/              # Slide images / logos
├── snippets/            # Code snippets imported into slides
├── package.json         # Slidev scripts & dependencies
├── .abapgit.xml         # abapGit configuration (starting folder /src/)
└── src/                 # Sample ABAP project (abapGit serialized objects)
```

---

## 🔗 Links

- Slidev — https://sli.dev/
- abapGit — https://abapgit.org/
- ABAP RAP query provider (`IF_RAP_QUERY_PROVIDER`) — SAP Help Portal
- SWAN GmbH — https://swan.de
