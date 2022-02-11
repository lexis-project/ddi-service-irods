# iRODS OpenID Authentication with Keycloak

Based on this work: https://github.com/irods-contrib/irods_auth_plugin_openid

## Auth microservice
Forked from here: https://github.com/heliumdatacommons/auth_microservice

### Requirements
- Python 3
- PostgreSQL DB
- Django (ubuntu: python3-django), psycopg2 (for python3)

### Install
1. Create venv or install psycopg2 in system (ubuntu: python3-psycopg2)
2. `pip install auth_microservice/auth_microservice` (or preferably pip3 install ... / python3 -m pip install ...)
3. Run DB setup in `auth_microservice/auth_microservice/example/setup.sh`
4. Change the authentification method from the default (ident) to a user/password combination


### Keycloak config
1. Create a new client within the realm (client-id: irods-auth-plugin; or otherwise modify config.json in service config -> 4 below)
2. Set Settings->Access type to `confidential`
3. Set URLs to root url of the microservice (e.g. http://irods1.it4i.cz:8080)
4. Obtain the credentials secret UUID from Installation tab


### Service config
1. Copy example_config/\* to /etc/auth_microservice
2. Fill /etc/auth_microservice/db.key and /etc/auth_microservice/admin.key with `dd if=/dev/urandom bs=1 count=32 status=none | xxd -p -c1000`
3. Set up /etc/auth_microservice/db.credentials
4. Modify URLs in /etc/auth_microservice/config.json, add Keycloak client uuid secret

### Run
1. Use either django-admin or manage.py in `site-packages/auth_microservice`
2. `manage.py runserver 0.0.0.0:8080` (not suitable for production!)
3. If you get an error from django
django.core.exceptions.ImproperlyConfigured: 'django.db.backends.postgresql' isn't an available database backend.
Try using 'django.db.backends.XXX', where XXX is one of:
    'base', 'mysql', 'oracle', 'postgresql_psycopg2', 'sqlite3'

change base_settings.py 
backend = d.get('backend', 'django.db.backends.postgresql')
with
backend = d.get('backend', 'django.db.backends.postgresql_psycopg2')

## iRODS OpenID plugin
