@echo off

set dir_src=..\gnupack-pretest_devel-2017.11.19\
set dir_dst=.\
set xcpyopt=/s /y /d /i /q
set cpyopt=/b /v /y

rem oz20240115a: Remove fetch app\cygwin\cygwin
rem ORG START "oz20240115a"
rem echo Fetch app\cygwin
rem xcopy %dir_src%app\cygwin %dir_dst%app\cygwin %xcpyopt%
rem ORG END   "oz20240115a"
rem CHG START "oz20240115a"
echo Fetch app\cygwin\emacs
xcopy %dir_src%app\cygwin\emacs %dir_dst%app\cygwin\emacs %xcpyopt%
echo Fetch app\cygwin\local
xcopy %dir_src%app\cygwin\local %dir_dst%app\cygwin\local %xcpyopt%
rem CHG END   "oz20240115a"

echo Fetch app\script
xcopy %dir_src%app\script %dir_dst%app\script %xcpyopt%

echo Fetch app\vim
xcopy %dir_src%app\vim %dir_dst%app\vim %xcpyopt%

echo Fetch home.defaul
xcopy %dir_src%home.default %dir_dst%home.default %xcpyopt%

echo Fetch home.preset
xcopy %dir_src%home.preset %dir_dst%home.preset %xcpyopt%

echo Fetch files
copy %cpyopt% %dir_src%desktop.ini %dir_dst%desktop.ini
copy %cpyopt% %dir_src%folder.ico %dir_dst%folder.ico
copy %cpyopt% %dir_src%run_peflagsall.exe %dir_dst%run_peflagsall.exe
copy %cpyopt% %dir_src%run_rebaseall.exe %dir_dst%run_rebaseall.exe
copy %cpyopt% %dir_src%run_takeown_icacls.exe %dir_dst%run_takeown_icacls.exe

rem oz20240115b: Remove startup_config.ini
rem DEL START "oz20240115b" 
rem copy %cpyopt% %dir_src%startup_config.ini %dir_dst%startup_config.ini
rem DEL END   "oz20240115b" 

copy %cpyopt% %dir_src%startup_cygwin.exe %dir_dst%startup_cygwin.exe
copy %cpyopt% %dir_src%startup_emacs.exe %dir_dst%startup_emacs.exe
copy %cpyopt% %dir_src%startup_emacsclient.exe %dir_dst%startup_emacsclient.exe
copy %cpyopt% %dir_src%startup_gvim.exe %dir_dst%startup_gvim.exe
copy %cpyopt% %dir_src%startup_lib.dll %dir_dst%startup_lib.dll

pause
