@ECHO OFF
SET RESPFILE="%1"

IF %RESPFILE%=="" GOTO ASK
sqlplus /nolog @update_win.sql "%RESPFILE%"
GOTO EOF

:ASK
sqlplus /nolog @update_win.sql ask.sql
GOTO EOF

:EOF
echo Do you need to run the AJAX rules update?
:Q1
echo	1. NO
echo	2. Update in QA
SET /p answer1=
if %answer1%==1 (
GOTO EOF2
) else if %answer1%==2 (
call ajax_qa
) else (
echo Wrong answer - try again
goto Q1
)
:EOF2
