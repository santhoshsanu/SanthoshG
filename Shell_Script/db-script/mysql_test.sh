#!/bin/bash

source ./db_config.sh

check_config() {
    if [ -z "$DB_HOST" ]; then    # -z  : Is the string empty?
      echo "DB_host is not set"
      exit 1     #  exit 1 :  Stop the script and return a failure status.
    fi

    if [ -z "$DB_PORT" ]; then 
      echo "DB_PORT is not set"
      exit 1
    fi

    if [ -z "$DB_USER" ]; then
      echo "DB_USER is not set"
      exit 1
    fi

    if [ -z "$DB_PASSWORD" ]; then
      echo "DB_PASSWORD is not set"
      exit 1
    fi
}

connect_to_mysql() {
    echo "Connecting to MySQL..."
    echo "Host: $DB_HOST"
    echo "Port: $DB_PORT"

    "$MY_SQL" \
        -h "$DB_HOST" \
        -P "$DB_PORT" \
        -u "$DB_USER" \
        -p"$DB_PASSWORD" \
        -e "SHOW DATABASES;"

    if [ $? -eq 0 ]; then
      echo "MYSQL connection was successfull"
    else
      echo "ERROR: MySQL connection failed"
      exit 1
    fi
}

check_config
connect_to_mysql