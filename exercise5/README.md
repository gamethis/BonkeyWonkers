# Exercise 5

Back to [Main](../README.md)

This exercise will test your basic skillset with Vault

## Go to the Vault UI

From your computer:

1. go to `localhost:8200` in your browser

If on codespaces:

1. click ports
1. hover over `forwarded address` for the port Labeled Vault (8200)
1. click middle icon

## Login to Vault

- root token is testtoken

## Create a secret via the UI

- Create any secret (keyValue pair) in the `secret/` kvv2 store

## Create a new policy for list & read only on `secret/` kvv2 store

```hcl
path "secret/*" {
  capabilities = ["read", "list"]
}
```

## Use the vault CLI to create a new token

**Note:** Use the policy created above (to used in a later step)

**Note** You'll need to use the http address and NOT https

## Demonstrate reading the secret by using the python app (getSecret.py)

## Can you explain how this could be more secure?

## Exercise 5 complete

Proceed to [Exercise 6](../exercise6/README.md)
