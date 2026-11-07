@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM Activate directly in this CMD session (no child PowerShell process).
for %%I in (.) do set "PROJECT_NAME=%%~nxI"
set "VENV_ROOT=C:\venvs\%PROJECT_NAME%"

if not exist "%VENV_ROOT%\" (
    echo No virtual environment folder found for "%PROJECT_NAME%".
    echo Expected: "%VENV_ROOT%"
    endlocal & exit /b 1
)

set "COUNT=0"
set "SELECTED="

for /d %%D in ("%VENV_ROOT%\*") do (
    if exist "%%~fD\Scripts\activate.bat" (
        set /a COUNT+=1
        set "VENV_!COUNT!=%%~fD"
        set "LAST_VENV=%%~fD"
    )
)

if "%COUNT%"=="0" (
    echo No valid virtual environments found in:
    echo "%VENV_ROOT%"
    endlocal & exit /b 1
)

if "%COUNT%"=="1" (
    set "SELECTED=%LAST_VENV%"
) else (
    echo.
    echo Available environments for %PROJECT_NAME%:
    echo.
    for /l %%N in (1,1,%COUNT%) do (
        for %%V in ("!VENV_%%N!") do echo   %%N. %%~nxV
    )
    echo.
    set "CHOICE="
    set /p "CHOICE=Choose environment [1-%COUNT%]: "

    echo(!CHOICE!| findstr /r "^[1-9][0-9]*$" >nul
    if errorlevel 1 (
        echo Invalid choice.
        endlocal & exit /b 1
    )
    if !CHOICE! LSS 1 (
        echo Invalid choice.
        endlocal & exit /b 1
    )
    if !CHOICE! GTR %COUNT% (
        echo Invalid choice.
        endlocal & exit /b 1
    )
    for %%N in (!CHOICE!) do set "SELECTED=!VENV_%%N!"
)

echo.
echo Activating: %SELECTED%

REM Preserve selected path while removing this script's local variables.
for %%P in ("%SELECTED%") do (
    endlocal
    call "%%~P\Scripts\activate.bat"
)
