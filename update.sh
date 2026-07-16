#!/bin/bash
set -e

APP_DIR="/opt/app"
CONTAINER_NAME="vaadin-app"
BUILD_CONTAINER="vaadin-builder"
BRANCH="main"

echo "🔄 Git pull..."
cd $APP_DIR
git checkout $BRANCH
git pull origin $BRANCH

echo "🛑 Остановка старого контейнера..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "🔨 Сборка в Docker..."
docker build -f Dockerfile.build -t $BUILD_CONTAINER . --pull=false
docker run --rm -v $APP_DIR/target:/app/target $BUILD_CONTAINER

echo "🐳 Сборка runtime образа..."
docker build -t $CONTAINER_NAME . --pull=false

echo "🚀 Запуск..."
docker run -d \
  --name $CONTAINER_NAME \
  --restart=unless-stopped \
  -p 8080:8080 \
  $CONTAINER_NAME

echo "✅ Готово!"