# Exercise 2

This exercise is meant to test your ability to run basic
 terraform commands and make a modification to a terraform module.

The actual outcome of this excersize is purely to ensure you can run
 basic terraform commands, and a simple test to see if you understand
 templating in terraform.  DON'T OVER THINK IT!

## Step 1 Initialize Workspace

+ Initialize, Plan, and Execute the Terraform configuration
  in the directory to create an initial `Dockerfile`.

  <details>
  <summary>
  Docker file contents
  </summary>

    ```Dockerfile
      FROM dahicks/sample:latest as build

      SHELL ["/bin/bash", "-o", "pipefail", "-c"]
      RUN useradd --no-log-init -r -g root bonkey

      COPY ${source_file} /app/main.py

      RUN cd /app && \
      chmod +x /app/main.py && \
      pip install Flask-RESTful Flask

      ENTRYPOINT ["python3", "/app/main.py"]

      USER bonkey
    ```

  </details>
  </p>

+ Build and Run the Dockerfile and ensure it works.

  <details>
  <summary>
  Expected Output
  </summary>

    ```shell
       * Serving Flask app 'main'
       * Debug mode: on
      WARNING: This is a development server. Do not use it in
               a production deployment. Use a production WSGI server instead.
       * Running on all addresses (0.0.0.0)
       * Running on http://127.0.0.1:80
       * Running on http://172.17.0.2:80
      Press CTRL+C to quit
       * Restarting with stat
       * Debugger is active!
       * Debugger PIN: 267-445-398
    ```

  </details>

## Step 2 Modify Terraform Module, Update Docker file

+ Update the Terraform template(`Dockerfile.tftpl`) file so that the resulting `Dockerfile`
  also runs the below commands inside the image as part of the run statement.

    > **NOTE:** The purpose of this exercise is to test your knowledge of
                terraform variables and templates.
                To complete this step, you should make use of a list that
                is iterated through using Terraform's
                templating to render the final `Dockerfile`

    ```shell
    whoami
    pwd
    ls -ltra
    ```

+ Run `Terraform` again
  <details>
  <summary>
  Expected Output
  </summary>

    ```DockerFile
    FROM dahicks/sample:latest as build
    SHELL ["/bin/bash", "-o", "pipefail", "-c"]
    RUN useradd --no-log-init -r -g root bonkey
    COPY helloworld.py /app/main.py

    RUN cd /app && \
      whoami && \
      pwd && \
      ls -ltra && \
      chmod +x /app/main.py && \
     pip install Flask-RESTful Flask

    ENTRYPOINT ["python3", "/app/main.py"]
    USER bonkey
    ```

  </details>

## Step 3 Build/Execute/Run Image and Validate New image

+ Build a container:
  + Using the newly created Dockerfile, build a container named `hello`.

+ Run the docker image

+ Enter the running container with with an interactive `/bin/bash` shell.
  + You should see something like

      ```shell
        root@c0700134dc42:/exercises#
      ```

## Step 4 Docker Compose debug, execute, and test

+ Run docker compose and fix any errors you encounter.
+ Curl the `/hello` endpoint on both containers.
  + output should look like follows

    ```shell
    {
      "data": "Hello World"
    }
    ```

## Excercise 2 complete

Proced to [Excercise 3](../exercise3/README.md)