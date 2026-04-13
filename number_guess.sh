#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Генерация случайного числа
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# Запрос имени
echo "Enter your username:"
read USERNAME

# Проверка длины имени
if [[ ${#USERNAME} -gt 22 ]]
then
  echo "Username must be 22 characters or less."
  exit
fi

# Поиск пользователя в базе
USER_DATA=$($PSQL "SELECT user_id, username FROM users WHERE username='$USERNAME'")

if [[ -z $USER_DATA ]]
then
  # Новый пользователь
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
else
  # Существующий пользователь
  IFS="|" read USER_ID DB_USERNAME <<< "$USER_DATA"
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Начало игры
echo "Guess the secret number between 1 and 1000:"
GUESSES=0

while true
do
  read GUESS
  
  # Проверка на целое число
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi
  
  ((GUESSES++))
  
  if [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    # Сохранить игру
    INSERT_GAME=$($PSQL "INSERT INTO games(user_id, guesses) VALUES($USER_ID, $GUESSES)")
    break
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
done