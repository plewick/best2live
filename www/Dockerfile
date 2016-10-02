FROM nginx:mainline-alpine

COPY . /usr/share/nginx/html
RUN rm /usr/share/nginx/html/Dockerfile \
    && cd /usr/share/nginx/html \
    && mv index.php index.html
