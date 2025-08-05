# nginx-app

## description

## usage

### create local ssl key

```shell
cd jy-llm-app/nginx-gateway/
```

```shell
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./nginx/ssl/nginx-gateway.key \
  -out ./nginx/ssl/nginx-gateway.crt \
  -subj "/C=CN/ST=Local/L=Local/O=Local/OU=Local/CN=localhost"
```

### deploy

```shell
docker compose up -d
```
