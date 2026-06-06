FROM python:3.12-slim

WORKDIR /app
COPY helloworld.py /app/helloworld.py

RUN pip install --no-cache-dir Flask

EXPOSE 5000
ENTRYPOINT ["python3", "/app/helloworld.py"]
