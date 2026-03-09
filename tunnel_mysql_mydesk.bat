@echo on
REM Tunnel MySQL via SSH

set SSH_EXE=C:\Windows\System32\OpenSSH\ssh.exe
set LOCAL_PORT=3308
set DB_HOST=localhost
set DB_PORT=3306
set SSH_USER=bi_windows_machine
set SSH_HOST=fms-mutu-prod01.sysnove.net

REM Boucle infinie pour relancer le tunnel s'il tombe
:loop
"%SSH_EXE%" ^
 -L 127.0.0.1:%LOCAL_PORT%:%DB_HOST%:%DB_PORT% ^
 %SSH_USER%@%SSH_HOST% ^
 -N -o ServerAliveInterval=30 -o ServerAliveCountMax=3

REM Si ssh sort, on attend 5s et on relance
timeout /t 5 /nobreak >nul
goto loop