@echo off
setlocal enabledelayedexpansion

:: Setup NAME to image and container
set IMAGE_NAME=stusthesis
set CONTAINER_NAME=latex-srv

:: Get Script PATH
set SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%SCRIPT_DIR:~0,-1%
set DOCKERFILE_DIR=%SCRIPT_DIR%
set SCRIPT_PATH=%DOCKERFILE_DIR%

:: Get User Information
set USER=%USERNAME%
for /F "tokens=1,2 delims=:" %%a in ('wmic useraccount where "name='%USERNAME%'" get sid /value') do set USERID=%%b
for /F "tokens=1,2 delims=:" %%a in ('wmic useraccount where "name='%USERNAME%'" get LocalGroupMembership /value') do set GROUPID=%%b

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

:: Function to replace script variables
:REPLACE_NAME
echo Replace Script variable

for %%F in (start.bat remove.bat stop.bat attach.bat) do (
    (for /f "usebackq tokens=1* delims==" %%A in ("%SCRIPT_PATH%\%%F") do (
        set "line=%%A"
        if "!line!"=="IMAGE_NAME=" (
            echo IMAGE_NAME=%IMAGE_NAME%
        ) else if "!line!"=="CONTAINER_NAME=" (
            echo CONTAINER_NAME=%CONTAINER_NAME%
        ) else (
            echo %%A=%%B
        )
    )) > "%SCRIPT_PATH%\%%F.new"
    move /Y "%SCRIPT_PATH%\%%F.new" "%SCRIPT_PATH%\%%F"
)

goto :EOF

:: Function to run container
:CONTAINER
set "SERVICE_NAME=%1"
echo Run container as %SERVICE_NAME%

echo Use %SERVICE_NAME% service.

:: Build the base command
set CMD=%SERVICE_NAME% image build --no-cache -t %IMAGE_NAME%:latest --build-arg USER=%USER% --build-arg USERID=%USERID% --build-arg GROUPID=%GROUPID% --build-arg PROJECT=%IMAGE_NAME%

:: Conditionally add Dockerfile for podman
if "%SERVICE_NAME%"=="podman" (
    set CMD=%CMD% -f %DOCKERFILE_DIR%\Dockerfile
) else (
    set CMD=%CMD% %DOCKERFILE_DIR%\. 
)

:: Execute the command
%CMD%

:: Run system prune and capture the output
for /f "tokens=*" %%a in ('docker system prune -f') do (
    set "output=%%a"
    echo !output!
)

:: Extract the "Total reclaimed space" line
for /f "tokens=2 delims=:" %%a in ('echo !output! ^| findstr "Total reclaimed space"') do set RECLAIMED_SPACE=%%a

:: Print the extracted value
echo Total reclaimed space: !RECLAIMED_SPACE!

goto :EOF

:: Check if Podman or Docker is running
call :IS_RUNNING "podman"
if %ERRORLEVEL%==0 (
    set CONTAINER_SERVICE=podman
) else (
    call :IS_RUNNING "dockerd"
    if %ERRORLEVEL%==0 (
        set CONTAINER_SERVICE=docker
    ) else (
        call :IS_RUNNING "colima"
        if %ERRORLEVEL%==0 (
            set CONTAINER_SERVICE=docker
        ) else (
            echo Podman or Docker are not running.
            exit /B 1
        )
    )
)

:: Call the replace_name function
call :REPLACE_NAME

:: Call the container function
call :CONTAINER %CONTAINER_SERVICE%
