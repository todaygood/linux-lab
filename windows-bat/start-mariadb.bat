

chcp 65001

REM REM是bat文件的注释类似于php的//




REM 设置不输出命令


@ECHO OFF


ECHO Starting Mariadb...




C:\Software\RunHiddenConsole.exe  C:\Software\mariadb-10.3.11-winx64\bin\mysqld.exe --console





REM SET nginx_home=D:/work/nginx/


REM %nginx_home%为获取上面set的nginx_home的值








echo find whether to start ?

tasklist | findstr mysql


PAUSE