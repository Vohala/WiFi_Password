@echo off
REM ------------------------------------------------------------------------------
REM  ShowAllWiFiPasswords.bat
REM  Lists all saved Wi-Fi SSIDs and their passwords (if any), saving them into
REM  a text file named "wifi_passwords.txt" in the current directory.
REM  Use responsibly on systems that you own or have permission to inspect.
REM ------------------------------------------------------------------------------

setlocal EnableDelayedExpansion

echo Wi-Fi Profiles & Passwords > wifi_passwords.txt
echo -------------------------------------------------------------------------------- >> wifi_passwords.txt
echo  Developed by Vohala "Password finder" This tool is for education purpose only. >> wifi_passwords.txt
echo -------------------------------------------------------------------------------- >> wifi_passwords.txt

for /f "tokens=2 delims=:" %%A in ('netsh wlan show profiles ^| findstr /i "All User Profile"') do (
    set "ssid=%%A"
    call :trimSSID ssid

    echo SSID: !ssid! >> wifi_passwords.txt

    netsh wlan show profile name="!ssid!" key=clear | findstr /i "Key Content" >> wifi_passwords.txt
    echo. >> wifi_passwords.txt
)

echo Done! The saved SSIDs and passwords are in "wifi_passwords.txt".
pause
exit /b


REM ------------------------------------------------------------------------------
REM  :trimSSID
REM  Removes leading spaces from the SSID variable passed in.
REM ------------------------------------------------------------------------------
:trimSSID
    setlocal EnableDelayedExpansion
    set "ssid=!%1!"
    :loop
    if "!ssid:~0,1!"==" " (
        set "ssid=!ssid:~1!"
        goto :loop
    )
    endlocal & set "%1=%ssid%"
    exit /b