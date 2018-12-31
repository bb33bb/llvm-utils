@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

SET "EXIT_ON_ERROR=%~1"
SET SUCCESS=0

PUSHD %~dp0

SET VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe
@rem Visual Studio 2017 and 2019
FOR /f "delims=" %%A IN ('"%VSWHERE%" -property installationPath -prerelease -version ^[15.0^,17.0^)') DO (
	IF EXIST "%%A\Common7\IDE\VC\VCTargets\Platforms" CALL :SUB_VS2017 "%%A\Common7\IDE\VC\VCTargets\Platforms"
)

IF %SUCCESS% == 0 (
	ECHO Visual C++ 2017 or 2019 NOT Installed.
	IF "%EXIT_ON_ERROR%" == "" PAUSE
)

POPD
ENDLOCAL
EXIT /B


:SUB_VS2017
ECHO VCTargetsPath: %~1
XCOPY /Q /Y "LLVM" "%~1\..\LLVM\"
XCOPY /Q /Y "LLVM_v141" "%~1\x64\PlatformToolsets\LLVM_v141\"
XCOPY /Q /Y "LLVM_v141_xp" "%~1\x64\PlatformToolsets\LLVM_v141_xp\"
XCOPY /Q /Y "LLVM_v141" "%~1\Win32\PlatformToolsets\LLVM_v141\"
XCOPY /Q /Y "LLVM_v141_xp" "%~1\Win32\PlatformToolsets\LLVM_v141_xp\"
XCOPY /Q /Y "LLVM_v141" "%~1\ARM64\PlatformToolsets\LLVM_v141\"
SET SUCCESS=1
EXIT /B
