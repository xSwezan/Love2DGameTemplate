@echo off
setlocal

set LOVE_PATH=C:\Program Files\LOVE
set OUTPUT_PATH=../build
set GAME_FOLDER=./src

REM Set game name to parent folder name
for %%a in ("%~dp0\.") do set "parent=%%~nxa"
set GAME_NAME=%parent%

cd /d "%GAME_FOLDER%"

echo Creating .love file...
7z a -tzip "%OUTPUT_PATH%\%GAME_NAME%.love" *

echo Combining .love with love.exe...
copy /b "%LOVE_PATH%\love.exe" + "%OUTPUT_PATH%\%GAME_NAME%.love" "%OUTPUT_PATH%\%GAME_NAME%.exe"

echo Copying DLLs...
copy "%LOVE_PATH%\*.dll" "%OUTPUT_PATH%"

echo Deleting .love file
del "%OUTPUT_PATH%\%GAME_NAME%.love"

cd /d "%OUTPUT_PATH%"
7z a -tzip "%GAME_NAME%.zip" *

echo Done!
pause
endlocal
