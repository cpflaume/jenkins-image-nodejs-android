FROM jenkins/jenkins:lts
# if we want to install via apt
USER root

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.9.1

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# install node and npm
## --> because '/bin/sh: 1: source: not found' we need to use explicite bash

RUN /bin/bash -c "source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default"

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v
 

# heroku cli installation 
RUN npm install -g heroku-cli
RUN heroku --version

# editor
RUN apt-get install -y nano	

# add libs needed in Chromium/Chrome for Tests
RUN apt-get -y install libxss1 libgconf-2-4


# Download and install Gradle 
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-4.3.1-bin.zip -o gradle-4.3.1-bin.zip && \
    unzip gradle-4.3.1-bin.zip && \
    rm  gradle-4.3.1-bin.zip 

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-4.3.1
ENV PATH=$PATH:$GRADLE_HOME/bin


# drop back to the regular jenkins user - good practice
USER jenkins
