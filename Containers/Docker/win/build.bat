@echo off

docker build -t stusthesis:latest --build-arg USER=%UserName% --build-arg USERID=1000 --build-arg GROUPID=1000 %CD%\..\..\.