@echo off
chcp 866 >nul
setlocal EnableExtensions EnableDelayedExpansion
cls
echo === Взвешенное сравнение антивирусов ===
echo Критерии: защита, управление, стоимость.
:weights
call :weight w1 "Вес защиты (0-100): "
call :weight w2 "Вес управления (0-100): "
call :weight w3 "Вес стоимости (0-100): "
set /a sum=w1+w2+w3
if not !sum! equ 100 (
 echo Сумма весов !sum!, а нужна 100. Повторите ввод.
 goto weights
)
for %%A in (K E D) do (
 if "%%A"=="K" echo --- Kaspersky Endpoint Security ---
 if "%%A"=="E" echo --- ESET NOD32 ---
 if "%%A"=="D" echo --- Dr.Web ---
 call :rating %%A1 "Защита (1-5): "
 call :rating %%A2 "Управление (1-5): "
 call :rating %%A3 "Стоимость (1-5): "
)
set /a sk=K1*w1+K2*w2+K3*w3
set /a se=E1*w1+E2*w2+E3*w3
set /a sd=D1*w1+D2*w2+D3*w3
echo.
echo === Матрица решений ===
echo Критерий       Вес  Kaspersky  ESET  Dr.Web
echo Защита         !w1!     !K1!          !E1!     !D1!
echo Управление     !w2!     !K2!          !E2!     !D2!
echo Стоимость      !w3!     !K3!          !E3!     !D3!
echo ИТОГО                 !sk!         !se!    !sd!
set "winner=Kaspersky Endpoint Security"
set /a best=sk
if !se! gtr !best! (set "winner=ESET NOD32" & set /a best=se)
if !sd! gtr !best! (set "winner=Dr.Web" & set /a best=sd)
echo Победитель: !winner!
echo При равенстве баллов приоритет: Kaspersky, затем ESET, затем Dr.Web.
endlocal & set "LAB_WINNER=%winner%"
pause
exit /b
:weight
set "input="
set /p "input=%~2"
echo(!input!| findstr /r "^[0-9][0-9]*$" >nul || (echo Введите целое число от 0 до 100. & goto weight)
if "!input:~3,1!" neq "" (echo Слишком большое число. & goto weight)
set /a num=input
if !num! gtr 100 (echo Максимум 100. & goto weight)
set "%~1=!num!"
exit /b
:rating
set "input="
set /p "input=%~2"
echo(!input!| findstr /r "^[1-5]$" >nul || (echo Введите число от 1 до 5. & goto rating)
set "%~1=!input!"
exit /b
