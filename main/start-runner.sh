#!/bin/bash

#REPO=""                    <- ENV of Docker
#PERSONAL_ACCESS_TOKEN=""   <- ENV of Docker
#RUNNER_ALLOW_RUNASROOT=""  <- ENV of Docker
#EPHEMERAL="true"           <- ENV of Docker


# Set "true" for ephemeral runners. Set "false" for consistent runners

REG_TOKEN=$(curl -sX POST -H "Authorization: token ${PERSONAL_ACCESS_TOKEN}" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)

if [[ "$EPHEMERAL" == "false" ]];
then
    ./config.sh --disableupdate --unattended --url https://github.com/${REPO} --token ${REG_TOKEN}
else
    ./config.sh --disableupdate --unattended --url https://github.com/${REPO} --token ${REG_TOKEN} --ephemeral
fi

    cleanup() {
        echo "Removing runner..."
        ./config.sh remove --unattended --token ${REG_TOKEN}
    }

    trap 'cleanup; exit 130' INT
    trap 'cleanup; exit 143' TERM

    ./run.sh & wait $!
