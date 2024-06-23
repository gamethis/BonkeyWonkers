import hvac

# Authentication
client = hvac.Client(
    url="http://127.0.0.1:8200",
    token="",
)

# Reading a secret
# You'll need to specify the secret name you choose
read_response = client.secrets.kv.read_secret_version(path="")

# You'll need to specify the key you choose
data = read_response["data"]["data"][""]

# If this works properly, the secret you stored in vault prints
print("Secret is: " + data)
