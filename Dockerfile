# Pull small base image
FROM progrium/busybox
RUN opkg-install curl bash git
CMD ["/bin/bash"]
COPY nginx.conf /etc/nginx/nginx.conf
COPY site.conf /etc/nginx/conf.d/site.conf

# Set Dockerfile Maintainer
MAINTAINER User_Tests_Kuberneres

# Install nginx and adjust nginx config to stay in foreground
RUN apt-get update && apt-get install --no-install-recommends -y nginx; \
 echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose HTTP
EXPOSE 80

# Start nginx
CMD ["/usr/sbin/nginx"]
