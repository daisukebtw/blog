FROM hugomods/hugo:exts as builder
ARG HUGO_BASEURL=https://bezdar.eu/
ENV HUGO_BASEURL=${HUGO_BASEURL}
COPY . /src
RUN hugo --minify

FROM hugomods/hugo:nginx
EXPOSE 80
COPY --from=builder /src/public /site