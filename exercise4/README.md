# Exercise 4 - Grafana Monitoring Setup

## Overview

This exercise tests your ability to:
- Deploy and configure a monitoring stack with Docker Compose
- Create effective Grafana dashboards and visualizations
- Implement system alerting with proper thresholds
- Conduct performance testing to validate monitoring systems

## Available Files

- `docker-compose.yml` - Complete monitoring stack configuration
- `prometheus.yml` - Prometheus scraping configuration  
- `grafana.ini` - Grafana server configuration
- `datasource.yaml` - Pre-configured Prometheus data source

## Step 1: Setup the Exercise Environment

### 1.1 Deploy Monitoring Stack

Skip this step if in Code Spaces.

If on a personal computer run:

```shell
cd exercise4
docker-compose up -d
```

**Expected Result**: All monitoring services (Prometheus, Grafana, Node Exporter, cAdvisor) start successfully.

## Step 2: Access Grafana Interface

### 2.1 Launch Grafana

From your computer:

1. go to `localhost:3000` in your browser

If on codespaces:

1. click ports
1. hover over `forwarded address` for the port Labeled Grafana (3000)
1. click middle icon

**Expected Result**: Grafana login page accessible with default credentials (admin/admin).

## Step 3: Create Performance Dashboards

### 3.1 Create Dashboard Visualizations

Create a dashboard(s) that shows:

#### CPU_Utilization_Gauge Dashboard
- Name dashboard `CPU_Utilization_Gauge`
- cpu utilization `Gauge` Dashboard
  - Metric should be displayed as Percentage
  - Use node metrics
    - query should be:

    ```shell
    scalar(node_load1) * 100 / count(count(node_cpu_seconds_total) by (cpu))
    ```

#### CPU_Utilization_TS Dashboard  
- cpu utilization `Time series` Dashboard
  - Name dashboard `CPU_Utilization_TS`
  - Metric should be displayed as Percentage
  - Use node metrics
    - query should be:

    ```shell
    scalar(node_load1) * 100 / count(count(node_cpu_seconds_total) by (cpu))
    ```

**Expected Result**: Two functional dashboards displaying CPU utilization as percentages.

## Step 4: Configure System Alerting

### 4.1 Create an Alert

Create an alert for 60% or more CPU utilization:
- Create alert folder called `bonkey`
- Create alert group called `wonkers`
- Evaluation at `10s`

**Expected Result**: Alert rule configured and ready to fire when CPU exceeds 60%.

## Step 5: Validate Monitoring System

### 5.1 Stress System

Execute the following command:

```shell
docker run --rm -it j0hnewhitley/docker-stress:v0.0.1 --cpu 4 \
  --io 2 --vm 4 --vm-bytes 4GB --timeout 30s
```

### 5.2 Demonstrate Alert Functionality

Go to the CPU alert and show that it fired as expected.

**Expected Result**: Alert transitions from Normal → Pending → Firing during load test, then resolves.

## Success Criteria

✅ **Infrastructure Deployment**:
- All monitoring services running without errors
- Grafana accessible and properly configured

✅ **Dashboard Creation**:
- CPU_Utilization_Gauge displays current CPU as percentage
- CPU_Utilization_TS shows CPU trends over time
- Both dashboards use correct PromQL queries

✅ **Alert Configuration**:
- Alert folder "bonkey" and group "wonkers" created
- CPU alert configured with 60% threshold
- 10-second evaluation interval set properly

✅ **System Validation**:
- Stress test successfully increases CPU load
- Alert fires during high CPU conditions
- Monitoring dashboards reflect load changes accurately

### Objectives
By completing this exercise, you will demonstrate:
- Monitoring stack deployment and configuration
- Grafana dashboard design and PromQL query usage
- Alert management and threshold configuration
- Performance testing and monitoring validation
- System observability and incident response workflows

## Exercise 4 Complete

Proceed to [Exercise 5](../exercise5/README.md)
