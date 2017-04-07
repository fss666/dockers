#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.


/var/local/wikilegis/manage.py migrate
/var/local/wikilegis/manage.py createsuperuser
/var/local/wikilegis/manage.py runserver &


