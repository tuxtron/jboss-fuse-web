FROM centos:7

LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all


# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

RUN yum install -y svn

RUN yum install -y mod_ssl
RUN yum install -y http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
RUN yum install -y centos-release-scl-rh
RUN yum --enablerepo=centos-sclo-rh-testing install -y httpd24-mod_session
RUN yum install -y mod_session
COPY conf.modules.d /etc/httpd/conf.modules.d
COPY conf.d /etc/httpd/conf.d
RUN rm -rf /etc/httpd/conf/httpd.conf
ADD httpd.conf /etc/httpd/conf/httpd.conf
RUN mkdir /var/www/run
#RUN rm -rf /run/httpd/*
#RUN rm -rf /etc/httpd/logs/*
#
#RUN echo "LoadModule mpm_event_module modules/mod_mpm_event.so" >> /etc/httpd/conf/httpd.conf 
#RUN echo "LoadModule request_module modules/mod_request.so"  >> /etc/httpd/conf/httpd.conf
#RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

EXPOSE 8080 6666 8880 18182 8443

RUN rm -rf /run/httpd/* /tmp/httpd*
RUN chmod -R 777 /run/httpd
RUN chmod -R 777 /etc/httpd/logs/
#RUN mkdir -p /opt/jws-3.0/httpd/run/
#RUN mkdir -p /opt/jws-3.0/httpd/www/
#RUN mkdir -p /opt/jws-3.0/httpd/sbin/
#RUN touch /opt/jws-3.0/httpd/sbin/httpd-ssl-pass-dialog
RUN rm -f /etc/httpd/conf.d/ssl.conf
RUN chmod -R 777 /run/


CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
#CMD ["/run-httpd.sh"]