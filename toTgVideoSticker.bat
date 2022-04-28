@echo off
:: please set your location first
SET mylocation=C:\Users\user\Downloads
SET myOutputLocation=%mylocation%

::location validation
IF NOT EXIST "%mylocation%\" (
ECHO %mylocation% not found
PAUSE
EXIT /b 0
)
::create directory if folder not found
IF NOT EXIST "%myOutputLocation%\" (
ECHO %myOutputLocation% not found, create directory for you now
MKDIR "%myOutputLocation%"
PAUSE
)

CD %CD%

:: config
SET /p myfilename="Enter your filename: "
SET /p myoutputname="Enter your Output webm filename (Dont include .webm):"
SET filetype=.webm
SET mywebmname=%myoutputname%%filetype%
SET fps=30 
:: fps better around 20 ~ 30
SET quality=800K
:: quality, please set it low if over size, 500K ~ 800K recommended

::location validation
IF NOT EXIST "%mylocation%/%myfilename%" (
ECHO %mylocation%\%myfilename% not found
PAUSE
EXIT /b 0
)

:: ========== Remarks ====================
:: -r 30 = fps 30
:: scale=-1:512, crop=512:512 = scale to 512, then crop to 512:512
:: -b:v 800K = 800K quality
:: libvpx-vp9 for vp9
:: ========== Remarks ====================

FOR /F %%F IN ('ffprobe.exe -v error -hide_banner -show_entries stream^=width -of default^=noprint_wrappers^=1:nokey^=1 "%mylocation%\%myfilename%"') DO (SET mywidth=%%F)

FOR /F %%G IN ('ffprobe.exe -v error -hide_banner -show_entries stream^=height -of default^=noprint_wrappers^=1:nokey^=1 "%mylocation%\%myfilename%"') DO (SET myheight=%%G)

FOR /F %%H IN ('ffprobe.exe -v error -show_entries format^=duration -of default^=noprint_wrappers^=1:nokey^=1 "%mylocation%\%myfilename%"') DO (SET myduration=%%H)

PAUSE

IF %myduration% GTR 3 (GOTO :trimThenCreateWebm) ELSE (GOTO :createWebm)

:trimThenCreateWebm
ECHO Your video is over 3 seconds, please trim your video by inputting your Start Time and End Time
ECHO Video duration (in second): %myduration%

SET /p myStartTime="Enter your Start Time(eg. 0, 1.20, 3.40): "

IF %myStartTime% GTR %myduration% (
ECHO Start Time error
PAUSE
EXIT /b 0
)

SET /p myEndTime="Enter your End Time(eg. 3.00, 3.5, 4.00): "

IF %myEndTime% GTR %myduration% (
ECHO End Time error
PAUSE
EXIT /b 0
)

IF %myStartTime% GTR %myEndTime% (
ECHO Start Time and End Time error
PAUSE
EXIT /b 0
)


IF %mywidth% GTR %myheight% (ffmpeg.exe -i "%mylocation%\%myfilename%" -ss %myStartTime% -to %myEndTime%  -r %fps% -vf "scale=-1:512, crop=512:512" -c:v libvpx-vp9 -b:v %quality% "%myOutputLocation%\%mywebmname%") ELSE (ffmpeg.exe -i "%mylocation%\%myfilename%" -ss %myStartTime% -to %myEndTime% -r %fps% -vf "scale=512:-1, crop=512:512" -c:v libvpx-vp9 -b:v %quality% "%myOutputLocation%\%mywebmname%")
PAUSE
EXIT /b 0


:createWebm
IF %mywidth% GTR %myheight% (ffmpeg.exe -i "%mylocation%\%myfilename%" -r %fps% -vf "scale=-1:512, crop=512:512" -c:v libvpx-vp9 -b:v %quality% "%myOutputLocation%\%mywebmname%") ELSE (ffmpeg.exe -i "%mylocation%\%myfilename%" -r %fps% -vf "scale=512:-1, crop=512:512" -c:v libvpx-vp9 -b:v %quality% "%myOutputLocation%\%mywebmname%")
PAUSE
EXIT /b 0