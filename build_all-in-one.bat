@echo off
:: BEGIN config
REM set MAIN_COMPOSE_FILE to the name of your main docker compose file. 
REM This is used to check if the Docker image already exists and to bring down any existing containers before starting new ones.
set "MAIN_COMPOSE_FILE=docker-compose_all-in-one.yml"
:: END config

:: if MAIN_COMPOSE_FILE is not empty, set DOCKER_COMPOSE_FILE to include it
if not "%MAIN_COMPOSE_FILE%"=="" (
    set "DOCKER_COMPOSE_FILE=-f %MAIN_COMPOSE_FILE%"
) else (
    set "DOCKER_COMPOSE_FILE="
)
REM If you need multiple compose files, you can set DOCKER_COMPOSE_FILE to include all of them, e.g.:
::set "DOCKER_COMPOSE_FILE=%DOCKER_COMPOSE_FILE% -f openclaw-python:latest"

:: ensure _openclaw/data and _openclaw/workspace directories exist
if not exist "_openclaw\data" (
    mkdir "_openclaw\data"
)
if not exist "_openclaw\workspace" (
    mkdir "_openclaw\workspace"
)

:: check if Docker is running by executing a simple Docker command
docker ps
if %ERRORLEVEL% NEQ 0 (
    echo !!!!!
    echo You need to start Docker Desktop before running this script.
    echo !!!!!
    exit /b 1
)

:: check if the Docker image for OpenClaw Python already exists
docker compose ls | findstr %MAIN_COMPOSE_FILE%
if %ERRORLEVEL% NEQ 0 (
    echo Building the Docker image for OpenClaw Python...
    docker compose %DOCKER_COMPOSE_FILE% build --no-cache
) else (
    echo Docker image for OpenClaw Python already exists. Skipping build.
    docker compose %DOCKER_COMPOSE_FILE% down
)

docker compose %DOCKER_COMPOSE_FILE% up -d

:: output some usage instructions
echo RUN "docker compose %DOCKER_COMPOSE_FILE% --profile cli run --rm openclaw-cli onboard"
echo to start the OpenClaw CLI and onboard the gateway.

echo RUN "docker compose %DOCKER_COMPOSE_FILE% --profile cli exec openclaw-gateway /bin/bash"
echo to open a bash shell in the OpenClaw container.