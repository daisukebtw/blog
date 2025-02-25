FROM alpine:latest AS build-stage
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
RUN apk add git go
WORKDIR /blog
COPY . /blog
EXPOSE 1313
CMD ["hugo", "server", "--bind", "0.0.0.0", "--baseURL", "https://bezdar.eu/", "--disableFastRender"]