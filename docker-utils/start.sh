#!/bin/bash

set -eox

if [ "$(cat /build_env)" = "test" ] || [ "$(cat /build_env)" = "dev" ]; then
    ${SITE_DIR}/env/bin/pip install --editable ${SITE_DIR}/proj/ISCAN
    ${SITE_DIR}/env/bin/pip install --editable ${SITE_DIR}/proj/PolyglotDB
fi

if [ -z "$1" ]; then
	${SITE_DIR}/env/bin/python ${SITE_DIR}/proj/manage.py runserver --verbosity 3 0.0.0.0:8080
else
	if [ "$1" == 'init' ]; then
	    echo "Run Migrations"
	    ${SITE_DIR}/env/bin/python ${SITE_DIR}/proj/manage.py makemigrations
	    ${SITE_DIR}/env/bin/python ${SITE_DIR}/proj/manage.py migrate
	    #${SITE_DIR}/env/bin/python ${SITE_DIR}/proj/manage.py collectstatic --no-input --clear
	elif [ "$1" == 'manage' ]; then
	    shift
	    echo "Manage.py $@"
	    ${SITE_DIR}/env/bin/python ${SITE_DIR}/proj/manage.py $@
	elif [ "$1" == 'test' ]; then
	    ${SITE_DIR}/env/bin/python manage.py test ISCAN.tests.test_web
	elif [ "$1" == 'test_cov' ]; then
	    coverage run --source='.' manage.py test ISCAN.tests.test_web
	else
	    exec "$@"
	fi
fi
