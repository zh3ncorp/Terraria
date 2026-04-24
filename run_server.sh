#!/bin/bash
set -e

# Путь к конфигу внутри контейнера
# Ожидается, что пользователь смонтирует свой файл именно по этому пути
CONFIG_PATH="/terraria/config/serverconfig.txt"

# Существует ли файл конфигурации?
if [ ! -f "$CONFIG_PATH" ]; then
    echo "ERROR: Configuration file not found at $CONFIG_PATH"
    echo "Please mount your serverconfig.txt to this path."
    echo "Example: -v /path/on/host/serverconfig.txt:/terraria/config/serverconfig.txt"
    exit 1
fi

echo "Starting Terraria Server with config: $CONFIG_PATH"
echo "--- Config Content ---"
cat "$CONFIG_PATH"
echo "----------------------"

# Запуск сервера
exec srv/TerrariaServer -config "$CONFIG_PATH"