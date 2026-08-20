# InsuraFlow — Insurance Data Engineering Platform

InsuraFlow is a production-style insurance data engineering project designed to process and transform insurance data into reliable, analytics-ready datasets.

The project demonstrates data ingestion, validation, relational modelling, distributed processing, layered data architecture, SQL transformation, orchestration, and containerized infrastructure.

## Architecture

![InsuraFlow Architecture](docs/insuraflow_architecture.png)

### Data Flow

**Source Data → Validation → PostgreSQL → Databricks / PySpark → Bronze → Silver → Gold → dbt → Analytics**

**Apache Airflow** is used for workflow orchestration, scheduling, dependencies and retries.

**Docker** provides reproducible local infrastructure for PostgreSQL and Airflow.

---

## Project Objectives

- Build an end-to-end insurance data engineering pipeline.
- Process multiple related insurance datasets.
- Implement data validation and cleansing.
- Demonstrate Bronze, Silver and Gold data layers.
- Use PySpark for distributed data processing.
- Build analytics-ready datasets.
- Demonstrate dbt-based SQL transformation and testing.
- Demonstrate Airflow-based workflow orchestration.
- Design the pipeline with scalability, reliability and cost-awareness in mind.

---

## Data Domain

The project contains interconnected insurance datasets representing:

- Customers
- Policies
- Policy Coverage
- Claims
- Claim Assessments
- Claim Documents
- Claim Payments
- Premium Payments
- Vehicles
- Agents
- Hospitals
- Garages
- Locations
- Contracts

The relationships between these datasets allow the pipeline to perform realistic joins, validations, transformations and business aggregations.

---

## What Was Implemented

- Python-based insurance data generation and validation
- PostgreSQL database, schemas and relational tables
- Primary keys, foreign keys, constraints and indexes
- Raw/staging data ingestion
- Databricks environment and Databricks Volumes
- PySpark transformations
- Bronze, Silver and Gold data layers
- Data cleansing and quality handling
- Business aggregations
- Delta-based analytical storage
- dbt Core project initialization
- Apache Airflow project setup
- Docker-based PostgreSQL and Airflow environment
- Azure Blob Storage provisioning
- Git/GitHub version control

---

## Challenges and Limitations

### Azure Blob Storage → Databricks

The Databricks free-tier environment used during development did not provide the same cloud integration capabilities available in a full production Databricks environment.

Therefore, Azure Blob Storage was provisioned and used as the cloud storage demonstration layer, while Databricks Volumes were used for the actual development ingestion path.

### Local PostgreSQL → Databricks

A cloud Databricks environment cannot directly access a PostgreSQL server running on the developer's local machine through `localhost` or a private local IP.

The PostgreSQL pipeline was therefore developed and validated locally, while Databricks processing used data available within the Databricks environment.

### Hardware Constraints

Development was performed on a local machine with limited hardware resources. Heavy processing was therefore minimized locally, with distributed processing demonstrated through Databricks.

These limitations influenced the implementation but did not change the overall production architecture.

---

## Planned Production Enhancements

The following are planned improvements for a full production implementation:

- Azure Blob Storage → Databricks automated ingestion
- Production Airflow DAGs and scheduled execution
- Complete dbt transformation layer
- Incremental data processing
- Change Data Capture (CDC)
- Slowly Changing Dimensions (SCD Type 2)
- Automated data-quality monitoring
- CI/CD
- Azure Key Vault for secret management
- Pipeline monitoring and alerting
- Performance and cost optimization

---

## Why This Architecture?

The technologies are separated according to their responsibilities rather than using one platform for everything.

| Technology | Responsibility |
|---|---|
| **Python** | Data generation, validation and automation |
| **PostgreSQL** | Relational staging and data integrity |
| **PySpark** | Distributed data processing |
| **Databricks** | Scalable Spark processing environment |
| **Delta Lake** | Reliable analytical storage |
| **dbt** | SQL-based modelling, transformation and testing |
| **Airflow** | Scheduling, dependencies and orchestration |
| **Docker** | Reproducible local infrastructure |
| **Azure Blob Storage** | Cloud object storage |

The architecture allows each component to solve a specific engineering problem.

For example, PostgreSQL is appropriate for structured relational workloads, while Databricks and PySpark are better suited for large-scale processing. dbt provides modular SQL transformations and testing, while Airflow manages when and in what order pipeline tasks execute.

The design therefore focuses on **scalability, maintainability, data quality, reliability and cost-effectiveness**, rather than simply adding technologies to the stack.

---

## Technology Stack

**Python · SQL · PostgreSQL · PySpark · Databricks · Delta Lake · dbt Core · Apache Airflow · Docker · Azure Blob Storage · Git/GitHub**
