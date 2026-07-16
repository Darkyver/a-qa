#!/bin/bash
set -e

CONTAINER_NAME="vaadin-app"
BUILD_CONTAINER="vaadin-builder"
BASE_BUILDER="vaadin-builder-base"
BRANCH="main"
CURRENT_DIR=$(pwd)

echo "🔄 Git pull..."
git checkout $BRANCH
git pull origin $BRANCH

echo "🛑 Остановка старого контейнера..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

# Проверяем, есть ли базовый образ
if ! docker image inspect $BASE_BUILDER >/dev/null 2>&1; then
    echo "🏗️ Сборка базового образа (один раз)..."
    docker build -f Dockerfile.builder-base -t $BASE_BUILDER . --pull=false
fi

echo "🔨 Сборка в Docker..."
docker build -f Dockerfile.build -t $BUILD_CONTAINER . --pull=false

echo "📦 Извлечение JAR..."
docker run --rm -v $CURRENT_DIR/target:/output $BUILD_CONTAINER sh -c "cp /app/target/*.jar /output/"

echo "🐳 Сборка runtime образа..."
docker build -t $CONTAINER_NAME . --pull=false

echo "🚀 Запуск..."
docker run -d \
  --name $CONTAINER_NAME \
  --restart=unless-stopped \
  -p 8080:8080 \
  $CONTAINER_NAME

echo "✅ Готово! http://$(hostname -I | awk '{print $1}'):8080"