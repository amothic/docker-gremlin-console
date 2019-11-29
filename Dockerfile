FROM openjdk:8-jre-alpine

ENV GREMLIN_VERSION 3.4.1

RUN set -ex \
    && apk add --no-cache --virtual .build-deps wget unzip \
    && apk add --no-cache bash gettext \
    && wget https://archive.apache.org/dist/tinkerpop/${GREMLIN_VERSION}/apache-tinkerpop-gremlin-console-${GREMLIN_VERSION}-bin.zip -O gremlin.zip \
    && unzip gremlin.zip \
    && rm gremlin.zip \
    && mv apache-tinkerpop-gremlin-console-${GREMLIN_VERSION} gremlin \
    && apk del .build-deps

COPY config /gremlin

WORKDIR /gremlin

CMD envsubst < remote.yaml.template > remote.yaml \
    && bin/gremlin.sh -i initialize.groovy
