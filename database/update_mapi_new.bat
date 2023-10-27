@ECHO OFF
SET RESPFILE="%1"

IF %RESPFILE%=="" GOTO ASK
sqlplus /nolog @update_win_new.sql "%RESPFILE%" update_mapi.sql
GOTO EOF

:ASK
sqlplus /nolog @update_win_new.sql ask.sql update_mapi.sql
GOTO EOF

:EOF
