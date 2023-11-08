@echo off
setlocal enabledelayedexpansion

REM Set the log file path and initialize the log
set "log_file=log.txt"
echo Generating random passwords > "%log_file%"

REM Initialize variables
set "password_length=12"
set "characters=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+"

REM Prompt the user for the number of passwords to generate
set /p "num_passwords=Enter the number of passwords to generate: "

REM Prompt the user for password length
set /p "password_length=Enter the password length (default is 12): "

REM Prompt the user to choose character sets
set /p "use_lowercase=Include lowercase letters (Y/N)? "
if /i "!use_lowercase!"=="Y" set "characters=!characters!abcdefghijklmnopqrstuvwxyz"
set /p "use_uppercase=Include uppercase letters (Y/N)? "
if /i "!use_uppercase!"=="Y" set "characters=!characters!ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set /p "use_digits=Include digits (Y/N)? "
if /i "!use_digits!"=="Y" set "characters=!characters!0123456789"
set /p "use_special=Include special characters (Y/N)? "
if /i "!use_special!"=="Y" set "characters=!characters!@#$%^&*()_+"

REM Set the logging level (verbose, minimal, errors only)
set /p "log_level=Select logging level (verbose/minimal/errors): "

REM Initialize the password variable
set "password="

REM Function to evaluate password strength
:EvaluatePasswordStrength
set "complexity=Weak"
if %password_length% geq 8 (
    set "complexity=Medium"
    if %password_length% geq 12 (
        set "complexity=Strong"
    )
)

REM Generate the random passwords and log
for /l %%j in (1,1,%num_passwords%) do (
    set "password="
    for /l %%i in (1,1,%password_length%) do (
        set /a "random_index=!random! %% 81"
        for %%a in (!random_index!) do set "char=!characters:~%%a,1!"
        set "password=!password!!char!"
    )

    echo Password %%j: !password!
    if /i "!log_level!"=="verbose" echo Password %%j: !password! >> "%log_file%"
    if /i "!log_level!"=="minimal" echo Password %%j generated >> "%log_file%"
)

REM Close the log file
echo Script finished >> "%log_file%"

REM Display the complexity of the generated passwords
echo Password Complexity: %complexity%
echo Password Complexity: %complexity% >> "%log_file%"

REM Pause to keep the window open
pause

endlocal
