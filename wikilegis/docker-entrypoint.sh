#!/bin/bash
set -e

# if command starts with an option, prepend mysqld
#if [ "${1:0:1}" = '-' ]; then
#       set -- mysqld "$@"
#fi

# Se tem arquivos de configuração personalizado
if [ -f /usr/local/wikilegis/wikilegis/settings/settings.ini ]; then

        db_engine=`cat settings.ini | awk '/DATABASE_ENGINE/{ print $0 }' | \
                        gawk 'match($0, /=(.*)(\#.*|$)/, arr) { print arr[1]}' | sed 's/ //g'`;
        db_database=`cat settings.ini | awk '/DATABASE_NAME/{ print $0 }' | \
                        gawk 'match($0, /=(.*)(\#.*|$)/, arr) { print arr[1]}' | sed 's/ //g'`;
        db_user=`cat settings.ini | awk '/DATABASE_USER/{ print $0 }' | \
                        gawk 'match($0, /=(.*)(\#.*|$)/, arr) { print arr[1]}' | sed 's/ //g'`;
        db_passwd=`cat settings.ini | awk '/DATABASE_PASSWORD/{ print $0 }' | \
                        gawk 'match($0, /=(.*)(\#.*|$)/, arr) { print arr[1]}' | sed 's/ //g'`;
        db_host=`cat settings.ini | awk '/DATABASE_HOST/{ print $0 }' | \
                        gawk 'match($0, /=(.*)(\#.*|$)/, arr) { print arr[1]}' | sed 's/ //g'`;
        db_port=`cat settings.ini | awk '/DATABASE_PORT/{ print $0 }' | \
                        gawk 'match($0, /=(.*)(\#.*|$)/, arr) { print arr[1]}' | sed 's/ //g'`;

        echo "[$db_engine]"

        if [ -z "$db_engine" ]; then
                echo>&2 'DATABASE_ENGINE not defined in settings.ini';
                exit -1;

        elif [ "$db_engine" = 'mysql' ]; then
                echo >&2 'Selecionado o banco de dados mysql...'
                if [ -z "$db_database" ]; then echo>&2 'DATABASE_NAME not defined in settings.ini'; exit -1; fi
                if [ -z "$db_user" ]; then echo>&2 'DATABASE_USER not defined in settings.ini'; exit -1; fi
                if [ -z "$db_passwd" ]; then echo>&2 'DATABASE_PASSWORD not defined in settings.ini'; exit -1; fi
                if [ -z "$db_host" ]; then echo>&2 'DATABASE_HOST not defined in settings.ini'; exit -1; fi
                if [ -z "$db_port" ]; then echo>&2 'DATABASE_PORT not defined in settings.ini'; exit -1; fi

                result="mysql -h $db_host --port=$db_port -u$db_user --password=$db_passwd $db_database -e 'show tables' | wc -l"

                if [ $result ]; then
                        echo >&2 'Database wikilegis já existe... bastar inicializar a aplicação...';
                else
                        #Precisa cria database
                        python /usr/local/wikilegis/wikilegis/manage.py migrate
                        python /usr/local/wikilegis/wikilegis/manage.py createsuperuser
                fi

        elif [ "$db_engine" = 'sqlite3' ]; then
                echo >&2 'Selecionado o banco de dados sqlite3...'
                if [ -f /usr/local/wikilegis/wikilegis/db.sqlite3 ]; then
                        echo >&2 'database SQLite já existe... basta iniciar aplicação...';

                else
                        #Precisa cria database
                        python /usr/local/wikilegis/wikilegis/manage.py migrate
                        python /usr/local/wikilegis/wikilegis/manage.py createsuperuser
                fi
        fi

fi
