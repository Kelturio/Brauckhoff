#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\MyAutoIt3_Yellow.ico
#AutoIt3Wrapper_Outfile=..\bin\akkUpdater.exe
#AutoIt3Wrapper_Res_Comment=Hallo Werner!
#AutoIt3Wrapper_Res_Description=Akk Brauckhoff Bot Updater
#AutoIt3Wrapper_Res_Fileversion=1.0.0.5
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Akk Brauckhoff Bot Updater
#AutoIt3Wrapper_Res_CompanyName=Sliph Co.
#AutoIt3Wrapper_Res_LegalCopyright=Searinox
#AutoIt3Wrapper_Res_LegalTradeMarks=Akk
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1031
#AutoIt3Wrapper_Res_Field=Made By|Searinox
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -v 1 -v 3
#AutoIt3Wrapper_Run_Before=call "..\compile\before.bat" %scriptdir% %scriptfile% "..\compile\log.txt"
#AutoIt3Wrapper_Run_After=call "..\compile\after.bat" %scriptdir% %scriptfile% "..\compile\log.txt"
#AutoIt3Wrapper_Run_Tidy=y
#Tidy_Parameters=/tc 4 /gd /reel /sci 9 /kv 0 /bdir "tidy\bdir\" /sf
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/tl /debug /pe /mi=99 /rm /rsln
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

#ce ----------------------------------------------------------------------------
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>
#include <FileConstants.au3>
#include <Misc.au3>
#Region
Opt("MustDeclareVars", 1) ;0=no, 1=require pre-declaration
Opt("TrayAutoPause", 0) ;0=no pause, 1=Pause
#EndRegion
#Region
Global Const $T1 = 1000 * 15
Global Const $TrayTipTimeout = 15

Global Const $RootFileName = ""
Global Const $RootDir = "\\172.16.128.4\edv\Gerrit\"
Global Const $RootPath = $RootDir & $RootFileName
Global Const $RootExists = FileExists($RootPath)

Global Const $AkkFileName = "akk.exe"
Global Const $AkkDir = @ScriptDir & "\"
Global Const $AkkPath = $AkkDir & $AkkFileName
Global $AkkExists = FileExists($AkkPath)

Global Const $AkkNetFileName = $AkkFileName
Global Const $AkkNetDir = $RootDir
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

Func Update()
    If ProcessClose($AkkFileName) Then
        $AkkExists = FileCopy($AkkNetPath, $AkkPath, $FC_OVERWRITE + $FC_CREATEPATH)
        If CheckAndRunProc($AkkFileName, $AkkDir, $AkkPath, $AkkExists) Then
            Exit
        EndIf
    EndIf
EndFunc   ;==>Update
#EndRegion
