FROM dahicks/sample:latest as build

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY ${source_file} /app/main.py

RUN cd /app && \
 chmod +x /app/main.py && \
 pip install Flask-RESTful Flask

ENTRYPOINT ["python3", "/app/main.py"]
