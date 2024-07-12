#!/bin/bash

if ! command -v trivy &> /dev/null
then
    echo "Error: Trivy could not be found. Please install it to continue."
    echo "https://github.com/aquasecurity/trivy#quick-start"
    exit 1
fi

trivy fs --format table --exit-code 1 --ignore-unfixed --scanners vuln,secret,misconfig --severity CRITICAL,HIGH --no-progress ./
