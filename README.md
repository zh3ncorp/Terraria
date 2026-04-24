# 🧱 Vanilla Terraria Dedicated Server (.NET Core)
Легковесный, оптимизированный образ сервера Terraria для Linux, работающий на базе **.NET 8**.  
[![Docker Pulls](https://img.shields.io/docker/pulls/zhencorp/terraria?style=flat-square&logo=docker)](https://hub.docker.com/repository/docker/zhencorp/terraria/general)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=flat-square&logo=github-actions)](https://github.com/zh3ncorp/Terraria/actions)

---

## 🚀 Быстрый старт
Самый простой способ запустить сервер с миром по умолчанию:
```bash
docker run -d \
  --name terraria \
  -p 7777:7777/tcp \
  -v ./worlds:/terraria/worlds \
  -v ./config:/terraria/config \
  zhencorp/terraria:1.4.5.6
```
⚠️ Важно: файл serverconfig.txt обязателен и должен быть смонтирован строго по пути /terraria/config/serverconfig.txt.  
В примере выше он лежит в локальной папке ./config/.  
Вы также можете смонтировать целую папку ./config (как в быстром старте ниже), но тогда файл внутри неё должен называться serverconfig.txt.  

---

## 🐳 Docker Compose (рекомендуемый способ)
```yaml
version: '3.8'

services:
  terraria:
    image: zhencorp/terraria:1.4.5.6
    container_name: terraria
    restart: unless-stopped
    ports:
      - "7777:7777/tcp"  # внутренний порт всегда должен быть 7777
    volumes:
      - ./worlds:/terraria/worlds
      - ./config:/terraria/config  # здесь обязательно должен лежать serverconfig.txt
```
Запуск:  
```bash
docker-compose up -d
```
   
<details>
  
  <summary> ⚙️ Пример содержимого serverconfig.txt c подробным описанием параметров запуска сервера (нажмите, чтобы раскрыть)</summary>

```
# Пример конфигурации сервера. 
# Значение параметра world и worldpath должно быть корректно смонтировано при запуске контейнера, чтобы мир не затирался при пересоздании контейнера. Пример монтирования для данного случая: docker run -v /host/path:/terraria/worlds
world=/terraria/worlds/docker_test.wld
worldpath=/terraria/worlds
worldname=docker_test
maxplayers=8
password=docker_test
difficulty=0
autocreate=1
language=ru-RU
motd=docker_test server
priority=1


# =============================================================================
# TERRARIA SERVER CONFIGURATION TEMPLATE
# Все параметры закомментированы. Для удобства выносим необходимые параметры в начало файла (без #)
# =============================================================================

# -----------------------------------------------------------------------------
# 1. ОСНОВНЫЕ НАСТРОЙКИ МИРА И СЕРВЕРА
# -----------------------------------------------------------------------------

# Путь к файлу мира.
# Если файл не найден, сервер остановится (если не включен autocreate).
#world=/terraria/worlds/World1.wld

# Автоматическое создание мира, если файл не найден. Мир будет создан по пути из параметра worldpath
# 1=Small, 2=Medium, 3=Large.
#autocreate=2

# Имя нового мира (используется только при autocreate).
#worldname=MyWorld

# Сид мира (ключ генерации). Оставьте пустым для случайного. (используется только при autocreate).
#seed=

# Специальные сиды (перезаписывают обычный seed, если = 1). (используется только при autocreate).
#seed_celebration=0
#seed_theconstant=0
#seed_notthebees=0
#seed_notraps=0
#seed_fortheworthy=0
#seed_remix=0
#seed_drunk=0
#seed_zenith=0

# Сложность мира. (используется только при autocreate).
# 0=Classic, 1=Expert, 2=Master, 3=Journey
#difficulty=0

# Папка для хранения миров (абсолютный путь внутри контейнера). 
# Мир появится в этой папке. Чтобы он не исчез - нужно корректно смонтировать указанный путь при запуске контейнера.
# Пример для данного случая: docker run -v /host/path:/terraria/worlds
#worldpath=/terraria/worlds

# Количество резервных копий мира для отката.
#worldrollbackstokeep=2

# -----------------------------------------------------------------------------
# 2. СЕТЕВЫЕ НАСТРОЙКИ И ДОСТУП
# -----------------------------------------------------------------------------

# Максимальное количество игроков (1-255).
#maxplayers=8

# Порт сервера, по умолчанию 7777. Может быть любым, но для работы сервера нужно правильно пробросить порт при запуске контейнера
# Пример проброса порта: docker run -p 1234:7777
# Это значит, что внутренний порт сервера будет 7777, а внешний (к которому мы будем подключаться) - 1234. Всё зависит от нужд и возможностей
# Внутренний порт ни в коем случае не менять, так как на него завязаны HEALTHCHECK. С другим портом docker будет убивать контейнер
#port=7777

# IP адрес для прослушивания (0.0.0.0 - все интерфейсы).
#ip=0.0.0.0

# Пароль для входа. Оставьте пустым для доступа без пароля.
#password=

# Сообщение дня (MotD), отображается при входе.
#motd=Welcome to my Terraria Server!

# Язык сервера (en-US, ru-RU, de-DE, fr-FR, es-ES, zh-Hans, pt-BR, ja-JP, ko-KR, pl-PL, it-IT, zh-Hant).
#language=en-US

# Автоматический проброс портов UPnP (в Docker обычно 0).
#upnp=0

# Поддержка Steam (требуется лицензия).
#steam=0

# Режим лобби Steam: friends (друзья) или private (приватный).
#lobby=private

# -----------------------------------------------------------------------------
# 3. ПРОИЗВОДИТЕЛЬНОСТЬ И БЕЗОПАСНОСТЬ
# -----------------------------------------------------------------------------

# Дополнительная защита от читов (1=вкл).
#secure=1

# Приоритет процесса сервера.
# 0:Realtime, 1:High, 2:AboveNormal, 3:Normal, 4:BelowNormal, 5:Idle
#priority=3

# Частота обновления данных NPC (меньше = плавнее, но больше трафика). 0 выключено.
#npcstream=60

# Ограничение движения жидкостей для снижения лагов (1=вкл).
#slowliquids=0

# Отключить текстовые объявления Announcement Box.
#disableannouncementbox=0

# Дальность сообщений Announcement Box (-1 для всего сервера).
#announcementboxrange=-1

# Путь к списку забаненных (по умолчанию banlist.txt в папке запуска).
#banlist=/path/to/banlist.txt

# -----------------------------------------------------------------------------
# 4. ПРАВА ДОСТУПА РЕЖИМА ПУТЕШЕСТВИЯ (Journey Mode)
# Работают только если мир создан со сложностью 3 (Journey).
# 0=Заблокировано, 1=Только хост, 2=Разрешено всем
# -----------------------------------------------------------------------------

#journeypermission_time_setfrozen=2
#journeypermission_time_setdawn=2
#journeypermission_time_setnoon=2
#journeypermission_time_setdusk=2
#journeypermission_time_setmidnight=2
#journeypermission_godmode=2
#journeypermission_wind_setstrength=2
#journeypermission_rain_setstrength=2
#journeypermission_time_setspeed=2
#journeypermission_rain_setfrozen=2
#journeypermission_wind_setfrozen=2
#journeypermission_increaseplacementrange=2
#journeypermission_setdifficulty=2
#journeypermission_biomespread_setfrozen=2
#journeypermission_setspawnrate=2
```
Все пути внутри контейнера должны начинаться с /terraria/ (рабочая директория).

</details>

---

## ❓ Часто задаваемые вопросы (FAQ)
`Вопрос`: Почему контейнер сразу завершается с ошибкой?  
`Ответ`: Скорее всего, вы не смонтировали serverconfig.txt по пути /terraria/config/serverconfig.txt. Исправьте монтирование или проверьте, что файл существует.

`Вопрос`: Как обновить сервер до новой версии?  
`Ответ`: Остановите и удалите старый контейнер, затем запустите новый с тегом новой версии (например, zhencorp/terraria:1.4.5.8). Миры и конфиги сохранятся, если вы используете тома.

`Вопрос`: Могу ли я использовать TShock?  
`Ответ`: Нет, это ванильная сборка.

`Вопрос`: Как посмотреть логи сервера?  
`Ответ`: Используйте docker logs terraria (или docker-compose logs).

---

## 📂 Тома (volumes)

| Точка монтирования в контейнере | Назначение |
| :--- | :--- |
| `/terraria/worlds` | Хранилище файлов миров (`*.wld`) |
| `/terraria/config` | Папка с `serverconfig.txt`, `banlist.txt` и др. |

> **Примечание:** образ требует только монтирования `serverconfig.txt`. Том /worlds опционален и нужен только для сохранения миров.

---
