FROM alpine

RUN apk --no-cache update && \
    apk --no-cache add python3 py-pip py-setuptools ca-certificates groff less zip && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

RUN apk --no-cache add --update alpine-sdk

RUN apk --no-cache add bash

RUN apk --no-cache add npm

RUN apk --no-cache add jq

RUN apk --no-cache add gettext

RUN addgroup -S deployergroup && adduser -S deployeruser -G deployergroup -s /bin/bash

RUN chown -R deployeruser:deployergroup /home/deployeruser

RUN ls -lart /home/deployeruser

USER deployeruser

ADD --chown=deployeruser:deployergroup . .

WORKDIR /home/deployeruser

LABEL name="aws-cloudformation-deployer"
ARG BRANCH_NAME
ENV BRANCH_NAME ${BRANCH_NAME}

LABEL git.branch=${BRANCH_NAME}
ARG GIT_URL
LABEL git.url=${GIT_URL}
ENV GIT_URL ${GIT_URL}

ARG GIT_HASH
LABEL git.hash=${GIT_HASH}
ENV GIT_HASH ${GIT_HASH}

ARG SEMANTIC_VERSION
LABEL version=${SEMANTIC_VERSION}
ENV SEMANTIC_VERSION ${SEMANTIC_VERSION}

ARG LAST_COMMITS
LABEL lastcommits=${LAST_COMMITS}
ENV LAST_COMMITS ${LAST_COMMITS}

ARG BUILD_DATE
LABEL builddate=${BUILD_DATE}
ENV BUILD_DATE ${BUILD_DATE}
