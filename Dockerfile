FROM nginxinc/nginx-unprivileged:latest
COPY data /usr/share/nginx/html/data
