@echo off
cd /d %userprofile%\scoop\apps\frp
start /min frpc.exe -c frpc.ini