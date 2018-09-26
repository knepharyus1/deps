FROM alpine:latest
MAINTAINER taemon1337@gmail.com

RUN apk add --update curl && rm -rf /var/cache/apk/*

