#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\MyAutoIt3_Yellow.ico
#AutoIt3Wrapper_Outfile=..\bin\akkUpdater.exe
#AutoIt3Wrapper_Res_Comment=Hallo Werner!
#AutoIt3Wrapper_Res_Description=Akk Brauckhoff Bot Updater
#AutoIt3Wrapper_Res_Fileversion=1.0.0.12
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
#include <File.au3>
#include <Misc.au3>
#Region
Opt("MustDeclareVars", 1) ;0=no, 1=require pre-declaration
Opt("TrayAutoPause", 0) ;0=no pause, 1=Pause
#EndRegion
#Region
Global Const $T1 = 5e3
Global Const $T2 = 60e3
Global Const $TrayTipTimeout = 15
Global $Cycle = 0

Global Const $RootFileName = ""
Global Const $RootDir = "\\172.16.128.4\edv\Gerrit\"
Global Const $RootPath = $RootDir & $RootFileName
Global Const $RootExists = FileExists($RootPath)

Global Const $AkkRootFileName = ""
Global Const $AkkRootDir = $RootDir & "akk\"
Global Const $AkkRootPath = $AkkRootDir & $AkkRootFileName
Global Const $AkkRootExists = FileExists($AkkRootPath)

Global Const $AkkFileName = "akk.exe"
Global Const $AkkDir = @ScriptDir & "\"
Global Const $AkkPath = $AkkDir & $AkkFileName
Global $AkkExists = FileExists($AkkPath)

Global Const $AkkNetFileName = $AkkFileName
Global Const $AkkNetDir = $RootDir
Global Const $AkkNetPath = $AkkNetDir & $AkkNetFileName
Global Const $AkkNetExists = FileExists($AkkNetPath)

Global Const $IniLocalFileName = "akk.ini"
Global Const $IniLocalDir = $AkkDir
Global Const $IniLocalPath = $IniLocalDir & $IniLocalFileName
Global Const $IniLocalExists = FileExists($IniLocalPath)

Global $LogFileID

Global $LogFileName = ""
Global Const $LogDir = $AkkDir & "log\"
Global $LogPath = $LogDir & $LogFileName
Global $LogExists = FileExists($LogPath)

Global $LogNetFileName = ""
Global Const $LogNetDir = $AkkRootDir & "log\" & @ComputerName & "\"
Global $LogNetPath = $LogNetDir & $LogNetFileName
Global $LogNetExists = FileExists($LogNetPath)

Global $LogGlobalNetFileName = "akkGlobal.log"
Global Const $LogGlobalNetDir = $AkkRootDir & "log\"
Global $LogGlobalNetPath = $LogGlobalNetDir & $LogGlobalNetFileName
Global $LogGlobalNetExists = FileExists($LogGlobalNetPath)

Global $LogArchiveNetFileName = ""
Global Const $LogArchiveNetDir = $AkkRootDir & "log\_archive\"
Global $LogArchiveNetPath = $LogArchiveNetDir & $LogArchiveNetFileName
Global $LogArchiveNetExists = FileExists($LogArchiveNetPath)
If Not $LogArchiveNetExists Then DirCreate($LogArchiveNetDir)
#EndRegion
#Region
_Singleton("akkUpdater")

ConsoleLog("akkUpdater.exe gestartet")

Sleep($T1)

ReadLocalConfig()

ManageLogFile()

While 42
    Update()
    Sleep($T2)
    $Cycle += 1
WEnd

Func CheckAndRunProc($Name, $Dir, $Path, $Exists, $ShowFlag = @SW_HIDE)
    If $Exists And Not ProcessExists($Name) Then
        ConsoleLog($Name & " wird gestartet")
        Return Run($Path, $Dir, $ShowFlag)
    EndIf
    Return 0
EndFunc   ;==>CheckAndRunProc

Func ConsoleLog($Text)
    $Text = "C" & $Cycle & ": " & $Text
    ConsoleWrite(@CRLF & $Text)
;~     If @OSArch <> "WIN_10" Then TrayTip("", $Text, $TrayTipTimeout, $TIP_ICONEXCLAMATION)
    _FileWriteLog($LogPath, $Text)
    _FileWriteLog($LogNetPath, $Text)
    _FileWriteLog($LogGlobalNetPath, @UserName & "@" & @ComputerName & " " & $Text)
EndFunc   ;==>ConsoleLog

Func ManageLogFile()
    $LogFileName = StringFormat("%04s", $LogFileID) & ".log"
    $LogPath = $LogDir & $LogFileName
    $LogNetPath = $LogNetDir & $LogFileName
    If _FileCountLines($LogPath) > 1e3 Then
        $LogFileID += 1
        IniWrite($IniLocalPath, "LogFile", "ID", $LogFileID)
    EndIf
    IniWrite($IniLocalPath, "LogFile", "LogPath", $LogPath)
    IniWrite($IniLocalPath, "LogFile", "LogNetPath", $LogNetPath)
    If FileGetSize($LogGlobalNetPath) / 1024 > 100 Then
        Local $Dest = $LogArchiveNetDir & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
        FileMove($LogGlobalNetPath, $Dest, $FC_OVERWRITE + $FC_CREATEPATH)
    EndIf
EndFunc   ;==>ManageLogFile

Func ReadLocalConfig()
    $LogFileID = IniRead($IniLocalPath, "LogFile", "ID", "NULL")
    If $LogFileID = "NULL" Then
        IniWrite($IniLocalPath, "LogFile", "ID", 0)
        $LogFileID = 0
    EndIf
EndFunc   ;==>ReadLocalConfig

Func Update()
    ProcessClose($AkkFileName)
    Sleep($T1)
    If Not ProcessExists($AkkFileName) Then
        $AkkExists = FileCopy($AkkNetPath, $AkkPath, $FC_OVERWRITE + $FC_CREATEPATH)
        If CheckAndRunProc($AkkFileName, $AkkDir, $AkkPath, $AkkExists) Then
            Exit
        Else
            ConsoleLog("Error CheckAndRunProc")
        EndIf
    EndIf
EndFunc   ;==>Update
#EndRegion
