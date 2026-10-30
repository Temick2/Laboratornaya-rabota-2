@echo off
chcp 866 >nul
setlocal EnableExtensions
cd /d "%~dp0"
:menu
cls
echo ================================================
echo ЛАБОРАТОРНАЯ РАБОТА 2 - ВАРИАНТ 8
echo Выбор антивируса для организации (50 ПК)
echo ================================================
echo 1. Выбор антивируса
echo 2. Инспекция кода
echo 3. Сравнение альтернатив
echo 4. Запустить все модули и создать отчет
echo 5. Выход
choice /c 12345 /n /m "Выберите пункт: "
if errorlevel 5 exit /b
if errorlevel 4 goto all
if errorlevel 3 goto three
if errorlevel 2 goto two
call "%~dp0chapter1.bat"
goto menu
:two
call "%~dp0chapter2.bat"
goto menu
:three
call "%~dp0chapter3.bat"
goto menu
:all
set "LAB_RECOMMENDATION="
set "LAB_REVIEWER="
set "LAB_WINNER="
call "%~dp0chapter1.bat"
call "%~dp0chapter2.bat"
call "%~dp0chapter3.bat"
echo.
echo === Итоговый отчет системы ===
echo Рекомендация: %LAB_RECOMMENDATION%
echo Уровень ревьюера: %LAB_REVIEWER%
echo Победитель WSM: %LAB_WINNER%
>"%~dp0report.txt" echo Лабораторная работа 2, вариант 8
>>"%~dp0report.txt" echo Рекомендация: %LAB_RECOMMENDATION%
>>"%~dp0report.txt" echo Уровень ревьюера: %LAB_REVIEWER%
>>"%~dp0report.txt" echo Точность: %LAB_ACCURACY%%%
>>"%~dp0report.txt" echo Победитель WSM: %LAB_WINNER%
echo Отчет сохранен: report.txt
pause
goto menu
