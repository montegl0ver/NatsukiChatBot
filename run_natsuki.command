#!/bin/bash
# Запуск бота Нацуки на macOS.
# Положи этот файл в одну папку с natsuki_tsundere_bot.py и запусти двойным кликом
# (или в Терминале: ./run_natsuki.command).

cd "$(dirname "$0")" || exit 1

if ! command -v python3 >/dev/null 2>&1; then
  echo "Python 3 не найден. Установи его: https://www.python.org/downloads/macos/"
  read -n 1 -s -r -p "Нажми любую клавишу для выхода..."
  exit 1
fi

# Виртуальное окружение, чтобы не засорять систему
if [ ! -d ".venv" ]; then
  echo "Создаю виртуальное окружение..."
  python3 -m venv .venv || exit 1
fi
source .venv/bin/activate

echo "Устанавливаю/обновляю aiogram..."
pip install -q --upgrade pip
pip install -q --upgrade "aiogram>=3.7" || exit 1

# Токен: из переменной окружения, из файла .token или спросит один раз
if [ -z "$BOT_TOKEN" ]; then
  if [ -f ".token" ]; then
    BOT_TOKEN="$(cat .token)"
  else
    read -rsp "Вставь токен от @BotFather (ввод скрыт): " BOT_TOKEN
    echo
    echo "$BOT_TOKEN" > .token
    chmod 600 .token
  fi
fi
export BOT_TOKEN

echo "Запускаю Нацуки. Остановить: Ctrl+C"
python natsuki_tsundere_bot.py

read -n 1 -s -r -p "Бот остановлен. Нажми любую клавишу..."
