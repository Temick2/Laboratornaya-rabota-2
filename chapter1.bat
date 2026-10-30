@echo off
chcp 866 >nul
setlocal EnableExtensions
set "score_k=0"
set "score_e=0"
set "score_d=0"
cls
echo === Выбор антивируса для офиса на 50 ПК ===
echo.
echo 1. Насколько важно централизованное управление?
echo 1 - Критически важно  2 - Желательно  3 - Не важно
choice /c 123 /n /m "Ответ: "
if errorlevel 3 goto q1c
if errorlevel 2 goto q1b
set /a score_k+=15,score_e+=10,score_d+=10
goto q2
:q1b
set /a score_k+=8,score_e+=10,score_d+=8
goto q2
:q1c
set /a score_k+=3,score_e+=5,score_d+=5
:q2
echo.
echo 2. Какой бюджет на лицензии?
echo 1 - Минимальный  2 - Средний  3 - Гибкий
choice /c 123 /n /m "Ответ: "
if errorlevel 3 goto q2c
if errorlevel 2 goto q2b
set /a score_d+=12,score_e+=10,score_k+=5
goto q3
:q2b
set /a score_e+=12,score_k+=10,score_d+=10
goto q3
:q2c
set /a score_k+=12,score_e+=10,score_d+=8
:q3
echo.
echo 3. Насколько важна подробная отчетность?
echo 1 - Очень  2 - Средне  3 - Минимально
choice /c 123 /n /m "Ответ: "
if errorlevel 3 goto q3c
if errorlevel 2 goto q3b
set /a score_k+=15,score_e+=12,score_d+=10
goto q4
:q3b
set /a score_e+=10,score_k+=8,score_d+=8
goto q4
:q3c
set /a score_d+=8,score_e+=6,score_k+=5
:q4
echo.
echo 4. Какова квалификация ИТ-администраторов?
echo 1 - Начальная  2 - Средняя  3 - Высокая
choice /c 123 /n /m "Ответ: "
if errorlevel 3 goto q4c
if errorlevel 2 goto q4b
set /a score_e+=12,score_d+=10,score_k+=7
goto result
:q4b
set /a score_k+=10,score_e+=10,score_d+=10
goto result
:q4c
set /a score_k+=13,score_d+=11,score_e+=10
:result
set "recommendation=Kaspersky Endpoint Security"
set /a best=score_k
if %score_e% gtr %best% set "recommendation=ESET NOD32" & set /a best=score_e
if %score_d% gtr %best% set "recommendation=Dr.Web" & set /a best=score_d
echo.
echo Баллы: Kaspersky=%score_k%, ESET=%score_e%, Dr.Web=%score_d%
echo Рекомендация: %recommendation%
echo Примечание: баллы учебные, а не результаты независимого тестирования.
endlocal & set "LAB_RECOMMENDATION=%recommendation%"
pause
