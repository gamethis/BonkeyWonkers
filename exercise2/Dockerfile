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
