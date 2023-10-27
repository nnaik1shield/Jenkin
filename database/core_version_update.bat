echo off
REM core_version_update.bat
REM
REM 
REM to call and with the build file and pass the command line parameters to ant as needed

if "%OS%"=="Windows_NT" @setlocal
if "%OS%"=="WINNT" @setlocal
REM if no parameters then go to useage
if ""%1""=="""" goto useage
if ""%2""=="""" goto useage
set connect_string=%1
set label=%2

sqlplus.exe -L %connect_string% @update_core_version %label%
if %errorlevel% NEQ 0 goto error_end

goto end
:useage
echo core_version_update.bat [connect_str] [label]

goto end

:error_end
echo there was an error while attempting to update the core version
echo.
echo The core version was not updated correctly

:end

if "%OS%"=="Windows_NT" @endlocal
if "%OS%"=="WINNT" @endlocal


