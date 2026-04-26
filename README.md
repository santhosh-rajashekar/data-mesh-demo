# Data Mesh Demo — Hub (Cross-Domain & Governance)

> **Hub workspace** in a 3-workspace Data Mesh architecture. Domain products deploy independently.

## Architecture: Hub & Spoke (Workspace-per-Domain)

| Workspace | Repo | Catalog | Data Product |
|---|---|---|---|
| dbx-dps-raise-dev | [dbx-dps-raise](https://github.com/santhosh-rajashekar/dbx-dps-raise) | `adoit_product` | Application Landscape |
| dbx-dps-snow-dev | [dbx-dp-snow](https://github.com/santhosh-rajashekar/dbx-dp-snow) | `snow_product` | Service Health |
| **Hub** (this) | [data-mesh-demo](https://github.com/santhosh-rajashekar/data-mesh-demo) | `data_mesh_hub` | Application Risk Profile |

## Hub Responsibilities

- **Cross-domain federation** — Application Risk Profile joins EA + ITSM gold products
- **Platform governance** — Centralized registry, contracts, quality checks, observability, maturity scorecard
- **Advanced governance** — CDF, UDFs (masking/filtering), contract violation alerts
- **Distribution** — Delta Sharing + Private Exchange setup
- **Dashboard** — 3-page Product Health Dashboard

## Prerequisites

Domain pipelines must run first — the hub reads from:
- `adoit_product.gold.application_landscape` (from ADOIT workspace)
- `snow_product.gold.service_health` (from SNOW workspace)

All 3 workspaces share the same Unity Catalog metastore.

## Pipeline (6 tasks)

```
setup → cross_domain → quality → governance → advanced_governance → exchange
```

## Deployment

```bash
databricks bundle deploy
databricks bundle run data_mesh_orchestrator
```
