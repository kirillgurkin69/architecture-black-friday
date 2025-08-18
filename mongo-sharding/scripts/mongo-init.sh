#!/bin/bash
set -e

sleep 30

echo ">>> Инициализация config серверов..."
mongosh --host configSrv:27017 --eval 'rs.initiate({_id: "config_server", configsvr: true, members: [{ _id: 0, host: "configSrv:27017" }]})'

echo ">>> Инициализация shard1..."
mongosh --host shard1:27018 --eval 'rs.initiate({_id: "shard1", members: [{ _id: 0, host: "shard1:27018" }]})'

echo ">>> Инициализация shard2..."
mongosh --host shard2:27019 --eval 'rs.initiate({_id: "shard2", members: [{ _id: 0, host: "shard2:27019" }]})'

echo ">>> Добавление шардов..."
until mongosh --host mongos_router:27020 --eval "db.adminCommand('ping')" >/dev/null 2>&1; do
  echo "mongos_router ещё не готов, ждём 5 секунд..."
  sleep 5
done
mongosh --host mongos_router:27020 --eval 'sh.addShard("shard1/shard1:27018"); sh.addShard("shard2/shard2:27019")'

echo ">>> Создание базы и коллекции..."
mongosh --host mongos_router:27020 --eval '
  db = db.getSiblingDB("somedb");
  sh.enableSharding("somedb");
  db.createCollection("helloDoc");
  sh.shardCollection("somedb.helloDoc", { _id: "hashed" });
  for (var i = 0; i < 1000; i++) {
    db.helloDoc.insertOne({age: i, name: "ly" + i});
  }
'

