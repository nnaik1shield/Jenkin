echo off
echo
echo Starting ajax_refresh.bat
echo
date /t
time /t
REM ajax_refresh.bat
REM To update and refresh the AJAX data in the database \
REM Parameters are as follows
REM Position #1 MD connection string 
REM Posiiton #2 API connection string.

if "%OS%"=="Windows_NT" @setlocal
if "%OS%"=="WINNT" @setlocal

if ""%1""=="""" goto useage
if ""%2""=="""" goto useage

set md_connect=%1%
set api_connect=%2%
goto start

:useage
echo correct useage for MD and API for QA is listed below
echo ajax_refresh md_user/md_pass@qa api_user/api_pass@qa
exit /B 1
goto end

:start

CALL sqlplus.exe %api_connect% @ajax_refresh.sql %md_connect% %api_connect%
set SQLPlus_ExitCode=%errorlevel%

REM if the exit is clean go to the end
if %SQLPlus_ExitCode% EQU 0 goto end
echo sqlplus.exe returned a error code %SQLPlus_ExitCode%
echo exiting ajax_refresh.bat with error %SQLPlus_ExitCode%
exit /B %SQLPlus_ExitCode%

:end
set md_connect=
set api_connect=
set SQLPlus_ExitCode=

if "%OS%"=="Windows_NT" @endlocal
if "%OS%"=="WINNT" @endlocal
echo
echo exiting ajax_refresh.bat without an error
echo
date /t
time /t
exit /B 0

