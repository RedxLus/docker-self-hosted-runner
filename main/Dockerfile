FROM python:3.9.12-slim-bullseye

RUN apt-get update -yqq && \
        apt-get install -yqq curl wget git gnupg unzip jq

# Install Github Runner
ENV RUNNER_ALLOW_RUNASROOT=""
ENV REPO=""
ENV PERSONAL_ACCESS_TOKEN=""
ENV EPHEMERAL=""
ENV DIR="/actions-runner"

RUN mkdir ${DIR}
ADD start-runner.sh ${DIR}/start-runner.sh
RUN chmod +x ${DIR}/start-runner.sh
RUN cd ${DIR} && \
        export ACTION_RUNNER_VERSION=$(curl --silent "https://api.github.com/repos/actions/runner/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-) && \
        curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v${ACTION_RUNNER_VERSION}/actions-runner-linux-x64-${ACTION_RUNNER_VERSION}.tar.gz && \
        tar xzf ./actions-runner-linux-x64.tar.gz
RUN ${DIR}/bin/installdependencies.sh

WORKDIR ${DIR}
ENTRYPOINT "${DIR}/start-runner.sh"