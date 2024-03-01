# Exercise 4

This exercise will test you skills with grafana

## Launch Grafana

From your computer :

1. go to `localhost:3000` in your browser

If on codespaces:

1. click ports
1. hover over forwarded address
1. click middle icon

## Login

username is admin
password is admin
it will ask you to set it again
use admin

## Setup Data Source

import prometheus data source
the url will be
<http://prometheus:9090>

## Create a board

create a board that shows cpu and Memory utilization

## create an alert

Create an alert for 60% or more CPU utilization
Create an alert for 60% or more Memory Utilization

## Stress system

Execute the following command:

```shell
docker run --rm -it progrium/stress --cpu 2 --io 1 --vm 2 --vm-bytes 128M --timeout 10s
```

## Demonstrate that alert fired
