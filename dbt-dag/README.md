Overview
========

This repo uses an Astronomer (Astro) Airflow project with the Cosmos library to orchestrate a full data pipeline powered by dbt and Snowflake.

What this project does
----------------------
- Parses and schedules dbt runs from Airflow using an Astronomer runtime image.
- Provides a sample DAG (`dags/dbt_dag.py`) which demonstrates how to run dbt via the `DbtDag` helper and map an Airflow Connection (`snowflake_conn`) to a dbt profile at runtime.

Project Contents
----------------
- `dags/`: Airflow DAGs. The dbt-running DAG is `dags/dbt_dag.py`.
- `Dockerfile`: Base Astro runtime image (where we create the dbt virtualenv).
- `packages.txt`: OS packages installed in the image.
- `requirements.txt`: Python packages (project-specific).
- `airflow_settings.yaml`: Optional local-only file for Connections, Variables, Pools (can seed `snowflake_conn`).

dbt project layout
------------------
The dbt project used by the DAG uses sample snowflake data to transform and create models. 

Requirements and setup
----------------------
1. Install Astro CLI and start the local runtime:

```bash
astro dev start
```

2. Ensure the Airflow Connection used by the DAG exists (the DAG expects `snowflake_conn`). Use the Airflow UI or the CLI inside the webserver container. Valid connection id example: `snowflake_conn`.

3. The DAG expects the dbt executable to be available in the image. By default the Dockerfile creates a venv at `$AIRFLOW_HOME/dbt_venv`; the DAG references that path. If you change where dbt is installed, update `execution_config` in `dags/dbt_dag.py`.

Running and testing
-------------------
- Start the Astro project: `astro dev start`.
- Open the Airflow UI at http://localhost:8080/ and verify the DAG `dbt_dag` appears.
- Trigger the DAG from the UI or run the dbt model tasks directly from the CLI inside the container.

Troubleshooting
---------------
- If the DAG doesn't show up, check scheduler import errors: `astro dev logs --scheduler`.
- If the API-server health check times out, inspect `astro dev logs --api-server` and increase the timeout with `astro dev start --wait 300` if startup is slow.
- If you get a 422 when creating the Airflow connection, ensure the Connection ID contains only allowed characters and `Extra` is valid JSON.
- If dbt is not found at runtime, confirm the dbt path and update `ExecutionConfig` in `dags/dbt_dag.py` to point to the container path where dbt is installed.

Further customization
---------------------
- Add Python packages to `requirements.txt` and OS packages to `packages.txt` as needed.
- Use `airflow_settings.yaml` to pre-seed connections/variables during local startup.

Contact
-------
If you need help with Astronomer or the Astro CLI, refer to Astronomer's docs: https://www.astronomer.io/docs/astro/ or ask me to help update this README with more project-specific instructions.
