@echo off
chcp 866 >nul
setlocal EnableExtensions
set /a correct=0,points=0,total=5
cls
echo === Инспекция скриптов управления антивирусом ===
echo За правильный ответ +2, за ошибку -1.
echo.
echo Фрагмент 1:
echo def deploy(agent):
echo     return install(agent, retries)
call :options
choice /c 12345 /n /m "Тип дефекта (1-5): "
if errorlevel 2 (set /a points-=1) else (set /a correct+=1,points+=2)
echo Правильный ответ: 1 (retries не определена).
echo.
echo Фрагмент 2:
echo def configure(policy):
echo     mode = "strict"
echo     mode = "normal"
echo     return mode
call :options
choice /c 12345 /n /m "Тип дефекта (1-5): "
if errorlevel 3 (set /a points-=1) else if errorlevel 2 (set /a correct+=1,points+=2) else (set /a points-=1)
echo Правильный ответ: 2 (первое присваивание теряется).
echo.
echo Фрагмент 3:
echo def read_antivirus_log(path):
echo     f = open(path)
echo     return f.read()
call :options
choice /c 12345 /n /m "Тип дефекта (1-5): "
if errorlevel 4 (set /a points-=1) else if errorlevel 3 (set /a correct+=1,points+=2) else (set /a points-=1)
echo Правильный ответ: 3 (файл явно не закрывается).
echo.
echo Фрагмент 4:
echo def scan_interval():
echo     return 86400
call :options
choice /c 12345 /n /m "Тип дефекта (1-5): "
if errorlevel 5 (set /a points-=1) else if errorlevel 4 (set /a correct+=1,points+=2) else (set /a points-=1)
echo Правильный ответ: 4 (магическое число).
echo.
echo Фрагмент 5:
echo def load_policy(path):
echo     return open(path).read()
call :options
choice /c 12345 /n /m "Тип дефекта (1-5): "
if errorlevel 5 (set /a correct+=1,points+=2) else (set /a points-=1)
echo Правильный ответ: 5 (нет обработки ошибок чтения).
set /a accuracy=correct*100/total
set "reviewer=Junior"
if %accuracy% geq 50 set "reviewer=Middle"
if %accuracy% geq 80 set "reviewer=Senior"
echo.
echo === Итог ===
echo Фрагментов: %total%
echo Правильных: %correct%
echo Точность: %accuracy%%%
echo Очки: %points%
echo Уровень: %reviewer%
endlocal & set "LAB_REVIEWER=%reviewer%" & set "LAB_ACCURACY=%accuracy%"
pause
exit /b
:options
echo 1 - Неинициализированная переменная
echo 2 - Мертвое присваивание
echo 3 - Утечка ресурса
echo 4 - Магическое число
echo 5 - Нет обработки ошибок
exit /b
