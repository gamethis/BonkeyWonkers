# Bifrost Ops Interview

## Step 1
Run the current terraform configuration to create an initial `Dockerfile` and ensure it works.


## Step 2
Update the `Dockerfile` so that it also runs the below commands inside the image as part of the run statement.

```
whoami
pwd
ls -ltra
```

You should do this by adding a single variable (that is not just a simple string) to the module that is propgated to the `Dockerfile`.

Expected contents out resulting `Dockerfile`:

```
FROM golang:1.19 as build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY helloworld.go /app/main.go

RUN cd /app && \
 whoami && \
 pwd && \
 ls -ltra && \
 go mod init app && \
 go mod tidy && \
 CGO_ENABLED=0 go build -o /go/bin/app . && \
 chmod +x /go/bin/app

FROM gcr.io/distroless/static-debian11:latest

COPY --from=build /go/bin/app /

ENTRYPOINT ["/app"]
```

To run the app run:

`docker run -it hello --entrypoint /bin/bash`

To enter the container