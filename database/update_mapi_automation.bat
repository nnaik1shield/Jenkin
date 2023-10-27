@ECHO OFF
SET MAPI_USER=%1
SET MAPI_PASSWORD=%2
SET MAPI_LOG_USER=%3
SET MAPI_LOG_PASSWORD=%4
SET DATABASE=%5

sqlplus /nolog @update_win_automation.sql ask.sql update_mapi_automation.sql "%MAPI_USER%" "%MAPI_PASSWORD%" "%MAPI_LOG_USER%" "%MAPI_LOG_PASSWORD%" "%DATABASE%"
