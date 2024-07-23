# Exercise 4

Back to [Main](../README.md)

This exercise will test you skills with grafana

## Setup the exercise

- Skip this step if in Code Spaces.

- If on a personal computer run:

```shell
cd exercise4
docker-compose up -d
```

## Launch Grafana

From your computer :

1. go to `localhost:3000` in your browser

If on codespaces:

1. click ports
1. hover over `forwarded address` for the port Labeled Grafana (3000)
1. click middle icon

## Create a dashboard

1. Create a dashboard(s) that shows:
    - Name dashboard CPU_Utilization_Gauge
    - cpu utilization `Gauge` Dashboard
      - Metric should be displayed as Percentage
      - Use node metrics
        - query should be:

        ```shell
          scalar(node_load1) * 100 / count(count(node_cpu_seconds_total) by (cpu))`
        ```

    - cpu utilization `Time series` Dashboard
      - Name dashboard CPU_Utilization_TS
      - Metric should be displayed as Percentage
      - Use node metrics
        - query should be:

        ```shell
          scalar(node_load1) * 100 / count(count(node_cpu_seconds_total) by (cpu))`
        ```

## Create an alert

1. Create an alert for 60% or more CPU utilization
   - Create alert folder called bonkey.
   - Create alert group called wonkers.
   - Evaluation at 10s

## Stress system

Execute the following command:

```shell
docker run --rm -it j0hnewhitley/docker-stress:v0.0.1 --cpu 4 \
  --io 2 --vm 4 --vm-bytes 4GB --timeout 30s

```

## Demonstrate that alert fired

1. go to the CPU alert and show that it fired as expected

## Exercise 4 complete

Proceed to [Exercise 5](../exercise5/README.md)
