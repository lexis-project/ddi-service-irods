import requests
import json
import time


r = requests.get('https://irods1.host:8080/token',
    headers={
        'Authorization':'Basic a4a33aa05b6974cb54c7fbdcfd2d9366afbb3eeacbc0f114f71b5c58974bc726'
    }, 
    params={
        'uid':'79015f76-c3f0-4dde-bd99-cc74a38efd05',
        'provider':'keycloak_openid',
        'scope':'openid'},

verify=False)

print(r.status_code)
print(r.content)
