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

## Login to grafana

- username is admin
- password is admin
- When asked to enter a new password click `skip`

## Setup Data Source

- Import prometheus data source
- The url will be: <http://prometheus:9090>

## Create a dashboard

1. Create a dashboard(s) that shows:
    - cpu utilization `Gauge` Dashboard
      - Metric should be displayed as Percentage
      - Use node metrics
        - query should be:

        ```shell
          scalar(node_load1) * 100 / count(count(node_cpu_seconds_total) by (cpu))`
        ```

    - cpu utilization `Time series` Dashboard
      - Metric should be displayed as Percentage
      - Use node metrics
        - query should be:

        ```shell
          scalar(node_load1) * 100 / count(count(node_cpu_seconds_total) by (cpu))`
        ```

## Create an alert

1. Create an alert for 60% or more CPU utilization

## Stress system

Execute the following command:

```shell
docker run --rm -it progrium/stress --cpu 4 \
  --io 2 --vm 4 --vm-bytes 4GB --timeout 30s
```

## Demonstrate that alert fired

1. go to the CPU alert and show that it fired as expected

## Exercise 4 complete
