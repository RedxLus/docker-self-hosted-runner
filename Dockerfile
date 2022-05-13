FROM python:3.7.13-slim-buster

RUN apt-get -yqq update && apt-get install -yqq --no-install-recommends curl wget git gnupg unzip jq

# Install Github Runner
ENV RUNNER_ALLOW_RUNASROOT="1"
ENV REPO=""
ENV PERSONAL_ACCESS_TOKEN=""
ARG ACTION_RUNNER_VERSION="2.291.1"

RUN mkdir /actions-runner && cd /actions-runner
ADD start-runner.sh /actions-runner/start-runner.sh
RUN chmod +x /actions-runner/start-runner.sh
RUN cd /actions-runner && \
        curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v${ACTION_RUNNER_VERSION}/actions-runner-linux-x64-${ACTION_RUNNER_VERSION}.tar.gz && \
        tar xzf ./actions-runner-linux-x64.tar.gz


RUN apt-get purge -y unzip python3-pip

WORKDIR /actions-runner
ENTRYPOINT ["/actions-runner/start-runner.sh"]