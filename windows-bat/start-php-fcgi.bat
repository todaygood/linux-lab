



@ECHO OFF


ECHO Starting PHP FastCGI...



set PATH=C:\Software\php-7.3.1-Win32-VC15-x64\;%PATH%




C:\Software\RunHiddenConsole.exe C:\Software\php-7.3.1-Win32-VC15-x64\php-cgi.exe -b 127.0.0.1:9123





echo find to whether to start? 

tasklist | findstr php

PAUSE 

