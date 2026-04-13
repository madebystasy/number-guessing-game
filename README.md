# Number Guessing Game

## 📌 Описание проекта

Интерактивная игра "Угадай число" на Bash с сохранением статистики в PostgreSQL. Проект выполнен в рамках обучения на freeCodeCamp.

Скрипт генерирует случайное число от 1 до 1000, приветствует пользователя, отслеживает количество игр и лучший результат, сохранённые в базе данных.

## 🗄️ Структура базы данных

База данных `number_guess` состоит из двух таблиц:

### Таблица `users`
| Колонка | Тип | Ограничения |
|:---|:---|:---|
| user_id | SERIAL | PRIMARY KEY |
| username | VARCHAR(22) | NOT NULL, UNIQUE |

### Таблица `games`
| Колонка | Тип | Ограничения |
|:---|:---|:---|
| game_id | SERIAL | PRIMARY KEY |
| user_id | INT | NOT NULL, FOREIGN KEY (users) |
| guesses | INT | NOT NULL |

## 📁 Файлы проекта

| Файл | Описание |
|:---|:---|
| `number_guess.sh` | Основной Bash-скрипт игры |
| `number_guess.sql` | Дамп базы данных |

## 🚀 Установка и запуск

### 1. Клонировать репозиторий

git clone https://github.com/madebystasy/number-guessing-game.git
cd number-guessing-game


### 2. Создать базу данных
bash
psql --username=freecodecamp --dbname=postgres
sql
CREATE DATABASE number_guess;
\c number_guess

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(22) NOT NULL UNIQUE
);

CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    guesses INT NOT NULL
);
### 3. Дать права на выполнение
bash
chmod +x number_guess.sh
### 4. Запустить игру
bash
./number_guess.sh
### 5. Восстановить базу из дампа
bash
psql -U freecodecamp postgres < number_guess.sql
### 🎮 Пример игры
text
Enter your username:
Fabio
Welcome, Fabio! It looks like this is your first time here.
Guess the secret number between 1 and 1000:
500
It's lower than that, guess again:
250
It's higher than that, guess again:
375
It's lower than that, guess again:
312
You guessed it in 4 tries. The secret number was 312. Nice job!
### Повторный вход:
text
Enter your username:
Fabio
Welcome back, Fabio! You have played 1 games, and your best game took 4 guesses.
Guess the secret number between 1 and 1000:

### 🛠️ Технологии
Bash — скриптовый язык

PostgreSQL — база данных

Git — контроль версий


### 📄 Лицензия
Проект создан в образовательных целях в рамках freeCodeCamp.
