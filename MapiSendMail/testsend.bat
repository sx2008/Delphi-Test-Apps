@echo off
REM So einfach kann man aus einer Batchdatei eine EMail verschicken
echo TO:shmia@bizerba.de >xx.txt
echo SUBJECT:super email >>xx.txt
echo ATTACHMENT:testsend.bat >>xx.txt
echo Hallo, das Programm ist gut !! >>xx.txt
echo Noch ne Zeile >>xx.txt
dir /S *.* >>xx.txt
mapisendmail /p /v /sd=1 xx.txt
pause



