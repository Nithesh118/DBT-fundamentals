# 🧱 dbt Fundamentals — Azure Databricks

A hands-on dbt project built to learn and implement core dbt concepts using **Azure Databricks** as the data warehouse. Covers Medallion Architecture, Jinja templating, macros, incremental models, seeds, snapshots, and all three types of dbt tests.

---

## 🏗️ Project Structure

```
nith_dbt/
├── models/
│   ├── bronze/          # Raw layer — source data as-is
│   ├── silver/          # Cleaned & transformed layer
│   └── gold/            # Business-ready analytical layer
├── macros/
│   └── generate_schema_name.sql   # Custom schema naming macro
├── tests/
│   └── generic/
│       └── generic_non_negative.sql   # Custom generic test
├── analyses/            # Jinja templating experiments
├── seeds/
│   └── lookup.csv       # Reference/lookup data
├── snapshots/
│   └── gold_items.yml
├── sources/
│   └── sources.yml
├── dbt_project.yml
└── profiles.yml
```

---

## 🥉🥈🥇 Medallion Architecture

| Layer  | Schema | Materialization | Description |
|--------|--------|-----------------|-------------|
| Bronze | bronze | table | Raw ingestion from source — minimal transformation |
| Silver | silver | table | Cleaned, deduplicated, joined data |
| Gold   | gold   | table | Fact & dimension tables ready for analytics |

Models at each layer reference the previous layer using `{{ ref() }}`, ensuring a clean dependency graph managed by dbt.

---

## ⚙️ Tech Stack

| Tool | Purpose |
|------|---------|
| dbt (dbt-core) | Transformation framework |
| dbt-databricks adapter | Connect dbt to Azure Databricks |
| Azure Databricks | Data warehouse / compute |
| Unity Catalog | Schema & data governance |
| uv | Python environment management |
| SQL + Jinja2 | Model logic & templating |

---

## 📚 Concepts Covered

### Models & Sources
- `{{ source('source', 'table') }}` for raw source references
- `{{ ref('model_name') }}` for inter-model dependencies
- Layer-based organization: bronze → silver → gold

### Jinja Templating
- Variables, conditionals, and loops inside SQL
- Incremental load logic using Jinja `if` blocks:
```sql
{% if inc_flag == 1 %}
  where date_sk > {{ last_load }}
{% endif %}
```

### Macros
- Custom `generate_schema_name` macro to override dbt's default schema prefixing
- Ensures schemas materialize cleanly as `bronze`, `silver`, `gold` instead of `dev_bronze`, `dev_silver`, `dev_gold`

### Incremental Models
- Efficient data loading using dbt incremental materialization
- Watermark-based filtering to process only new records

### Seeds
- `lookup.csv` loaded as a seed for reference/lookup data
- Configured under `bronze` schema in `dbt_project.yml`

### Snapshots
- Implemented SCD (Slowly Changing Dimension) tracking using dbt snapshots

### Testing
Three types of dbt tests implemented:

| Test Type | Example |
|-----------|---------|
| Generic (built-in) | `not_null`, `unique`, `accepted_values` |
| Singular | Custom SQL test — `non_negative_test.sql` |
| Custom Generic | `generic_non_negative.sql` — reusable parametrized test |

### YAML Documentation
- `sources.yml` — source definitions and freshness checks
- `properties.yml` — model & column level documentation and tests
- `dbt_project.yml` — project-wide config, materializations, schema mapping

---

## 🚀 Getting Started

### Prerequisites
- Python 3.8+
- Azure Databricks workspace with a cluster
- `uv` for environment management

### Setup

```bash
# Clone the repo
git clone https://github.com/Nithesh118/DBT-fundamentals.git
cd DBT-fundamentals/nith_dbt

# Create environment using uv
uv venv
uv pip install dbt-databricks

# Configure your profiles.yml with Databricks credentials
# (host, http_path, token, catalog, schema)

# Run the project
dbt debug          # verify connection
dbt seed           # load seed files
dbt run            # run all models
dbt test           # run all tests
dbt docs generate  # generate documentation
dbt docs serve     # view docs in browser
```

---

## 🔑 Key Learnings

- dbt doesn't replace your data pipeline — it brings **software engineering discipline** (modularity, testing, version control) to the transformation layer
- `{{ ref() }}` makes dependency management automatic — no more hardcoded table names
- Custom generic tests make data quality checks **reusable across models**
- The `generate_schema_name` macro override is essential for clean multi-schema projects
- Medallion Architecture maps naturally to dbt's folder-based model organization

---

## 🗺️ Roadmap

- [x] dbt Fundamentals with Azure Databricks
- [ ] dbt + Snowflake — Airbnb dataset project
- [ ] dbt + Airflow orchestration
- [ ] dbt Cloud deployment

---

## 👤 Author

**Nithesh R** — Data Engineer  
[LinkedIn](https://www.linkedin.com/in/nitheshr118) • [GitHub](https://github.com/Nithesh118)

---

> *Built as part of a structured data engineering upskilling path — Azure Databricks · dbt · Snowflake · PySpark*
