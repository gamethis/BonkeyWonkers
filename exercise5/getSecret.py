import hvac

# Authentication
client = hvac.Client(
    url="http://127.0.0.1:8200",
    token="",
)

# Reading a secret
read_response = client.secrets.kv.read_secret_version(path="")

data = read_response["data"]["data"][""]

# If this works properly, the secret you stored in vault prints
print("Secret is: " + data)
