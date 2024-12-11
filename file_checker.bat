@echo off
echo ======================================================
echo Checking ESP32 Environment Setup
echo ======================================================

:: Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed or not in PATH.
    goto end
) else (
    echo Python is installed.
)

:: Check if ESP32 Board Package is installed
echo.
echo Checking ESP32 Board Package in Arduino IDE...
if exist "%LOCALAPPDATA%\Arduino15\packages\esp32" (
    echo ESP32 Board Package is installed.
) else (
    echo ESP32 Board Package is NOT installed.
    goto end
)

:: Check if OpenOCD is installed
echo.
echo Checking OpenOCD installation...
if exist "%LOCALAPPDATA%\Arduino15\packages\esp32\tools\openocd-esp32" (
    echo OpenOCD is installed.
) else (
    echo OpenOCD is NOT installed.
    goto end
)

:: Check if FTDI driver is installed
echo.
echo Checking FTDI driver...
pnputil /enum-drivers | findstr /i "FTDI" >nul 2>&1
if %errorlevel% neq 0 (
    echo FTDI driver is not installed.
    goto end
) else (
    echo FTDI driver is installed.
)

:: Check if Ports are Available
echo.
echo Checking port availability...
netstat -ano | findstr :50000 >nul 2>&1
if %errorlevel% neq 0 (
    echo Port 50000 is available.
) else (
    echo Port 50000 is in use.
)

netstat -ano | findstr :50002 >nul 2>&1
if %errorlevel% neq 0 (
    echo Port 50002 is available.
) else (
    echo Port 50002 is in use.
)

:: Success message
echo.
echo ======================================================
echo All checks passed! ESP32 environment is set up correctly.
echo ======================================================
goto end

:end
pause
