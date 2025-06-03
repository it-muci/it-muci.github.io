@::fh36d7f-random
@set masver=3.3
@setlocal DisableDelayedExpansion
@echo off

::  ���������п��أ���鿴 mass<>grave<.>dev/command_line_switches
::  ���������õ����ű������Ķ� MAS �����ļ��汾��

::============================================================================
::
::   ��ҳ: mass<>grave<.>dev
::   ����: mas.help@outlook.com
::
::============================================================================

::========================================================================================================================================

::  ���û�����������ϵͳ�����ô��������������
setlocal EnableExtensions
setlocal DisableDelayedExpansion

set "PathExt=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC"

set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
    set "SysPath=%SystemRoot%\Sysnative"
    set "Path=%SystemRoot%\Sysnative;%SystemRoot%;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)

set "ComSpec=%SysPath%\cmd.exe"
set "PSModulePath=%ProgramFiles%\WindowsPowerShell\Modules;%SysPath%\WindowsPowerShell\v1.0\Modules"

set re1=
set re2=
set "_cmdf=%~f0"
for %%# in (%*) do (
    if /i "%%#"=="re1" set re1=1
    if /i "%%#"=="re2" set re2=1
)

:: ����ű����� 64 λ Windows ���� 32 λ���������ģ���ʹ�� 64 λ�������������ű�
:: ��������ű����� ARM64 Windows ���� x86/ARM32 ���������ģ���ʹ�� ARM64 �������������ű�
if exist %SystemRoot%\Sysnative\cmd.exe if not defined re1 (
    setlocal EnableDelayedExpansion
    start %SystemRoot%\Sysnative\cmd.exe /c ""!_cmdf!" %* re1"
    exit /b
)

:: ����ű����� ARM64 Windows ���� 64 λ���������ģ���ʹ�� ARM32 �������������ű�
if exist %SystemRoot%\SysArm32\cmd.exe if %PROCESSOR_ARCHITECTURE%==AMD64 if not defined re2 (
    setlocal EnableDelayedExpansion
    start %SystemRoot%\SysArm32\cmd.exe /c ""!_cmdf!" %* re2"
    exit /b
)

::========================================================================================================================================

set "blank="
set "mas=ht%blank%tps%blank%://mass%blank%grave.dev/"
set "github=ht%blank%tps%blank%://github.com/massgra%blank%vel/Micro%blank%soft-Acti%blank%vation-Scripts"
set "selfgit=ht%blank%tps%blank%://git.acti%blank%vated.win/massg%blank%rave/Micr%blank%osoft-Act%blank%ivation-Scripts"

::  ��� Null �����Ƿ��������У����������ű�����Ҫ
sc query Null | find /i "RUNNING"
if %errorlevel% NEQ 0 (
    echo:
    echo Null ����δ���У��ű����ܻ����...
    echo:
    echo:
    echo �鿴����ҳ��ȡ���� - %mas%fix_service
    echo:
    echo:
    ping 127.0.0.1 -n 20
)
cls

::  ��� LF ��β
pushd "%~dp0"
>nul findstr /v "$" "%~nx0" && (
    echo:
    echo ���� - �ű����ܴ��� LF ��β���⣬���߽ű�ĩβȱ�ٿ��С�
    echo:
    echo:
    echo �鿴����ҳ��ȡ���� - %mas%troubleshoot
    echo:
    echo:
    ping 127.0.0.1 -n 20 >nul
    popd
    exit /b
)
popd

::========================================================================================================================================

cls
color 07
title  Microsoft_Activation_Scripts %masver%

set _args=
set _elev=
set _unattended=0

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args set _args=%_args:re1=%
if defined _args set _args=%_args:re2=%
if defined _args (
    for %%A in (%_args%) do (
        if /i "%%A"=="-el" set _elev=1
    )
)

if defined _args echo "%_args%" | find /i "/" >nul && set _unattended=1

::========================================================================================================================================

set "nul1=1>nul"
set "nul2=2>nul"
set "nul6=2^>nul"
set "nul=>nul 2>&1"

call :dk_setvar

if %winbuild% EQU 1 (
    %eline%
    echo �޷���⵽ Windows �汾�š�
    echo:
    setlocal EnableDelayedExpansion
    set fixes=%fixes% %mas%troubleshoot
    call :dk_color2 %Blue% "�鿴����ҳ��ȡ���� - " %_Yellow% " %mas%troubleshoot"
    goto dk_done
)

if %winbuild% LSS 6001 (
    %nceline%
    echo ��⵽��֧�ֵĲ���ϵͳ�汾 [%winbuild%]��
    echo MAS ��֧�� Windows Vista/7/8/8.1/10/11 ����������汾��
    if %winbuild% EQU 6000 (
        echo:
        echo ��֧�� Windows Vista RTM����Ϊ�޷���װ Powershell��
        echo ������ Windows Vista SP1 �� SP2��
    )
    goto dk_done
)

if %winbuild% LSS 7600 if not exist "%SysPath%\WindowsPowerShell\v1.0\Modules" (
    %nceline%
    if not exist %ps% (
        echo ϵͳ��δ��װ PowerShell��
    )
    echo ʹ������ URL ��װ PowerShell 2.0��
    echo:
    echo https://www.catalog.update.microsoft.com/Search.aspx?q=KB968930
    if %_unattended%==0 start https://www.catalog.update.microsoft.com/Search.aspx?q=KB968930
    goto dk_done
)

::========================================================================================================================================

::  �޸�·�����е������ַ�����
set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%
set _PSarg=%_PSarg:'=''%

set "_ttemp=%userprofile%\AppData\Local\Temp"

setlocal EnableDelayedExpansion

::========================================================================================================================================

echo "!_batf!" | find /i "!_ttemp!" %nul1% && (
    if /i not "!_work!"=="!_ttemp!" (
        %eline%
        echo �ű�����ʱ�ļ���������
        echo ��ܿ�����ֱ�ӴӴ浵�ļ������нű���
        echo:
        echo ��ѹ�浵�ļ������ӽ�ѹ����ļ����������ű���
        goto dk_done
    )
)

::========================================================================================================================================

::  �Թ���Ա��������ű�Ȩ�ޣ����ݲ�������ֹѭ��
%nul1% fltmc || (
    if not defined _elev %psc% "start cmd.exe -arg '/c \"!_PSarg!\"' -verb runas" && exit /b
    %eline%
    echo �˽ű���Ҫ����ԱȨ�ޡ�
    echo �Ҽ������˽ű���Ȼ��ѡ���Թ���Ա������С���
    goto dk_done
)

::========================================================================================================================================

::  ��� PowerShell
::pstst $ExecutionContext.SessionState.LanguageMode :pstst

for /f "delims=" %%a in ('%psc% "if ($PSVersionTable.PSEdition -ne 'Core') {$f=[io.file]::ReadAllText('!_batp!') -split ':pstst';iex ($f[1])}" %nul6%') do (set tstresult=%%a)

if /i not "%tstresult%"=="FullLanguage" (
    %eline%
    for /f "delims=" %%a in ('%psc% "$ExecutionContext.SessionState.LanguageMode" %nul6%') do (set tstresult2=%%a)
    echo ���� 1 - %tstresult%
    echo ���� 2 - !tstresult2!
    echo:

    REM ��� LanguageMode
    echo: !tstresult2! | findstr /i "ConstrainedLanguage RestrictedLanguage NoLanguage" %nul1% && (
        echo PowerShell ��δ�ҵ� FullLanguage ģʽ��������ֹ...
        echo ������ Powershell Ӧ�������ƣ��볷����Щ���ġ�
        echo:
        set fixes=%fixes% %mas%fix_powershell
        call :dk_color2 %Blue% "�鿴����ҳ��ȡ���� - " %_Yellow% " %mas%fix_powershell"
        goto dk_done
    )

    REM ��� Powershell ���İ汾
    cmd /c "%psc% "$PSVersionTable.PSEdition"" | find /i "Core" %nul1% && (
        echo MAS ��Ҫ Windows Powershell�������ƺ��ѱ� Powershell ���İ��滻��������ֹ...
        goto dk_done
    )

    REM �����ܵ��� Powershell ��������Ķ������
    for /r "%ProgramFiles%\" %%f in (secureboot.exe) do if exist "%%f" (
        echo "%%f"
        echo ���ֶ��������PowerShell �޷�����������
        echo:
        set fixes=%fixes% %mas%remove_mal%w%ware
        call :dk_color2 %Blue% "�鿴����ҳ��ȡ���� - " %_Yellow% " %mas%remove_mal%w%ware"
        goto dk_done
    )

    REM ���ɱ���������������
    echo PowerShell �޷�����������������ֹ...

    if /i "!tstresult2!"=="FullLanguage" (
        echo:
        echo ���ɱ���������������ֹ�ű���������ϵͳ�ϵ� PowerShell �������𻵡�
        cmd /c "%psc% ""$av = Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct; $n = @(); foreach ($i in $av) { $n += $i.displayName }; if ($n) { Write-Host ('Installed Antivirus - ' + ($n -join ', '))}"""
    )

    echo:
    set fixes=%fixes% %mas%troubleshoot
    call :dk_color2 %Blue% "�鿴����ҳ��ȡ���� - " %_Yellow% " %mas%troubleshoot"
    goto dk_done
)

::========================================================================================================================================

::  ���ÿ��ٱ༭������ conhost.exe �����Ա���ʹ���ն�Ӧ�ó���
if %winbuild% GEQ 17763 (
    set terminal=1
) else (
    set terminal=
)

::  ���ű��Ƿ����ն�Ӧ�ó���������
if defined terminal (
    set lines=0
    for /f "skip=2 tokens=2 delims=: " %%A in ('mode con') do if "!lines!"=="0" set lines=%%A
    if !lines! GEQ 100 set terminal=
)

if %_unattended%==1 goto :skipQE
for %%# in (%_args%) do (if /i "%%#"=="-qedit" goto :skipQE)

::  ���������Խ��õ�ǰ�Ự�еĿ��ٱ༭����ʹ�� conhost.exe �������ն�Ӧ�ó���
::  �˴����ڲ���������ע�����ĵ�����£�Ϊ��ǰ cmd.exe �Ự���ÿ��ٱ༭
::  �����˴�������Ϊ�����ű����ڿ��ܻ���ִͣ�У��Ӷ��������ű�������ֹͣ
set resetQE=1
reg query HKCU\Console /v QuickEdit %nul2% | find /i "0x0" %nul1% && set resetQE=0
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 0 /f %nul1%

if defined terminal (
    start conhost.exe "!_batf!" %_args% -qedit
    start reg add HKCU\Console /v QuickEdit /t REG_DWORD /d %resetQE% /f %nul1%
    exit /b
) else if %resetQE% EQU 1 (
    start cmd.exe /c ""!_batf!" %_args% -qedit"
    start reg add HKCU\Console /v QuickEdit /t REG_DWORD /d %resetQE% /f %nul1%
    exit /b
)

:skipQE

::========================================================================================================================================

::  ������
set -=
set old=
set pingp=
set upver=%masver:.=%

for %%A in (
    activ%-%ated.win
    mass%-%grave.dev
) do if not defined pingp (
    for /f "delims=[] tokens=2" %%B in ('ping -n 1 %%A') do (
        if not "%%B"=="" (set old=1& set pingp=1)
        for /f "delims=[] tokens=2" %%C in ('ping -n 1 updatecheck%upver%.%%A') do (
            if not "%%C"=="" set old=
        )
    )
)

if defined old (
    echo ________________________________________________
    %eline%
    echo ��ʹ�õ� MAS �汾 [%masver%] �ѹ�ʱ��
    echo ________________________________________________
    echo:
    if not %_unattended%==1 (
        echo [1] ��ȡ���°� MAS
        echo [0] ����ʹ��
        echo:
        call :dk_color %_Green% "ʹ�ü���ѡ��һ���˵�ѡ�� [1,0] :"
        choice /C:10 /N
        if !errorlevel!==2 rem
        if !errorlevel!==1 (start %selfgit% & start %github% & start %mas% & exit /b)
    )
)

::========================================================================================================================================

if not exist "%SystemRoot%\Temp\" mkdir "%SystemRoot%\Temp" %nul%

::  ������ֵ��ģʽ���д��в����Ľű�
set _elev=
if defined _args echo "%_args%" | find /i "/S" %nul% && (set "_silent=%nul%") || (set _silent=)
if defined _args echo "%_args%" | find /i "/" %nul% && (
    echo "%_args%" | find /i "/HWID"   %nul% && (setlocal & cls & (call :HWIDActivation    %_args% %_silent%) & endlocal)
    echo "%_args%" | find /i "/KMS38"  %nul% && (setlocal & cls & (call :KMS38Activation   %_args% %_silent%) & endlocal)
    echo "%_args%" | find /i "/Z-"     %nul% && (setlocal & cls & (call :TSforgeActivation %_args% %_silent%) & endlocal)
    echo "%_args%" | find /i "/K-"     %nul% && (setlocal & cls & (call :KMSActivation     %_args% %_silent%) & endlocal)
    echo "%_args%" | find /i "/Ohook"  %nul% && (setlocal & cls & (call :OhookActivation   %_args% %_silent%) & endlocal)
    exit /b
)

::========================================================================================================================================

setlocal DisableDelayedExpansion

::  �������λ��
set desktop=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set "desktop=%%b"
if not defined desktop for /f "delims=" %%a in ('%psc% "& {write-host $([Environment]::GetFolderPath('Desktop'))}"') do call set "desktop=%%a"
set "_pdesk=%desktop:'=''%"

setlocal EnableDelayedExpansion

if not defined desktop (
    %eline%
    echo �޷���⵽����λ�ã�������ֹ...
    goto dk_done
)

::========================================================================================================================================

:MainMenu

cls
color 07
title  Microsoft %blank%Activation %blank%Scripts %masver%
if not defined terminal mode 76, 34

if %winbuild% GEQ 10240 if not exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" if not exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" set _hwidgo=1
if %winbuild% GTR 14393 if exist "%SysPath%\spp\tokens\skus\EnterpriseSN\" set _hwidgo=
if not defined _hwidgo set _tsforgego=1

set _ohookgo=1
if %winbuild% GEQ 9200 (
    if %winbuild% LSS 10240 set _ohookgo=
    if %winbuild% GEQ 19041 if %winbuild% LEQ 19045 set _ohookgo=
    if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" set _ohookgo=
    if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" set _ohookgo=
    if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-EnterpriseS*dition~*.mum" set _ohookgo=
)
if not defined _ohookgo set _tsforgego=1

echo:
echo:
echo:
echo:
echo:       ______________________________________________________________
echo:
echo:                 �����:
echo:
if defined _hwidgo (
    call :dk_color3 %_White% "             [1] " %_Green% "HWID" %_White% "                - Windows"
) else (
    echo:             [1] HWID                - Windows
)
if defined _ohookgo (
    call :dk_color3 %_White% "             [2] " %_Green% "Ohook" %_White% "               - Office"
) else (
    echo:             [2] Ohook               - Office
)
if defined _tsforgego (
    call :dk_color3 %_White% "             [3] " %_Green% "TSforge" %_White% "             - Windows / Office / ESU"
) else (
    echo:             [3] TSforge             - Windows / Office / ESU
)
echo:             [4] KMS38               - Windows
echo:             [5] Online KMS          - Windows / Office
echo:             __________________________________________________ 
echo:
echo:             [6] ��鼤��״̬
echo:             [7] ���� Windows �汾
echo:             [8] ���� Office �汾
echo:             __________________________________________________      
echo:
echo:             [9] �����ų�
echo:             [E] ���ӹ���
echo:             [H] ����
echo:             [0] �˳�
echo:       ______________________________________________________________
echo:
call :dk_color2 %_White% "         " %_Green% "ʹ�ü���ѡ��һ���˵�ѡ�� [1,2,3...E,H,0] :"
choice /C:123456789EH0 /N
set _erl=%errorlevel%

if %_erl%==12 exit /b
if %_erl%==11 (start %selfgit% & start %github% & start %mas%troubleshoot & goto :MainMenu)
if %_erl%==10 goto :Extras
if %_erl%==9 setlocal & call :troubleshoot      & cls & endlocal & goto :MainMenu
if %_erl%==8 setlocal & call :change_offedition & cls & endlocal & goto :MainMenu
if %_erl%==7 setlocal & call :change_winedition & cls & endlocal & goto :MainMenu
if %_erl%==6 setlocal & call :check_actstatus   & cls & endlocal & goto :MainMenu
if %_erl%==5 setlocal & call :KMSActivation     & cls & endlocal & goto :MainMenu
if %_erl%==4 setlocal & call :KMS38Activation   & cls & endlocal & goto :MainMenu
if %_erl%==3 setlocal & call :TSforgeActivation & cls & endlocal & goto :MainMenu
if %_erl%==2 setlocal & call :OhookActivation   & cls & endlocal & goto :MainMenu
if %_erl%==1 setlocal & call :HWIDActivation    & cls & endlocal & goto :MainMenu
goto :MainMenu

:dk_color3

if %_NCS% EQU 1 (
    echo %esc%[%~1%~2%esc%[%~3%~4%esc%[%~5%~6%esc%[0m
) else (
    %psc% write-host -back '%1' -fore '%2' '%3' -NoNewline; write-host -back '%4' -fore '%5' '%6'-NoNewline; write-host -back '%7' -fore '%8' '%9'
)
exit /b

::========================================================================================================================================

:Extras

cls
title  ���ӹ���
if not defined terminal mode 76, 30
echo:
echo:
echo:
echo:
echo:
echo:           ______________________________________________________
echo:           
echo:                [1] ��ȡ $OEM$ �ļ���
echo:                  
echo:                [2] �������� Windows / Office 
echo:                ____________________________________________      
echo:                                                                          
echo:                [0] �������˵�
echo:           ______________________________________________________
echo:
call :dk_color2 %_White% "             " %_Green% "ʹ�ü���ѡ��һ���˵�ѡ�� [1,2,0] :"
choice /C:120 /N
set _erl=%errorlevel%

if %_erl%==3 goto :MainMenu
if %_erl%==2 start %mas%genuine-installation-media & goto :Extras
if %_erl%==1 goto :Extract$OEM$
goto :Extras

::========================================================================================================================================

:Extract$OEM$

cls
title  ��ȡ $OEM$ �ļ���
if not defined terminal mode 76, 30

if exist "!desktop!\$OEM$\" (
    %eline%
    echo �������Ѵ��� $OEM$ �ļ��С�
    echo _____________________________________________________
    echo:
    call :dk_color %_Yellow% "�� [0] ���˳�..."
    choice /c 0 /n
    goto :Extras
)

:Extract$OEM$2

cls
title  ��ȡ $OEM$ �ļ���
if not defined terminal mode 78, 30
echo:
echo:
echo:
echo:
echo:                     ����������ȡ $OEM$ �ļ���           
echo:         ____________________________________________________________
echo:
echo:            [1] HWID             [Windows]
echo:            [2] Ohook            [Office]
echo:            [3] TSforge          [Windows / ESU / Office]
echo:            [4] KMS38            [Windows]
echo:            [5] Online KMS       [Windows / Office]
echo:
echo:            [6] HWID    [Windows] ^+ Ohook [Office]
echo:            [7] HWID    [Windows] ^+ Ohook [Office] ^+ TSforge [ESU]
echo:            [8] TSforge [Windows] ^+ Online KMS [Office]
echo:
call :dk_color2 %_White% "            [R] " %_Green% "ReadMe"
echo:            [0] ����
echo:         ____________________________________________________________
echo:  
call :dk_color2 %_White% "             " %_Green% "ʹ�ü���ѡ��һ���˵�ѡ�� :"
choice /C:12345678R0 /N
set _erl=%errorlevel%

if %_erl%==10 goto:Extras
if %_erl%==9 start %mas%oem-folder &goto:Extract$OEM$2
if %_erl%==8 (set "_oem=TSforge [Windows] + Online KMS [Office]" & set "para=/Z-Windows /K-Office" &goto:Extract$OEM$3)
if %_erl%==7 (set "_oem=HWID [Windows] + Ohook [Office] + TSforge [ESU]" & set "para=/HWID /Ohook /Z-ESU" &goto:Extract$OEM$3)
if %_erl%==6 (set "_oem=HWID [Windows] + Ohook [Office]" & set "para=/HWID /Ohook" &goto:Extract$OEM$3)
if %_erl%==5 (set "_oem=Online KMS" & set "para=/K-WindowsOffice" &goto:Extract$OEM$3)
if %_erl%==4 (set "_oem=KMS38" & set "para=/KMS38" &goto:Extract$OEM$3)
if %_erl%==3 (set "_oem=TSforge" & set "para=/Z-WindowsESUOffice" &goto:Extract$OEM$3)
if %_erl%==2 (set "_oem=Ohook" & set "para=/Ohook" &goto:Extract$OEM$3)
if %_erl%==1 (set "_oem=HWID" & set "para=/HWID" &goto:Extract$OEM$3)
goto :Extract$OEM$2

::========================================================================================================================================

:Extract$OEM$3

cls
set "_dir=!desktop!\$OEM$\$$\Setup\Scripts"
md "!_dir!\"

:: �ڶ��������������Դ���Ψһ�ļ��������ڱ���ɱ��������
%psc% "$f=[io.file]::ReadAllText('!_batp!'); [io.file]::WriteAllText('!_pdesk!\$OEM$\$$\Setup\Scripts\MAS_AIO.cmd', '@::RANDOM-' + [Guid]::NewGuid().Guid + [Environment]::NewLine + $f, [System.Text.Encoding]::ASCII)"

(
    echo @echo off
    echo fltmc ^>nul ^|^| exit /b
    echo call "%%~dp0MAS_AIO.cmd" %para%
    echo cd \
    echo ^(goto^) 2^>nul ^& ^(if "%%~dp0"=="%%SystemRoot%%\Setup\Scripts\" rd /s /q "%%~dp0"^)
)>"!_dir!\SetupComplete.cmd"

set _error=
if not exist "!_dir!\MAS_AIO.cmd" set _error=1
if not exist "!_dir!\SetupComplete.cmd" set _error=1

if defined _error (
    %eline%
    echo �ű�δ�ܴ��� $OEM$ �ļ��С�
    if exist "!desktop!\$OEM$\.*" rmdir /s /q "!desktop!\$OEM$\" %nul%
) else (
    echo:
    call :dk_color %Blue% "%_oem%"