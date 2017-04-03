FROM centos:centos7

####### Disable SELinux
#RUN cat /etc/selinux/config

RUN yum -y install zlib-devel.x86_64 libjpeg-turbo-devel.x86_64 \
	python-pillow.x86_64 python2-pip.noarch \
	git \
	httpd httpd-tools mod_proxy_html.x86_64
 
 
RUN cd /var/local && \
	mkdir Wikilegis && \
	cd Wikilegis && \
	git clone https://github.com/labhackercd/wikilegis.git && \
	cd wikilegis

RUN whereis pip
	
RUN pip install -r requirements.txt


### Configurar proxy reverso
ADD r_proxy.conf /etc/httpd/conf.d/

RUN cd /var/local/Wikilegis/wikilegis && \
	./manage.py migrate && \
	./manage.py createsuperuser


RUN /var/local/Wikilegis/wikilegis/manage.py runserver &
RUN yum clean all

EXPOSE 80


