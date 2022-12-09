# BonkeyWonkers Questions

## Step 1

Run the current terraform configuration to create an initial `Dockerfile` and ensure it works.


## Step 2

Using Terraform update the `Dockerfile.tpl` file so that the resulting `Dockerfile` also runs the below commands inside the image as part of the run statement.

```
whoami
pwd
ls -ltra
```

+ You should do this by adding a single variable (that is not just a simple string) to the module that is propgated to the `Dockerfile`.

Expected contents of resulting `Dockerfile`:

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

Build the container:
`docker build . -t hello`

To run the app run:
`docker run hello`


To enter the container:
`docker run -it --entrypoint /bin/bash hello`

