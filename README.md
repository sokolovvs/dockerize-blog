## Before starting the app, you have to:

1. First start

```shell
bash ./init.sh
```

2. Configure your .env files.

   [dockerize-blog/.env](./.env.example)

   [blog/.env](./src/blog/.env.example)

###### You should check that params **HOST_UID** and **HOST_GID** equals the next values
```shell
id -u && id -g
```
3.

```shell
make start
```

4. To fill the database with fake data you should execute

```shell
make db-seed
```

___

## The full commands list is [here](./Makefile)

### You can use [portainer](http://localhost:19000) to manage containers and to read logs
