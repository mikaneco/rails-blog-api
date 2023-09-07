# rails-blog-api
Simple blog api with rails

# How to run

## Install dependencies

1. Build docker image

```bash
docker-compose build
```

2. Create database and run migrations

```bash
docker-compose run --rm web db:create
docker-compose run --rm web db:migrate
```

3. Run server

```bash
docker-compose up
```


# How to use

## Create a new user

Endpoint:
```
POST /api/v1/auth
```

Body:
```json
{
  "name": "example",
  "email": "test@example.com",
  "password": "password",
  "password_confirmation": "password",
}
```

## Login 

Endpoint:
```
POST /api/v1/auth/sign_in
```

Body:
```json
{
  "name": "example",
  "email": "test@example.com",
  "password": "password",
  "password_confirmation": "password",
}
```

## Create a new article

Endpoint:
```
POST /api/v1/users/:user_id/articles
```

Headers:
```json
{
  "access-token": "example",
  "client": "example",
  "uid": "example"
}
```

Body:
```json
{
  "title": "Example title",
  "content": "Example body",
  "public_status": "public"
}
```

## Get user articles(only public)

Endpoint:
```
GET /api/v1/users/:user_id/articles
```

## Get user articles(with private and public)

Endpoint:
```
GET /api/v1/users/:user_id/articles
```
(only if you are the owner of the articles)

Headers:
```json
{
  "access-token": "example",
  "client": "example",
  "uid": "example"
}
```
