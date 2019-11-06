FROM node:10.16-alpine

RUN apk add --no-cache git
COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
