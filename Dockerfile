FROM python:3.7.13-slim-buster

RUN apt-get -yqq update && apt-get install -yqq --no-install-recommends curl wget git gnupg unzip

# Install Github Runner
ADD start-runner.sh /work-runner/start-runner.sh
RUN chmod +x /work-runner/start-runner.sh
ENV RUNNER_ALLOW_RUNASROOT="1"
ARG ACTION_RUNNER_V="2.291.1"
RUN curl -o /work-runner/actions-runner-linux-x64-$ACTION_RUNNER_V.tar.gz -L https://github.com/actions/runner/releases/download/v$ACTION_RUNNER_V/actions-runner-linux-x64-$ACTION_RUNNER_V.tar.gz && tar xzf /work-runner/actions-runner-linux-x64-$ACTION_RUNNER_V.tar.gz -C /work-runner && rm /work-runner/actions-runner-linux-x64-$ACTION_RUNNER_V.tar.gz

RUN apt-get purge -y unzip python3-pip

WORKDIR /work-runner
ENTRYPOINT ["/work-runner/start-runner.sh"]