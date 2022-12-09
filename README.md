# BonkeyWonkers Questions

## Step 1

+ Run the Terraform configuration in the directory to create an initial `Dockerfile`. 
+ Run the Dockerfile and ensure it works.

## Step 2

+ Update the Terraform  template(`Dockerfile.tpl`) file so that the resulting `Dockerfile` also runs the below commands inside the image as part of the run statement.

  ```
  whoami
  pwd
  ls -ltra
  ```

+ You should do this by adding a single variable (that is not just a simple string) to the module that is propgated to the `Dockerfile`.

+ Run `Terraform` again 
  + Expected contents of resulting `Dockerfile`:

    ```
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

## Step 3

Build a container:
  + Using the newly created Dockerfile, build a container named `hello`.

Run the docker app:
  + run the container named `hello`

Enter the container:
  + Interactively run the container.
  + Use the  entrypoint `/bin/bash hello`

## step 4

Run docker compose and hit the `/hello` endpoint on both containers fixing any errors you encounter.

