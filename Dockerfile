FROM node:lts-alpine

RUN apk add --no-cache git python2 build-base
COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
