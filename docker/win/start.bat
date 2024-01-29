@echo off
setlocal enabledelayedexpansion

set IMAGE_NAME=stusthesis
set CONTAINER_NAME=latex-srv

:: Get Script PATH
set "SCRIPT_PATH=%~dp0"
set "SCRIPT_PATH=%SCRIPT_PATH:~0,-1%"
pushd "%SCRIPT_PATH%\..\.."
set "PROJECT_DIR=%CD%"
popd

:: Get user name
set "USER=%USERNAME%"

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

:: Function to run container
:CONTAINER
set "SERVICE_NAME=%1"
echo Run container as %SERVICE_NAME%

:: Check if the image exists
for /f "tokens=*" %%i in ('%SERVICE_NAME% images --format "{{.Repository}}:{{.Tag}}" ^| findstr /C:"%IMAGE_NAME%:latest"') do set IMAGE_EXISTS=1
if not defined IMAGE_EXISTS (
    echo Error: Image %IMAGE_NAME% not found.
    exit /B 1
)

:: Build the base command
set "CMD=%SERVICE_NAME% run -it --rm --name %CONTAINER_NAME% --workdir /home/%USER%/%IMAGE_NAME% --volume %PROJECT_DIR%:/home/%USER%/%IMAGE_NAME% --volume /etc/localtime:/etc/localtime:ro --hostname %CONTAINER_NAME%"

:: Conditionally add --userns=keep-id for podman
if "%SERVICE_NAME%"=="podman" (
    set "CMD=%CMD% --userns=keep-id"
)

:: Add the image name and run the command
set "CMD=%CMD% -d %IMAGE_NAME%"
echo Running command: %CMD%
%CMD%

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
for /f "tokens=*" %%i in ('%CONTAINER_SERVICE% ps ^| findstr /C:"%CONTAINER_NAME%"') do set CONTAINER_ID=%%i

if defined CONTAINER_ID (
    echo [msg] %CONTAINER_NAME% is running!
    exit /B 0
)

call :CONTAINER %CONTAINER_SERVICE%

:: ISSUE FUNCTION
:: testing function assign USB device to qemu podman machine
:: function podman_setup_usb { 
::     podman machine stop
::     podman machine rm
::     podman machine init --usb vendor=2e8a,product=0003
::     podman machine start
:: }
