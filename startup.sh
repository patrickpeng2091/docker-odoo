#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else

        POSTGRESQL_BIN=/usr/lib/postgresql/9.4/bin/postgres
        POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.4/main/postgresql.conf
        
        mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp
        chown postgres /var/run/postgresql/9.4-main.pg_stat_tmp
        chgrp postgres /var/run/postgresql/9.4-main.pg_stat_tmp

       /sbin/setuser postgres $POSTGRESQL_BIN --single \
                --config-file=$POSTGRESQL_CONFIG_FILE \
              <<< "UPDATE pg_database SET encoding = pg_char_to_encoding('UTF8') WHERE datname = 'template1'" &>/dev/null
        /sbin/setuser postgres $POSTGRESQL_BIN --single \
                --config-file=$POSTGRESQL_CONFIG_FILE \
                  <<< "CREATE USER odoo WITH SUPERUSER;" &>/dev/null
        /sbin/setuser postgres $POSTGRESQL_BIN --single \
                --config-file=$POSTGRESQL_CONFIG_FILE \
                <<< "ALTER USER odoo WITH PASSWORD 'postgres';" &>/dev/null
  
        sed -i 's/ssl = true/ssl = false/' /etc/postgresql/9.4/main/postgresql.conf
      
        #needed to fix problem with ubuntu ... and cron 
        update-locale
        date > /etc/configured
fi
