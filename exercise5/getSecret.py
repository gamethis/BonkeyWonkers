import hvac
import sys

# Authentication
client = hvac.Client(
    url='http://127.0.0.1:8200',
    token='',
)

# Reading a secret
read_response = client.secrets.kv.read_secret_version(path='') # You'll need to specify the secret name you choose

password = read_response['data']['data'][''] # You'll need to specify the key you choose

print('Secret is: ' + password) # If this works properly, the secret you stored in vault prints