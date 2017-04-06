FROM centos:centos7

####### Disable SELinux
#RUN cat /etc/selinux/config

RUN yum -y install zlib-devel.x86_64 libjpeg-turbo-devel.x86_64 \
	git gcc \
	httpd httpd-tools mod_proxy_html.x86_64
 
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
#RUN yum repolist
RUN yum -y install python-pillow.x86_64 python2-pip.noarch python-devel.x86_64
RUN yum clean all

#RUN cd /var/local && \
#	git clone https://github.com/labhackercd/wikilegis.git && \
#	cd wikilegis && ls -lha

RUN git clone https://github.com/labhackercd/wikilegis.git /var/local/wikilegis

RUN pip install -r /var/local/wikilegis/requirements.txt

### Configurar proxy reverso
ADD r_proxy.conf /etc/httpd/conf.d/

RUN cd /var/local/wikilegis && \
	./manage.py migrate && \
	./manage.py createsuperuser


RUN /var/local/wikilegis/manage.py runserver &

ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE 80


