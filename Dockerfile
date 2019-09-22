FROM alpine

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates groff less zip && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

RUN apk --no-cache add --update alpine-sdk

RUN apk --no-cache add bash

RUN apk --no-cache add npm

RUN apk --no-cache add jq

RUN addgroup -S deployergroup && adduser -S deployeruser -G deployergroup -s /bin/bash

RUN chown -R deployeruser:deployergroup /home/deployeruser

RUN ls -lart /home/deployeruser

USER deployeruser

ADD --chown=deployeruser:deployergroup . .

WORKDIR /home/deployeruser

LABEL shepherd.name="aws-cloudformation-deployer"
ARG BRANCH_NAME
ENV BRANCH_NAME ${BRANCH_NAME}

LABEL shepherd.git.branch=${BRANCH_NAME}
ARG GIT_URL
LABEL shepherd.git.url=${GIT_URL}
ENV GIT_URL ${GIT_URL}

ARG GIT_HASH
LABEL shepherd.git.hash=${GIT_HASH}
ENV GIT_HASH ${GIT_HASH}

ARG SEMANTIC_VERSION
LABEL shepherd.version=${SEMANTIC_VERSION}
ENV SEMANTIC_VERSION ${SEMANTIC_VERSION}

ARG LAST_COMMITS
LABEL shepherd.lastcommits=${LAST_COMMITS}
ENV LAST_COMMITS ${LAST_COMMITS}

ARG BUILD_DATE
LABEL shepherd.builddate=${BUILD_DATE}
ENV BUILD_DATE ${BUILD_DATE}
