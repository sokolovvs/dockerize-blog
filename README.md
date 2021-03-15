## Before starting the app, you have to:

1.

```shell
bash ./init.sh
```

2. Configure your .env files.

   [dockerize-blog/.env](./.env.example)

   [blog/.env](./src/blog/.env.example)

```shell
cp env.example .env
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

