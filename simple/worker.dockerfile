FROM buildbot/buildbot-worker:master

USER root

# Update the things
RUN apt-get update\
    && apt-get -y upgrade

# Add docker dependencies
RUN apt-get -y install\
    apt-transport-https\
    ca-certificates\
    curl\
    software-properties-common

# Add the gpg key and repository
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -\
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Add other dependencies
RUN apt-get update\
    && apt-get -y install\
    docker-ce\
    python3\
    python3.5

# Enable docker for non root users
RUN usermod -a -G docker buildbot \
    && usermod -a -G sudo buildbot \
    && pip install tox

RUN curl -L -s https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose\
    && chmod +x /usr/local/bin/docker-compose

RUN chown -R root /buildbot