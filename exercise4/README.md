# Exercise 4

This exercise will test you skills with grafana

## Setup the excercise


- Skip this step if in Code Spaces.


- If on a personal computer run:

```shell
cd excercise4
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

1. Create a dashboard that shows:
    - cpu utilization
    - memory utilization

## Create an alert

1. Create an alert for 60% or more CPU utilization
1. Create an alert for 60% or more Memory Utilization

## Stress system

Execute the following command:

```shell
docker run --rm -it progrium/stress --cpu 2 \
  --io 1 --vm 2 --vm-bytes 128M --timeout 10s
```

## Demonstrate that alert fired

1. go to the CPU alert and show that it fired as expected
1.  go to the Memory alert and show that it fired as expected.

## Excercise 4 complete
