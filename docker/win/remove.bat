@echo off
setlocal enabledelayedexpansion

set IMAGE_NAME=stusthesis

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
            echo Podman and Docker are not running.
            exit /B 1
        )
    )
)

:: Get the image ID
for /f "tokens=*" %%i in ('%CONTAINER_SERVICE% images --filter reference=%IMAGE_NAME% --format "{{.ID}}"') do set IMAGE_ID=%%i

:: Get script path
set SCRIPT_PATH=%~dp0
set SCRIPT_PATH=%SCRIPT_PATH:~0,-1%

:: Function to remove image
:REMOVE_IMAGE
echo Running %SCRIPT_PATH%\stop.bat
call %SCRIPT_PATH%\stop.bat
%CONTAINER_SERVICE% rm %IMAGE_ID% > NUL 2>&1
%CONTAINER_SERVICE% rmi %IMAGE_ID% > NUL 2>&1

:: Run system prune and capture the output
for /f "tokens=*" %%a in ('%CONTAINER_SERVICE% system prune -f') do set output=%%a

:: Extract the "Total reclaimed space" line
for /f "tokens=2 delims=:" %%b in ('echo !output! ^| findstr "Total reclaimed space"') do set reclaimed_space=%%b

:: Print the extracted value
echo Total reclaimed space: !reclaimed_space!

goto :EOF

:: Function to clear cache
:CLEAR_CACHE
%CONTAINER_SERVICE% container prune -f
%CONTAINER_SERVICE% volume prune -f
%CONTAINER_SERVICE% network prune -f
:: %CONTAINER_SERVICE% image prune -a -f
goto :EOF

:: Function to prompt confirmation
:PROMPT_CONFIRM
set /p input="Are You Sure Remove Image? [Y/n]: "
if /I "%input%"=="Y" (
    echo OK, We'll Remove Image
    call :REMOVE_IMAGE
    exit /B 0
) else if /I "%input%"=="N" (
    echo Image Will be Saved
    exit /B 0
) else (
    echo INVALID INPUT
    exit /B 1
)

:: Main logic
if defined IMAGE_ID (
    echo The Image name is %IMAGE_NAME%, and the image-ID is %IMAGE_ID%.
    call :PROMPT_CONFIRM
) else (
    echo Image not found.
)
