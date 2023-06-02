@Echo off
title rpr
:check ::Класс проверки прав
net session >nul 2>&1  
if %errorLevel% == 0 (
    goto beg
) else (
    echo Failure: Run as Administrator
    echo Press any key...
    pause >nul
    exit
)
:beg  ::Класс вступление
Echo Still having issues?
Echo I'm trying to repair!
set /p a="Should I repair? y/n "
if "%a%"=="y" (goto main) else (exit)
:main ::Класс исправлений в реестре, добавляет TCP 445 port
cls
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB2" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB3" /t REG_DWORD /d 1 /f
sc.exe config lanmanworkstation depend= bowser/mrxsmb20/nsi
sc.exe config mrxsmb10 start= disabled
sc.exe config lanmanserver depend= bowser/mrxsmb20/nsi
sc.exe config mrxsmb20 start= auto
sc create messenger binpath= "C:\Windows\system32\svchost.exe -k netsvcs" start= auto error= ignore DisplayName= "Messenger"
net start messenger
sc config Messenger start= auto
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v AllowRemoteRPC /t REG_DWORD /d 1 /f
netsh advfirewall firewall add rule name="TCP Port 445" dir=in action=allow protocol=TCP localport=445
cls
Echo From now should be fixed, but you need to restart PC
Echo Press any key...
pause >nul
exit