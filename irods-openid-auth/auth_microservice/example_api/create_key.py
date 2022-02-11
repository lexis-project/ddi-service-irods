import requests
from requests.auth import HTTPBasicAuth
import json
import time

r = requests.get('https://irods1.host:8080/admin/key',
    headers={
        'Authorization':'Basic 01716f640071e595929a25d59bd292094f8f677983fb2491ae041b48b6108029'
    }, 
    params={'owner':'irods'},
    verify=False)

print(r.status_code)
print(r.content)
