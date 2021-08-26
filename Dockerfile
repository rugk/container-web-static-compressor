FROM node:slim
WORKDIR /compressor

RUN apt-get update && apt-get install -y \
    zstd \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R node:node /compressor
# drop permissions to user level
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
USER node

# load gzipper
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

# global dependencies
# https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md#global-npm-dependencies
RUN npm install -g gzipper

# debug output
RUN zstd --version \
    && node -v

# add stuff to copy data again to new volume when container is started
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
CMD ["/bin/sh", "/usr/local/bin/entrypoint.sh"]
