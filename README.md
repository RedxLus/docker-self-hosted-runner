# Docker self-hosted Runner

![CI/CD workflow](https://github.com/RedxLus/docker-self-hosted-runner/actions/workflows/docker-image.yml/badge.svg)

## From DockerHub

Use this Docker container to run as many Github runners as you need. Is update everyday so always have the new version of Github runner.

Just check: https://hub.docker.com/r/redxlus/docker-self-hosted-runner and take a look in this repository to the dirs MAIN , SELENIUM-CHROME and SELENIUM-CHROME-MYSQL to check each Dockerfile.

Now you can pull the image from the DockerHub: 

``docker pull redxlus/docker-self-hosted-runner:latest``

Or if want specific version: 

``docker pull redxlus/docker-self-hosted-runner:2.292.0``

Or if want the version of GitHub Runner with Chrome + ChromeDriver + Selenium to use for QA: 

``docker pull redxlus/docker-self-hosted-runner:2.292.0-selenium-chrome``

Or if want the version of GitHub Runner with Chrome + ChromeDriver + Selenium + client MySQL to use for QA: 

``docker pull redxlus/docker-self-hosted-runner:2.292.0-selenium-chrome-mysqlclient``

## How to run docker container Github runner

Now to run MUST specify 2 vars: PERSONAL_ACCESS_TOKEN and REPO. And have others optionals.

| Environment Variable | Description | MUST specify or OPTIONAL |
| --- | --- | --- |
| `PERSONAL_ACCESS_TOKEN` | To get this go enter in your account in Github. Go to [Settings](https://github.com/settings/profile). Go to [Developer settings](https://github.com/settings/apps). Go to [Personal access tokens](https://github.com/settings/tokens). And generate new token with the Scope of Repo. | MUST specify |
| `REPO` | Is your Github user, a slash and your public or private repo. For example my Github user is RedxLus and this repository is docker-self-hosted-runner so both will be "RedxLus/docker-self-hosted-runner". | MUST specify |
| `RUNNER_ALLOW_RUNASROOT` | By default this runner runs without root access so you need to set up `RUNNER_ALLOW_RUNASROOT=1` if want to exec comands with sudo. | OPTIONAL |
| `EPHEMERAL` | By default this runner is ephemeral, run 1 single job and automatically unregistered. If want normal runners you need to set up `EPHEMERAL="false"` | OPTIONAL |


So when do a docker run must look like:

``docker run -e PERSONAL_ACCESS_TOKEN="ghp_23123122313123123" -e REPO="RedxLus/docker-self-hosted-runner" redxlus/docker-self-hosted-runner:latest``

If want to use in a Docker Compose. Change replicas with the number of Docker Github Runner you want:
```
version: '3'
services:
  runner:
    deploy:
      replicas: 40
    image: redxlus/docker-self-hosted-runner:latest
    restart: always
    environment:
      - PERSONAL_ACCESS_TOKEN=ghp_23123122313123123
      - REPO=RedxLus/docker-self-hosted-runner
```
      
