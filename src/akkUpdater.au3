#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=U:\Vogtländer\AutoIt\Icons\MyAutoIt3_Green.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Language=1031
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/tc 4 /reel /sf
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

    AutoIt Version: 3.3.14.2
    Author:         Searinox

    Script Function:
    Template AutoIt script.

#ce ----------------------------------------------------------------------------
;~ #include <AutoItConstants.au3>
;~ #include <MsgBoxConstants.au3>
#include <TrayConstants.au3>
#include <FileConstants.au3>
;~ #include <Array.au3>
;~ #include <File.au3>
#include <Misc.au3>
;~ #include <Date.au3>
;~ #include <Inet.au3>
#Region
Opt("MustDeclareVars", 1) ;0=no, 1=require pre-declaration
Opt("TrayAutoPause", 0) ;0=no pause, 1=Pause
#EndRegion
#Region
Global Const $T1 = 1000 * 15
Global Const $TrayTipTimeout = 15

Global Const $AkkFileName = "akk.exe"
Global Const $AkkDir = @ScriptDir & "\"
Global Const $AkkPath = $AkkDir & $AkkFileName
Global $AkkExists = FileExists($AkkPath)

Global Const $AkkNetFileName = $AkkFileName
Global Const $AkkNetDir = "\\172.16.128.4\edv\Gerrit\"
Global Const $AkkNetPath = $AkkNetDir & $AkkNetFileName
Global Const $AkkNetExists = FileExists($AkkNetPath)
#EndRegion
#Region
_Singleton("akkUpdater")

ConsoleLog("akkUpdater.exe gestartet")

While 42
	Update()
	Sleep($T1)
WEnd

Func Update()
	If ProcessClose($AkkFileName) Then
		$AkkExists = FileCopy($AkkNetPath, $AkkPath, $FC_OVERWRITE + $FC_CREATEPATH)
		If CheckAndRunProc($AkkFileName, $AkkDir, $AkkPath, $AkkExists) Then
			Exit
		EndIf
	EndIf
EndFunc   ;==>Update

Func CheckAndRunProc($Name, $Dir, $Path, $Exists, $ShowFlag = @SW_HIDE)
    If $Exists And Not ProcessExists($Name) Then
        ConsoleLog($Name & " wird gestartet")
        Return Run($Path, $Dir, $ShowFlag)
    EndIf
	Return 0
EndFunc   ;==>CheckAndRunProc

Func ConsoleLog($Text)
    ConsoleWrite(@CRLF & $Text)
    TrayTip("", $Text, $TrayTipTimeout, $TIP_ICONEXCLAMATION)
EndFunc   ;==>ConsoleLog
#EndRegion
