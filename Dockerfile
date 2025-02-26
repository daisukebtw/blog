FROM alpine:latest AS build
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo
RUN apk add git
RUN hugo new site blog --format yaml
WORKDIR /blog
RUN git clone https://github.com/adityatelange/hugo-PaperMod themes/PaperMod --depth=1
COPY hugo.yaml /blog
COPY content /blog/content
RUN hugo --minify


FROM nginx:1.27.4-alpine-slim
COPY --from=build /blog/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]