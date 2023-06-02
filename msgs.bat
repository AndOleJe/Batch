@Echo off
title msngr
:beg  ::Класс начало
cls
set /p a="Enter user name to send a msg: "
set /p b="Enter a msg here: "
msg /Server:"%a%" * "%b%"
if errorlevel==1 (goto error) else (
	Echo Sent succsesfuly in %time%
	timeout 3
	goto main
)
:main ::Класс после начала(Костыль)
cls
set /p a="Enter user name to send a msg: "
set /p b="Enter a msg here: "
msg * /Server:"%a%" "%b%"
if errorlevel==1 (goto error) else (
	Echo Sent succsesfuly in %time%
	timeout 3
	goto main
)
:error ::Класc ошибка
cls
Echo An error occured either check the username or LAN connection with reciever
Echo You too can execute "repair.bat" it should help
timeout 7
goto beg