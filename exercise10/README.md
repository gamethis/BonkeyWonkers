# Exercise 10 - Ansible & Templating

Back to [Main](../README.md)

**Time limit:** 18 minutes

This exercise will test your basic understanding of ansible and ansible templating.

## Start Bonkey App

### Task 1

Execute Ansible `bonkey_playbook.yaml` to setup bonkey_app,

<details>
  <summary>
  Confirm that bonkey_app/Dockerfile is created and looks as follows
  </summary>

  ```dockerfile
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

### Task 2

- Run docker compose and fix any errors you encounter.
- Curl the `/hello` endpoint on both containers.
  - output should look like follows

    ```shell
    {
      "data": "Hello World"
    }
    ```

## Pull More Images

### Task 3

Update the Ansible role `bonkey` to iterate through and pull all containers found
in [BonkeyContainers](./vars/BonkeyContainers.yaml) vars file.

## Exercise 10 Complete

Proceed to [Main](../README.md).
