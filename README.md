# pymongo-api

## Как запустить

Перейти в папку sharding-repl-cache

```
cd ./sharding-repl-cache
```

Запускаем сборку

```shell
docker compose config -q
docker compose build
docker compose up -d
```

Останавливаем сервисы:

```bash
docker compose down -v
```

После внесения изменений рестартим:

```bash
docker compose build
docker compose up -d
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере doc

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs