FROM alpine:latest AS build-stage
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
RUN apk add git go
WORKDIR /blog
COPY . /blog
RUN hugo --minify


FROM nginx:1.27.4-alpine-slim AS prod-stage
COPY --from=build-stage /blog/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
