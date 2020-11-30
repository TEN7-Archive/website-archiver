FROM webdevops/base:alpine

MAINTAINER Ivan Stegic code@ivanstegic.com

COPY conf/ /opt/docker/

RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing httrack \
    && docker-image-cleanup

WORKDIR /app

CMD ["httrack"]