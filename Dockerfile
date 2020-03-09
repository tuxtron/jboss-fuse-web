FROM centos:7

LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all



COPY conf.modules.d /etc/httpd/conf.modules.d
COPY conf.d /etc/httpd/conf.d
COPY modules /etc/httpd/modules/
RUN chmod 775 /etc/httpd/modules/*
ADD conf/httpd.conf /etc/httpd/conf/httpd.conf


RUN mkdir /var/www/run
RUN rm -rf /run/httpd/*
RUN rm -rf /etc/httpd/logs/*
RUN touch /usr/share/httpd/noindex/index.html

EXPOSE 8080 6666 8880 18182 8443

CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
