# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose config
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