#!/bin/bash
set -e

echo ">>> Ожидание старта Redis нод..."
for node in redis-node-1 redis-node-2 redis-node-3 redis-node-4 redis-node-5 redis-node-6; do
  until redis-cli -h $node -p 6379 ping | grep -q PONG; do
    echo "$node ещё не готов, ждём 5 секунд..."
    sleep 5
  done
done

echo ">>> Все Redis-ноды готовы. Проверяем кластер..."
# Проверяем есть ли уже кластер
if redis-cli -h redis-node-1 -p 6379 cluster info | grep -q "cluster_state:ok"; then
  echo "Redis кластер уже инициализирован."
  exit 0
fi

echo ">>> Инициализация кластера..."
yes yes | redis-cli --cluster create \
  redis-node-1:6379 redis-node-2:6379 redis-node-3:6379 \
  redis-node-4:6379 redis-node-5:6379 redis-node-6:6379 \
  --cluster-replicas 1

echo ">>> Redis кластер успешно создан."