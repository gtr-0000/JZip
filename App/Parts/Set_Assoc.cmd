::���Ŀǰ״̬
reg query "HKCR\JFsoft.Jzip" >nul 2>nul && set "tips.FileAssoc=��" || set "tips.FileAssoc=��"

::������
if "%1"=="-on" call :on
if "%1"=="-off" call :off
if /i "%1"=="-reon" (
	if "%�ļ�����%"=="y" call :on
)
if "%1"=="-switch" (
	if "%tips.FileAssoc%"=="��" call :off reg
	if "%tips.FileAssoc%"=="��" call :on reg
)
goto :EOF


:on
1>"%dir.jzip.temp%\Assoc.cmd" (
	echo.for %%^%%a in ^(%jzip.spt.open%^) do 1^>nul assoc .%%^%%a=JFsoft.Jzip
	echo.1^>nul ftype JFsoft.Jzip="%path.jzip.launcher%" "%%%%1"
)
if "%1"=="reg" 1>>"%dir.jzip.temp%\Assoc.cmd" (
	echo.reg add "HKCU\Software\JFsoft.Jzip" /v "�ļ�����" /d "y" /f ^>nul
)
goto :Assoc


:off
1>"%dir.jzip.temp%\Assoc.cmd" (
	echo.for %%^%%a in ^(%jzip.spt.open%^) do 1^>nul assoc .%%^%%a=
	echo.1^>nul ftype JFsoft.Jzip=
	echo.reg delete "HKCR\JFsoft.Jzip" /f ^>nul
)
if "%1"=="reg" 1>>"%dir.jzip.temp%\Assoc.cmd" (
	echo.reg add "HKCU\Software\JFsoft.Jzip" /v "�ļ�����" /d "" /f ^>nul
)
goto :Assoc


:Assoc
net session >nul 2>nul && call "%dir.jzip.temp%\Assoc.cmd"
net session >nul 2>nul || (
	mshta vbscript:CreateObject^("Shell.Application"^).ShellExecute^("cmd.exe","/q /c call ""%dir.jzip.temp%\Assoc.cmd""","","runas",1^)^(window.close^)
	cls & ping localhost -n 2 >nul
)
del /q /f /s "%dir.jzip.temp%\Assoc.cmd" >nul
goto :EOF

