@echo off
setlocal enabledelayedexpansion

set CONTAINER_NAME=latex-srv

:: Get Script PATH
set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
set DOCKERFILE_DIR=%SCRIPT_DIR%
set SCRIPT_PATH=%DOCKERFILE_DIR%

:: Function to check if a service is running
:IS_RUNNING
set "SERVICE_NAME=%1"
tasklist /FI "IMAGENAME eq %SERVICE_NAME%" 2>NUL | find /I /N "%SERVICE_NAME%">NUL
if "%ERRORLEVEL%"=="0" (
    exit /B 0
) else (
    exit /B 1
)
goto :EOF

:: Check if Podman or Docker is running
call :IS_RUNNING "podman"
if %ERRORLEVEL%==0 (
    set CONTAINER_SERVICE=podman
    echo Podman is running.
) else (
    call :IS_RUNNING "dockerd"
    if %ERRORLEVEL%==0 (
        set CONTAINER_SERVICE=docker
        echo Docker is running.
    ) else (
        call :IS_RUNNING "colima"
        if %ERRORLEVEL%==0 (
            set CONTAINER_SERVICE=docker
            echo Docker is running under Colima.
        ) else (
            echo Podman or Docker are not running.
            exit /B 1
        )
    )
)

:: Check if the container is running
for /f "tokens=*" %%i in ('%CONTAINER_SERVICE% ps ^| findstr %CONTAINER_NAME%') do set CONTAINER_ID=%%i

if not defined CONTAINER_ID (
    echo [msg] Starting %CONTAINER_NAME% Container
    call bash %SCRIPT_PATH%\start.sh

    :: Attach to container
    %CONTAINER_SERVICE% attach %CONTAINER_NAME%

    exit /B 0
) else (
    :: Attach to container
    %CONTAINER_SERVICE% attach %CONTAINER_NAME%
)
