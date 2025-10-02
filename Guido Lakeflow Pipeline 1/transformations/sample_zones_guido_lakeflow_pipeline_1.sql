-- This file defines a sample transformation.
-- Edit the sample below or add new transformations
-- using "+ Add" in the file browser.

CREATE MATERIALIZED VIEW sample_zones_guido_lakeflow_pipeline_1 AS
SELECT
    pickup_zip,
    SUM(fare_amount) AS total_fare
FROM sample_trips_guido_lakeflow_pipeline_1
GROUP BY pickup_zip;
