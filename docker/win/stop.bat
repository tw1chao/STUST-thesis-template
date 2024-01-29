@echo off
setlocal enabledelayedexpansion

set CONTAINER_NAME=latex-srv

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

:: Function to stop the container
:STOPPING_CONTAINER
set "SERVICE_NAME=%1"
echo %SERVICE_NAME% %CONTAINER_NAME% container stopping
%SERVICE_NAME% stop %CONTAINER_NAME%
goto :EOF

:: Check for container ID
for /f "tokens=*" %%i in ('%CONTAINER_SERVICE% ps ^| findstr /C:"%CONTAINER_NAME%"') do set CONTAINER_ID=%%i

:: Process command-line argument
if "%1"=="all" (
    echo [msg] %CONTAINER_SERVICE% stop and remove all containers!
    for /f "tokens=*" %%i in ('%CONTAINER_SERVICE% ps -a -q') do %CONTAINER_SERVICE% stop %%i > NUL 2>&1
    for /f "tokens=*" %%i in ('%CONTAINER_SERVICE% ps -a -q') do %CONTAINER_SERVICE% rm %%i > NUL 2>&1
) else (
    if not defined CONTAINER_ID (
        echo [msg] %CONTAINER_NAME% not running!
        exit /B 0
    ) else (
        call :STOPPING_CONTAINER %CONTAINER_SERVICE%
    )
)
