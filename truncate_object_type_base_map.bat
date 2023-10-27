echo off
echo
echo Starting truncate_object_type_base_map.bat
echo
date /t
time /t
REM truncate_object_type_base_map.bat
REM Parameters are as follows
REM Position #1 ST connection string 

if "%OS%"=="Windows_NT" @setlocal
if "%OS%"=="WINNT" @setlocal

if ""%1""=="""" goto useage

set st_connect=%1%
goto start

:useage
echo correct useage for MD and API for QA is listed below
echo truncate_object_type_base_map st_user/st_pass@qa
exit /B 1
goto end

:start

CALL sqlplus.exe %st_connect% @truncate_object_type_base_map.sql %st_connect%
set SQLPlus_ExitCode=%errorlevel%

REM if the exit is clean go to the end
if %SQLPlus_ExitCode% EQU 0 goto end
echo sqlplus.exe returned a error code %SQLPlus_ExitCode%
echo exiting truncate_object_type_base_map.bat with error %SQLPlus_ExitCode%
exit /B %SQLPlus_ExitCode%

:end
set st_connect=
set SQLPlus_ExitCode=

if "%OS%"=="Windows_NT" @endlocal
if "%OS%"=="WINNT" @endlocal
echo
echo exiting truncate_object_type_base_map.bat without an error
echo
date /t
time /t
exit /B 0

