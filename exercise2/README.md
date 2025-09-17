# Exercise 2 - Docker Container Operations

Back to [Main](../README.md)

## Overview

This exercise tests your ability to:
- Build and run Docker containers individually
- Use interactive container sessions for debugging and testing
- Troubleshoot Docker Compose configuration issues
- Test containerized web applications

## Available Files

- `Dockerfile` - Container definition for a Flask web application
- `helloworld.py` - Simple Flask app that serves a `/hello` endpoint
- `docker-compose.yaml` - Multi-container setup (contains intentional issues to fix)

## Step 1: Individual Container Operations

### 1.1 Build the Container
Build a Docker container using the provided Dockerfile:

```bash
Use the docker Command-Line Interface (CLI)
```

**Expected Result**: Container image named `hello` is created successfully.

### 1.2 Run the Container
Start the container in detached mode:

```bash
Use the docker Command-Line Interface (CLI)
```

**Expected Result**: Container starts and runs in the background.

### 1.3 Interactive Container Access
Enter the running container with an interactive bash shell:

```bash
Use the docker Command-Line Interface (CLI)
```

**Expected Result**: You should see a prompt similar to:
```shell
bonkey@c0700134dc42:/exercises#
```

### 1.4 Create and Test Script Inside Container
While inside the container:

1. Navigate to the home directory:
   ```bash
   cd ~
   ```

2. Create a script "test.sh" that outputs 'hello'

3. Run the script:
   ```bash
   ./test.sh
   ```

**Expected Result**: The script should output `hello`.

### 1.5 Exit and Clean Up
1. Exit the container:
   ```bash
   exit
   ```

2. Stop and remove the container:
   ```bash
   Use the docker Command-Line Interface (CLI)
   ```

## Step 2: Docker Compose Troubleshooting

### 2.1 Identify the Problem
Attempt to run the provided Docker Compose setup:

```bash
Use the docker Command-Line Interface (CLI)
```

**Expected Issue**: You will encounter an error related to port binding conflicts.

### 2.2 Debug and Fix
1. Analyze any errors
2. Fix any errors

### 2.3 Test the Fixed Setup
After fixing the configuration:

1. Start the containers:
   ```bash
   Use the docker Command-Line Interface (CLI)
   ```

2. Test both container endpoints using curl:
   ```bash
   curl <...>
   ```

**Expected Output** for both endpoints:
```json
{
  "data": "Hello World"
}
```

### 2.4 Clean Up
Stop and remove the containers:
```bash
docker-compose down
```

### Objectives
By completing this exercise, you will demonstrate:
- Docker container lifecycle management
- Interactive container debugging techniques
- Docker Compose troubleshooting skills
- Web application testing in containerized environments
- Port mapping and networking concepts

## Exercise 2 Complete

Once both steps are successfully completed, proceed to [Exercise 3](../exercise3/README.md).
