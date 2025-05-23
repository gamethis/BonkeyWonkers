# Exercise 10

Back to [Main](../README.md)

This exercise will test your basic understanding of ansible and ansible templating.

## Start Bonkey App

### Bonkey App Step 1

Execute Ansible playbook to setup bonkey_app,

<details>
  <summary>
  Confirm that bonkey_app/DockerFile is created and looks as follows
  </summary>

  ```code
FROM dahicks/sample:latest AS build
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd --no-log-init -m -r -g root bonkey
COPY helloworld.py /app/main.py

RUN cd /app && \
    whoami && \
    pwd && \
    ls -ltra && \
    ls -ltra && \
    pip install Flask-RESTful Flask

ENTRYPOINT ["python3", "/app/main.py"]
USER bonkey

 ```

 </details>
  </p>

### Bonkey App Step 2 Docker Compose debug, execute, and test

+ Run docker compose and fix any errors you encounter.
+ Curl the `/hello` endpoint on both containers.
  + output should look like follows

    ```shell
    {
      "data": "Hello World"
    }
    ```

## Pull More images

### Bonkey Images Step 1

Update the Ansible role `bonkey` to loop through and pull all containers found in
`BonkeyContainers.yaml` vars file.

## Exercise 10 complete

Proceed to [Main](../README.md)
