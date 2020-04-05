FROM nginx:mainline-alpine
RUN rm /etc/nginx/conf.d/*
ADD wassup.conf /etc/nginx/conf.d/
ADD index.html /usr/share/nginx/html/
