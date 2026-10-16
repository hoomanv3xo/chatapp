@echo off
cd /d "%~dp0"

if not exist venv\Scripts\activate.bat (
    echo Virtual environment not found. Create it first with: python -m venv venv
    pause
    exit /b 1
)

call venv\Scripts\activate.bat

echo Applying migrations...
python manage.py migrate

echo Starting server at http://127.0.0.1:8000/
start "" http://127.0.0.1:8000/
python manage.py runserver

pause