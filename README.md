# BonkeyWonkers Questions

## Step 1 Initialize Workspace
+ Initialize, Plan, and Execute the Terraform configuration in the directory to create an initial `Dockerfile`. 
  + Docker file contents should be:
    ```Dockerfile
    FROM dahicks/sample:latest as build
    SHELL ["/bin/bash", "-o", "pipefail", "-c"]
    COPY helloworld.py /app/main.py

    RUN cd /app && \
      chmod +x /app/main.py && \
      pip install Flask-RESTful Flask

    ENTRYPOINT ["python3", "/app/main.py"]
    ```
+ Build and Run the Dockerfile and ensure it works.
  + Output should be:
    ```shell
       * Serving Flask app 'main'
       * Debug mode: on
      WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
       * Running on all addresses (0.0.0.0)
       * Running on http://127.0.0.1:80
       * Running on http://172.17.0.2:80
      Press CTRL+C to quit
       * Restarting with stat
       * Debugger is active!
       * Debugger PIN: 267-445-398
    ```

## Step 2 Modify Terraform Module, Update Docker file

+ Update the Terraform template(`Dockerfile.tpl`) file so that the resulting `Dockerfile` also runs the below commands inside the image as part of the run statement.  
**This must be completed using something other than a simple string variable**.

    ```
    whoami
    pwd
    ls -ltra
    ```

+ Run `Terraform` again 
  + Expected contents of resulting `Dockerfile`:

    ```DockerFile
    FROM dahicks/sample:latest as build
    SHELL ["/bin/bash", "-o", "pipefail", "-c"]
    COPY helloworld.py /app/main.py

    RUN cd /app && \
      whoami && \
      pwd && \
      ls -ltra && \
      chmod +x /app/main.py && \
     pip install Flask-RESTful Flask

    ENTRYPOINT ["python3", "/app/main.py"]
    ```

## Step 3 Build/Execute/Run Image

Build a container:
  + Using the newly created Dockerfile, build a container named `hello`.

Run the docker image:
  + Interactively run the container named `hello`.
    + Using the entrypoint flag `--entrypoint '/bin/bash'` to interactively login to the terminal of the container.
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

