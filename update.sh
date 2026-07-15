#!/bin/bash
set -e

APP_DIR="/app/a-qa"
CONTAINER_NAME="vaadin-app"
BRANCH="main"

echo "🔄 Обновление из Git..."
cd $APP_DIR
git checkout $BRANCH
git pull origin $BRANCH

echo "🛑 Остановка контейнера..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "🔨 Сборка образа..."
docker build -t $CONTAINER_NAME .

echo "🚀 Запуск..."
docker run -d \
  --name $CONTAINER_NAME \
  --restart=unless-stopped \
  -p 8080:8080 \
  $CONTAINER_NAME

echo "✅ Готово! http://$(hostname -I | awk '{print $1}'):8080"