FROM nginxinc/nginx-unprivileged:alpine
COPY data /usr/share/nginx/html/data
