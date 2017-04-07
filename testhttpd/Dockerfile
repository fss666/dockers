FROM centos:centos7

RUN yum --disableplugin=fastestmirror -y install httpd

COPY teste.html /var/www/html/

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh

CMD ["/run-apache.sh"]
