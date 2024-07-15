FROM ubuntu:trusty

RUN apt-get update && apt-get install --no-install-recommends -y \
    stress=1.0.4-2 && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/stress", "--verbose"]
CMD []

USER bonkey
