# Exercise 2

Back to [Main](../README.md)

This exercise is meant to test your ability to run basic
 docker commands and troubleshoot issues with containers.

## Step 1 Initialize Workspace

+ Build a container:
  + Using the Dockerfile, build a container named `hello`.

+ Run the docker image

+ Enter the running container with with an interactive `/bin/bash` shell.
  + You should see something like

      ```shell
        bonkey@c0700134dc42:/exercises#
      ```

+ CD to `~`
  + Create a `test.sh` script that outputs "hello"
  + Run the script.

+ Exit and stop the container.

## Step 2 Docker Compose debug, execute, and test

+ Run docker compose and fix any errors you encounter.
+ Curl the `/hello` endpoint on both containers.
  + output should look like follows

    ```shell
    {
      "data": "Hello World"
    }
    ```

## Exercise 2 complete

Proceed to [exercise 3](../exercise3/README.md)
