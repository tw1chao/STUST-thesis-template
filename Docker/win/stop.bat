@echo off

docker ps | find "latex-srv" > docker.stat
set /p STAT=<docker.stat
del "docker.stat"

if "%STAT%" == "" (
	echo "[msg] latex-srv not running!"
	pause
) else (
	docker stop latex-srv
)