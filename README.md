# Data Mesh Demo — Declarative Automation Bundle

Complete Data Mesh implementation on Databricks with **Private Exchanges** for internal data product distribution.

## Architecture

```
┌─────────────────────────┐  ┌─────────────────────────┐  ┌─────────────────────────┐
│  adoit_product (Catalog) │  │  snow_product (Catalog)  │  │  data_mesh_hub (Catalog) │
│  Owner: EA Team          │  │  Owner: ITSM Team        │  │  Owner: Platform Team    │
├─────────────────────────┤  ├─────────────────────────┤  ├─────────────────────────┤
│ bronze → silver → gold   │  │ bronze → silver → gold   │  │ cross_domain + platform  │
│ Application Landscape    │  │ Service Health           │  │ Application Risk Profile │
└──────────┬──────────────┘  └──────────┬──────────────┘  └──────────┬──────────────┘
           │ Delta Sharing Share         │ Delta Sharing Share        │ Delta Sharing Share
           └─────────────────┬───────────┘                           │
                             ▼                                       │
              ┌──────────────────────────────────┐                   │
              │  Enterprise Data Mesh Exchange    │◄──────────────────┘
              │  (Private — invite-only)          │
              ├──────────────────────────────────┤
              │  Members: CTO Office, Risk Cmte  │
              │  Listings: 3 data products       │
              └──────────────────────────────────┘
```

## Quick Start — Recreate From Scratch

```bash
# 1. Install Databricks CLI
pip install databricks-cli

# 2. Clone this repo
git clone https://github.com/santhosh-rajashekar/data-mesh-demo.git
cd data-mesh-demo

# 3. Deploy all infrastructure + notebooks + dashboard
databricks bundle deploy --target dev

# 4. Run the orchestrator job (creates all UC objects + loads data)
databricks bundle run data_mesh_orchestrator --target dev

# 5. Complete manual steps (see below)
```

**Estimated recovery time**: ~10 min automated + ~15 min manual

## Repo Structure

```
data-mesh-demo/
├── databricks.yml                    # Bundle config + targets (dev/staging/prod)
├── resources/
│   ├── catalogs.yml                  # 3 Unity Catalog domain catalogs
│   ├── schemas.yml                   # 9 schemas (medallion per domain)
│   ├── job_orchestrator.yml          # Master job — runs all notebooks in order
│   ├── dashboard.yml                 # Lakeview dashboard (3 pages, 13 datasets)
│   └── alert.yml                     # Contract violation SQL alert
├── src/
│   ├── notebooks/
│   │   ├── 00_Data_Mesh_Overview_and_Setup.ipynb
│   │   ├── 01_ADOIT_Data_Product_Pipeline.ipynb
│   │   ├── 02_SNOW_Data_Product_Pipeline.ipynb
│   │   ├── 03_Cross_Domain_Data_Product.ipynb
│   │   ├── 04_Data_Quality_Monitoring.ipynb
│   │   ├── 05_Genie_Agent_Deployment.ipynb
│   │   ├── 06_SDP_Pipeline_Alternative.ipynb
│   │   ├── 07_Data_Product_Governance.ipynb
│   │   ├── 08_Advanced_Governance.ipynb
│   │   └── 09_Private_Exchange_Setup.ipynb
│   ├── dashboards/
│   │   └── data_mesh_product_health.lvdash.json
│   └── data/
│       ├── adoit_applications.csv
│       ├── adoit_capabilities.csv
│       ├── adoit_app_capability_map.csv
│       ├── snow_incidents.csv
│       ├── snow_change_requests.csv
│       └── platform_seed.sql
└── README.md

```

## Notebooks

| # | Notebook | Purpose |
|---|---------|---------|
| 00 | Data_Mesh_Overview_and_Setup | Infrastructure: catalogs, schemas, tables, tags, grants |
| 01 | ADOIT_Data_Product_Pipeline | EA domain: Bronze → Silver → Gold (Application Landscape) |
| 02 | SNOW_Data_Product_Pipeline | ITSM domain: Bronze → Silver → Gold (Service Health) |
| 03 | Cross_Domain_Data_Product | Cross-catalog JOIN → Application Risk Profile |
| 04 | Data_Quality_Monitoring | Quality checks across all 3 catalogs |
| 05 | Genie_Agent_Deployment | Genie Space + MLflow agent + Model Serving |
| 06 | SDP_Pipeline_Alternative | Lakeflow SDP version of SNOW pipeline |
| 07 | Data_Product_Governance | Registry, contracts, observability, maturity scorecard |
| 08 | Advanced_Governance | CDF, row-level security, automated alerting |
| 09 | Private_Exchange_Setup | Delta Sharing shares + Private Exchange marketplace |

## Manual Steps (Post-Deployment)

These steps **cannot be automated** and must be done via the Databricks UI:

### 1. Private Exchange Provider Signup (One-Time)
1. Marketplace → Provider Console → Self-service signup
2. Assign Marketplace admin role in Account Console
3. Create Provider Profile (org name, logo, description)

### 2. Create Private Listings
1. Provider Console → Listings → Create listing
2. Select share, set visibility to "Private exchange"
3. Fill in metadata (description, sample queries, use cases)
4. Repeat for all 3 data products

### 3. Create the Private Exchange
1. Provider Console → Exchanges → Create exchange
2. Name: "Enterprise Data Mesh Exchange"
3. Add members (consuming business units' sharing identifiers)
4. Assign the 3 private listings

### 4. Genie Space Setup
1. Run notebook 05 to deploy the Genie agent
2. Create Genie Space via UI or SDK with the 3 gold tables

## Variables (per target)

| Variable | Description | Default |
|----------|-------------|---------|
| `storage_account` | ADLS storage account | `sadpsddbxdev` |
| `storage_container` | Container for data products | `data-products` |
| `warehouse_id` | SQL Warehouse for dashboard/alert | — (required) |
| `adoit_catalog` | ADOIT domain catalog name | `adoit_product` |
| `snow_catalog` | SNOW domain catalog name | `snow_product` |
| `hub_catalog` | Hub catalog name | `data_mesh_hub` |

## Targets

| Target | Purpose | Catalogs |
|--------|---------|----------|
| `dev` | Development/sandbox | Default names |
| `staging` | Pre-production testing | `*_staging` suffix |
| `prod` | Production | Default names |