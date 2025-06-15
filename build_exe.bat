@echo off
:: Заголовок окна
TITLE Сборка EXE файла - video_compressor

:: Включаем отображение команд
SETLOCAL ENABLEDELAYEDEXPANSION

:: Устанавливаем цвет текста
color 0a

:: Переходим в текущую директорию (где лежит .bat)
cd /d "%~dp0%"

echo 🛠️ Начинаем сборку...
echo.

:: Проверяем наличие файла Python скрипта
if not exist "compress_first_mp4.py" (
    echo ❌ Ошибка: compress_first_mp4.py не найден в этой папке.
    echo Проверьте, что файл существует и называется правильно.
    echo.
    pause
    exit /b
)

:: Проверяем установлен ли pyinstaller
where pyinstaller >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Ошибка: PyInstaller не установлен или не находится в PATH.
    echo Установите его через:
    echo     pip install pyinstaller
    echo.
    pause
    exit /b
)

echo 🧱 Запускаю PyInstaller для создания EXE...
echo.

:: Выполняем сборку
pyinstaller --onefile --noconsole compress_first_mp4.py

:: Проверяем результат
if exist "dist\compress_first_mp4.exe" (
    echo ✅ Сборка успешна!
    echo Готовый файл: dist\compress_first_mp4.exe
    echo.
) else (
    echo ❌ Что-то пошло не так. EXE файл не создан.
    echo Возможно, ошибка в самом скрипте или в пути.
    echo.
)
echo 📦 Копирую FFmpeg и FFprobe в dist/...
copy /Y "ffmpeg.exe" "dist\" >nul
copy /Y "ffprobe.exe" "dist\" >nul

echo 🚀 Запускаю готовый EXE...
start "" "dist\compress_first_mp4.exe"

pause
