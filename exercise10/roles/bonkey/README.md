Role Name
=========

boney

Requirements
------------

community.docker

Role Variables
--------------

```code
bonkey_docker_var1: "whoami" # var for docker file
bonkey_docker_var2: "pwd" # var for docker file
bonkey_docker_var3: "ls -ltra" # var for docker file
bonkey_docker_var4: "chmod +x /app/main.py" # var for docker file
bonkey_image: prom/alertmanager:v0.24.0 # var for docker container to pull
```

Dependencies
------------

N/A

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

  ```yaml
  ---
  - hosts: localhost
    vars:
      images:
        - name: alertmanager
          container: prom/alertmanager:v0.24.0
    roles:
      - name: bonkey
  ```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
