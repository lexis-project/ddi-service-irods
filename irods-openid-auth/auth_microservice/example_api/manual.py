import requests
import json
import time

print('Manual login')

req = requests.get('https://irods1.host:8080/authorize', params = {'provider': 'keycloak_openid', 'scope' : 'openid'}, verify = False)
print(req.status_code)

resp = json.loads(req.content)
nonce = resp['nonce']

print(resp['authorization_url'])

print('Waiting for token...')

time.sleep(30)

req = requests.get('https://irods1.host:8080/subject_by_nonce', params = {'block': '60', 'nonce' : nonce}, timeout=60, verify=False)

print(req.status_code)
print(req.content)


