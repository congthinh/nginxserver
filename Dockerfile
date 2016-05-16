# Mobivi NginX Docker file
# Business Intelligence Department - Thinh Huynh
# May 2016
FROM nginx:1.9.15
MAINTAINER Thinh Huynh "thinh.hc@mobivi.vn"

#Add to sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main universe" >> /etc/apt/sources.list

# Let the conatiner know that there is no tty 
ENV DEBIAN_FRONTEND noninteractive

#Update repo
RUN apt-get update

# Download and Install Nginx
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Setup Volume 
#VOLUME ["/usr/share/nginx/html"]

# add test file 
ADD src/index.html /var/www/public/index.html
RUN chown -Rf www-data.www-data /var/www/public

# Expose ports
#EXPOSE 443
EXPOSE 80

# Set the default command to execute
# when creating a new container
#CMD ["/bin/bash", "/start.sh"]

CMD service nginx start
