#!/bin/bash

#REPO=""
#PERSONAL_ACCESS_TOKEN="" <- ENV of Docker

REG_TOKEN=$(curl -sX POST -H "Authorization: token ${PERSONAL_ACCESS_TOKEN}" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)

./config.sh --disableupdate --unattended --url https://github.com/${REPO} --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!