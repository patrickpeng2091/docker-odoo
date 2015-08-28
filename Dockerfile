#name of container: docker-odoo9
#versison of container: 1.1.2
FROM angelrr7702/docker-baseimage
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN echo "deb http://archive.ubuntu.com/ubuntu wily-backports main restricted " >> /etc/apt/sources.list
RUN wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
RUN echo "deb http://nightly.odoo.com/master/nightly/deb/ ./"  >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN apt-get update && apt-get install -y -q --force-yes python-software-properties \
                                            software-properties-common \
                                            node-less \
                                            postgresql \
                                            odoo \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*

# to add postgresqld deamon to runit
RUN mkdir /etc/service/postgresqld
COPY postgresqld.sh /etc/service/postgresqld/run
RUN chmod +x /etc/service/postgresqld/run

# to add odoo deamon to runit
RUN mkdir /etc/service/odoo
COPY odoo.sh /etc/service/odoo/run
RUN chmod +x /etc/service/odoo/run

##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

#pre-config scritp for different service that need to be run when container image is create 
#maybe include additional software that need to be installed ... with some service running ... like example mysqld
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf

##scritp that can be running from the outside using docker-bash tool ...
## for example to create backup for database with convitation of VOLUME   dockers-bash container_ID backup_mysql
COPY backup.sh /sbin/backup
RUN chmod +x /sbin/backup
VOLUME /var/backups

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 8069 8070

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
