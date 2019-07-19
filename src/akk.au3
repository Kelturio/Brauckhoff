#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons\MyAutoIt3_Blue.ico
#AutoIt3Wrapper_Outfile=..\bin\akk.exe
#AutoIt3Wrapper_Res_Comment=Hallo Werner!
#AutoIt3Wrapper_Res_Description=Akk Brauckhoff Bot
#AutoIt3Wrapper_Res_Fileversion=1.0.0.63
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Akk Brauckhoff Bot
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
#include <Array.au3>
#include <File.au3>
#include <Misc.au3>
#include <Date.au3>
#include <Inet.au3>
#Region - Options
;~ Opt('CaretCoordMode', 0)				; 1 = Absolute screen coordinates, 0 = Relative coords to the active window.
;~ Opt('ExpandEnvStrings', 1)			; 0 = Don't expand, 1 = Do expand (Use %dos% variables in strings).
Opt('ExpandVarStrings', 1)            ; 0 = Don't expand, 1 = Do expand (Use $autoit$ variables in strings).
;~ Opt('FtpBinaryMode', 0)				; 1 = Binary transfer, 0 = ASCII transfer.
;~ Opt('GUICloseOnESC', 0)				; 1 = Send the $GUI_EVENT_CLOSE message when ESC is pressed (default).
; 										  0 = Don't send the $GUI_EVENT_CLOSE message when ESC is pressed.
;~ Opt('GUICoordMode', 2)				; 1 = Absolute coordinates still relative to the dialog box.
; 										  0 = Relative position to the start of the last control (Upper left corner).
; 										  2 = Cell positionining relative to current cell.
;~ Opt('GUIDataSeparatorChar', '')		; ''  Define the character which delimits subitems in GUICtrlSetData. The default character is ''.
;~ Opt('GUIEventOptions', 1)			; 0 = Windows behavior on click on Minimize, Restore and Maximize.
;										  1 = Suppress windows behavior on minimize, restore or Maximize. Just send notification.
;										  2 = GUICtrlRead of a tab control return ControlID instead of index of the Tab.
;										  3 = Combined mode of 1 & 2.
;~ Opt('GUIOnEventMode', 1)				; 0 = Disable, 1 = Enable.
;~ Opt('GUIResizeMode', 1)				; 0 = No resizing, <1024 = Anytype of resizing (Reference: GuiCtrlSetResizing).
;~ Opt('MouseClickDelay', 10)			; ? = 10 milliseconds by default.
;~ Opt('MouseClickDownDelay', 10)		; ? = 10 milliseconds by default.
;~ Opt('MouseClickDragDelay', 250)		; ? = 250 milliseconds by default.
;~ Opt('MouseCoordMode', 0)				; 1 = Absolute, 0 = Relative to active window, 2 = Relative to client area.
Opt('MustDeclareVars', 1)            ; 0 = No, 1 = Require pre-declare.
;~ Opt('OnExitFunc', '')				; ''  Sets the name of the function called when AutoIt exits (Default is OnAutoItExit).
;~ Opt('PixelCoordMode', 0)				; 1 = Absolute, 0 = relative, 2 = Relative coords to the client area.
;~ Opt('SendAttachMode', 1)				; 0 = Don't attach, 1 = Attach.
;~ Opt('SendCapslockMode', 0)			; 1 = Store and restore, 0 = Don't store / restore.
;~ Opt('SendKeyDelay', 5)				; ? = 5 milliseconds by default.
;~ Opt('SendKeyDownDelay', 1)			; ? = 1 millisecond by default.
;~ Opt('TCPTimeout', 100)				; ? = 100 milliseconds by default.
Opt('TrayAutoPause', 0)                ; 1 = AutoPausing is On, 0 = AutoPausing is Off.
;~ Opt('TrayIconDebug', 1)				; 0 = No info, 1 = Debug line info.
;~ Opt('TrayIconHide', 1)				; 0 = Show, 1 = Hide.
;~ Opt('TrayMenuMode', 1)				; 0 = Default menu items (Script Paused / Exit) are appended to the user created menu,
;											user created checked items will automatically unchecked, if you double click the tray
;											icon then the controlid is returned which has the "Default"-style.
;										  1 = No default menu.
;										  2 = User created checked items will not automatically unchecked if you click it.
;										  4 = Don't return the menuitemID which has the "default"-style in
;											the main contextmenu if you double click the tray icon.
;~ Opt('TrayOnEventMode', 1)			; 0 = disable, 1 = enable.
;~ Opt('WinDetectHiddenText', 1)		; 0 = Don't detect, 1=Do detect.
;~ Opt('WinSearchChildren', 1)			; 0 = No, 1 = Search children also.
;~ Opt('WinTextMatchMode', 4)			; 1 = Complete / Slow mode, 2 = Quick mode.
;~ Opt('WinTitleMatchMode', 4)			; 1 = Start, 2 = SubString, 3 = Exact, 4 = Advanced, -1 to -4 = Case Insensitive.
;~ Opt('WinWaitDelay', 250)				; ? = 250 milliseconds by default.
#EndRegion - Options
#Region Globals 1
Global Const $T1 = 15e3
Global Const $T2 = 15e3
Global Const $MsgBoxTimeout = 60 * 5
Global Const $TrayTipTimeout = 15
Global $Cycle = 0
Global $StartTimer = TimerInit()
Global $Timer1 = $StartTimer
Global $Timer2 = $StartTimer
Global $Timer3 = $StartTimer
Global $Timer4 = $StartTimer
Global $Timer5 = $StartTimer
Global Const $IntMin = 0x8000000000000000
Global Const $IntMax = 0x7FFFFFFFFFFFFFFF

Global Const $SpawnFileName = "ShadowSpawn.exe"
Global Const $SpawnDir = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $SpawnPath = $SpawnDir & $SpawnFileName
Global Const $SpawnExists = FileExists($SpawnPath)

Global Const $KPSInfoFileName = "KPSInfo.exe"
Global Const $KPSInfoDir = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $KPSInfoPath = $KPSInfoDir & $KPSInfoFileName
Global Const $KPSInfoExists = FileExists($KPSInfoPath)

Global Const $PowerkatalogFileName = "Powerkatalog-Schnittstelle.exe"
Global Const $PowerkatalogDir = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $PowerkatalogPath = $PowerkatalogDir & $PowerkatalogFileName
Global Const $PowerkatalogExists = FileExists($PowerkatalogPath)

Global Const $SHDUpdaterFileName = "SHDUpdater_min.exe"
Global Const $SHDUpdaterDir = @ProgramFilesDir & "\SHDUpdater\"
Global Const $SHDUpdaterPath = $SHDUpdaterDir & $SHDUpdaterFileName
Global Const $SHDUpdaterExists = FileExists($SHDUpdaterPath)
#EndRegion Globals 1
#Region Globals 2
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
Global Const $AkkExists = FileExists($AkkPath)

Global Const $AkkNetFileName = $AkkFileName
Global Const $AkkNetDir = $RootDir
Global Const $AkkNetPath = $AkkNetDir & $AkkNetFileName
Global Const $AkkNetExists = FileExists($AkkNetPath)

Global Const $AkkUpdaterFileName = "akkUpdater.exe"
Global Const $AkkUpdaterDir = $AkkDir
Global Const $AkkUpdaterPath = $AkkUpdaterDir & $AkkUpdaterFileName
Global $AkkUpdaterExists = FileExists($AkkUpdaterPath)

Global Const $AkkUpdaterNetFileName = $AkkUpdaterFileName
Global Const $AkkUpdaterNetDir = $RootDir
Global Const $AkkUpdaterNetPath = $AkkUpdaterNetDir & $AkkUpdaterNetFileName
Global Const $AkkUpdaterNetExists = FileExists($AkkUpdaterNetPath)

Global Const $IniLocalFileName = "akk.ini"
Global Const $IniLocalDir = $AkkDir
Global Const $IniLocalPath = $IniLocalDir & $IniLocalFileName
Global Const $IniLocalExists = FileExists($IniLocalPath)

Global Const $IniGlobalFileName = "akkGlobalConfig.ini"
Global Const $IniGlobalDir = $AkkDir
Global Const $IniGlobalPath = $IniGlobalDir & $IniGlobalFileName
Global $IniGlobalExists = FileExists($IniGlobalPath)

Global Const $IniGlobalNetFileName = $IniGlobalFileName
Global Const $IniGlobalNetDir = $AkkRootDir
Global Const $IniGlobalNetPath = $IniGlobalNetDir & $IniGlobalNetFileName
Global Const $IniGlobalNetExists = FileExists($IniGlobalNetPath)

Global Const $IniGlobalExFileName = "akkGlobalConfigExtended.ini"
Global Const $IniGlobalExDir = $IniGlobalDir
Global Const $IniGlobalExPath = $IniGlobalExDir & $IniGlobalExFileName
Global $IniGlobalExExists = FileExists($IniGlobalExPath)

Global Const $IniGlobalExNetFileName = $IniGlobalExFileName
Global Const $IniGlobalExNetDir = $AkkRootDir
Global Const $IniGlobalExNetPath = $IniGlobalExNetDir & $IniGlobalExNetFileName
Global Const $IniGlobalExNetExists = FileExists($IniGlobalExNetPath)

Global $LogFileID

Global $LogFileName = ""
Global Const $LogDir = $AkkDir & "log\"
Global $LogPath = $LogDir & $LogFileName
Global $LogExists = FileExists($LogPath)
If Not $LogExists Then DirCreate($LogDir)

Global $LogNetFileName = ""
Global Const $LogNetDir = $AkkRootDir & "log\" & @ComputerName & "\"
Global $LogNetPath = $LogNetDir & $LogNetFileName
Global $LogNetExists = FileExists($LogNetPath)
If Not $LogNetExists Then DirCreate($LogNetDir)

Global $LogGlobalNetFileName = "akkGlobal.log"
Global Const $LogGlobalNetDir = $AkkRootDir & "log\"
Global $LogGlobalNetPath = $LogGlobalNetDir & $LogGlobalNetFileName
Global $LogGlobalNetExists = FileExists($LogGlobalNetPath)

Global $LogArchiveNetFileName = ""
Global Const $LogArchiveNetDir = $AkkRootDir & "log\_archive\"
Global $LogArchiveNetPath = $LogArchiveNetDir & $LogArchiveNetFileName
Global $LogArchiveNetExists = FileExists($LogArchiveNetPath)
If Not $LogArchiveNetExists Then DirCreate($LogArchiveNetDir)

Global Const $IniGlobalNetLogFileName = "akkGlobal.ini"
Global Const $IniGlobalNetLogDir = $AkkRootDir & "log\"
Global Const $IniGlobalNetLogPath = $IniGlobalNetLogDir & $IniGlobalNetLogFileName
Global Const $IniGlobalNetLogExists = FileExists($IniGlobalNetLogPath)

Global Const $IniGlobalNetLogInstanceFileName = "akkMacro.ini"
Global Const $IniGlobalNetLogInstanceDir = $LogNetDir
Global Const $IniGlobalNetLogInstancePath = $IniGlobalNetLogInstanceDir & $IniGlobalNetLogInstanceFileName
Global Const $IniGlobalNetLogInstanceExists = FileExists($IniGlobalNetLogInstancePath)

Global Const $LogScrapeFileName = "scrape.prom"
Global Const $LogScrapeDir = $AkkDir & "log\"
Global Const $LogScrapePath = $LogScrapeDir & $LogScrapeFileName
Global Const $LogScrapeExists = FileExists($LogScrapePath)

Global Const $LogScrapeNetFileName = "scrape.prom"
Global Const $LogScrapeNetDir = $LogNetDir
Global Const $LogScrapeNetPath = $LogScrapeNetDir & $LogScrapeNetFileName
Global Const $LogScrapeNetExists = FileExists($LogScrapeNetPath)

Global Const $DownloadsDir = @UserProfileDir & "\Downloads"
Global Const $DownloadsOldDir = $DownloadsDir & " alt"

Global Const $ArrayDelimItem = "|"
Global $MacroAutoIt[1][2]
Global $MacroDirectory[1][2]
Global $MacroSystemInfo[1][2]
#EndRegion Globals 2
#Region Globals SMTP
Global $SmtpMailSmtpServer = ""
Global Const $SmtpMailEHLO = @ComputerName
Global Const $SmtpMailFirst = -1
Global Const $SmtpMailTrace = 0

Global $LowSpaceThresholdPerc
Global $MailAddresses[10][2]
#EndRegion Globals SMTP
#Region Globals Prometheus WMI Exporter
Global $hDownload = 0
Global $ScrapeComplete = 1
Global $WmiExporter1PID

Global Const $WmiExporterLocalFileName = "wmi_exporter.exe"
Global Const $WmiExporterLocalDir = @HomeDrive & "\Brauckhoff\wmi_exporter\" ;@SCRIPTDIR?
Global Const $WmiExporterLocalPath = $WmiExporterLocalDir & $WmiExporterLocalFileName
Global $WmiExporterLocalExists = FileExists($WmiExporterLocalPath)

Global Const $WmiExporterX32GlobalNetSetupFileName = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $WmiExporterX32GlobalNetSetupDir = $AkkRootDir & "wmi_exporter\"
Global Const $WmiExporterX32GlobalNetSetupPath = $WmiExporterX32GlobalNetSetupDir & $WmiExporterX32GlobalNetSetupFileName
Global Const $WmiExporterX32GlobalNetSetupExists = FileExists($WmiExporterX32GlobalNetSetupPath)

Global Const $WmiExporterX64GlobalNetSetupFileName = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $WmiExporterX64GlobalNetSetupDir = $AkkRootDir & "wmi_exporter\"
Global Const $WmiExporterX64GlobalNetSetupPath = $WmiExporterX64GlobalNetSetupDir & $WmiExporterX64GlobalNetSetupFileName
Global Const $WmiExporterX64GlobalNetSetupExists = FileExists($WmiExporterX64GlobalNetSetupPath)

Global Const $WmiExporterCollectorsEnabled = "cs,logical_disk,memory,net,os,process,service,system,textfile"
;~          & "" _ ;~ & "ad" _ ; Active Directory Domain Services
;~          & "" _ ;~ & ",cpu" _ ; CPU usage
;~          & "cs" _ ; "Computer System" metrics (system properties, num cpus/total memory)
;~          & "" _ ;~ & ",dns" _ ; DNS Server
;~          & "" _ ;~ & ",hyperv" _ ; Hyper-V hosts
;~          & "" _ ;~ & ",iis" _ ; IIS sites and applications
;~          & ",logical_disk" _ ; Logical disks, disk I/O
;~          & ",memory" _ ; Memory usage metrics
;~          & "" _ ;~ & ",msmq" _ ; MSMQ queues
;~          & "" _ ;~ & ",mssql" _ ; SQL Server Performance Objects metrics
;~          & "" _ ;~ & ",netframework_clrexceptions" _ ; .NET Framework CLR Exceptions
;~          & "" _ ;~ & ",netframework_clrinterop" _ ; .NET Framework Interop Metrics
;~          & "" _ ;~ & ",netframework_clrjit" _ ; .NET Framework JIT metrics
;~          & "" _ ;~ & ",netframework_clrloading" _ ; .NET Framework CLR Loading metrics
;~          & "" _ ;~ & ",netframework_clrlocksandthreads" _ ; .NET Framework locks and metrics threads
;~          & "" _ ;~ & ",netframework_clrmemory" _ ; .NET Framework Memory metrics
;~          & "" _ ;~ & ",netframework_clrremoting" _ ; .NET Framework Remoting metrics
;~          & "" _ ;~ & ",netframework_clrsecurity" _ ; .NET Framework Security Check metrics
;~          & ",net" _ ; Network interface I/O
;~          & ",os" _ ; OS metrics (memory, processes, users)
;~          & ",process" _ ; Per-process metrics
;~          & ",service" _ ; Service state metrics
;~          & ",system" _ ; System calls
;~          & "" _ ;~ & ",tcp" _ ; TCP connections
;~          & ",textfile" _ ; Read prometheus metrics from a text file
;~          & "" _ ;~ & ",vmware" ; Performance counters installed by the Vmware Guest agent

Global Const $WmiExporterCollectorTextfileDir = $WmiExporterLocalDir & "textfile_inputs\"

Global Const $WmiExporterMetadataFileName = "metadata.prom"
Global Const $WmiExporterMetadataDir = $WmiExporterCollectorTextfileDir
Global Const $WmiExporterMetadataPath = $WmiExporterMetadataDir & $WmiExporterMetadataFileName
Global $WmiExporterMetadataExists = FileExists($WmiExporterMetadataPath)

Global $WmiExporterMetadataString
Global $WmiExporterMetadataArray[2]
Global $WmiExporterMetadataArrayRet

Global Const $WmiExporterParams = '' _
         & ' --log.format logger:eventlog?name=wmi_exporter' _
         & ' --collectors.enabled ' & $WmiExporterCollectorsEnabled _
         & ' --telemetry.addr :9182 ' _
         & ' --collector.textfile.directory ' & $WmiExporterCollectorTextfileDir
#EndRegion Globals Prometheus WMI Exporter
#Region
_Singleton("akk")

Sleep(5e3)

ReadLocalConfig()

ManageLogFile()

ConsoleLog("akk.exe läuft")
ConsoleLog($SpawnPath)
ConsoleLog($KPSInfoPath)
ConsoleLog($WmiExporterLocalPath)
ConsoleLog("werden überwacht")
;~ ConsoleLog($WmiExporterParams)

GetGlobalConfig()
ReadGlobalConfig()
WriteLogStartup()
SetupWmiExporter()
CleaningDownloads()
CheckHomeDriveSpaceFree()

Sleep(5e3)

While 42
    Sleep(10)
    If (Mod($Cycle, 300) = 0) Then
        If Timeout($Timer1, 15e3 * 1) Then Check()
        If Timeout($Timer2, 60e3 * 5) Then GetGlobalConfig()
        If Timeout($Timer3, 60e3 * 5) Then ManageLogFile()
        If Timeout($Timer4, 60e3 * 5) Then Scrape()
        If Timeout($Timer5, 10e3 * 1) Then WriteMetaDataFile()
    EndIf
    If (Mod($Cycle, 500) = 0) Then ScrapeDownload()
    $Cycle += 1
WEnd

Func ConsoleLog($Text)
    $Text = StringFormat("%10s", $Cycle) & " : " & $Text
    ConsoleWrite(@CRLF & $Text)
;~     If @OSArch <> "WIN_10" Then TrayTip("", $Text, $TrayTipTimeout, $TIP_ICONEXCLAMATION)
    _FileWriteLog($LogPath, $Text)
    _FileWriteLog($LogNetPath, $Text)
    _FileWriteLog($LogGlobalNetPath, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $Text)
EndFunc   ;==>ConsoleLog

Func GetGlobalConfig()
    If $IniGlobalNetExists And Not $IniGlobalExists Then
        $IniGlobalExists = FileCopy($IniGlobalNetPath, $IniGlobalPath, $FC_OVERWRITE + $FC_CREATEPATH)
    EndIf
    If $IniGlobalExNetExists And Not $IniGlobalExExists Then
        $IniGlobalExExists = FileCopy($IniGlobalExNetPath, $IniGlobalExPath, $FC_OVERWRITE + $FC_CREATEPATH)
    EndIf
    If $AkkUpdaterNetExists And Not $AkkUpdaterExists Then
        $AkkUpdaterExists = FileCopy($AkkUpdaterNetPath, $AkkUpdaterPath, $FC_OVERWRITE + $FC_CREATEPATH)
    EndIf

    Local $IniGlobalTime = FileGetTime($IniGlobalPath, $FT_MODIFIED, $FT_STRING)
    Local $IniGlobalNetTime = FileGetTime($IniGlobalNetPath, $FT_MODIFIED, $FT_STRING)
    If $IniGlobalTime <> $IniGlobalNetTime Then
        $IniGlobalExists = FileCopy($IniGlobalNetPath, $IniGlobalPath, $FC_OVERWRITE + $FC_CREATEPATH)
        ConsoleLog("Reload Config " & $IniGlobalNetPath)
        ReadGlobalConfig()
    EndIf

    Local $IniGlobalExTime = FileGetTime($IniGlobalExPath, $FT_MODIFIED, $FT_STRING)
    Local $IniGlobalExNetTime = FileGetTime($IniGlobalExNetPath, $FT_MODIFIED, $FT_STRING)
    If $IniGlobalExTime <> $IniGlobalExNetTime Then
        $IniGlobalExExists = FileCopy($IniGlobalExNetPath, $IniGlobalExPath, $FC_OVERWRITE + $FC_CREATEPATH)
        ConsoleLog("Reload Config Ex" & $IniGlobalExNetPath)
        ReadGlobalConfig()
        WriteMetaDataFile()
    EndIf

    Local $AkkUpdaterTime = FileGetTime($AkkUpdaterPath, $FT_MODIFIED, $FT_STRING)
    Local $AkkUpdaterNetTime = FileGetTime($AkkUpdaterNetPath, $FT_MODIFIED, $FT_STRING)
    If $AkkUpdaterTime <> $AkkUpdaterNetTime And @Compiled Then
        $AkkUpdaterExists = FileCopy($AkkUpdaterNetPath, $AkkUpdaterPath, $FC_OVERWRITE + $FC_CREATEPATH)
        ConsoleLog("Reload Akk Updater " & $AkkUpdaterNetPath)
    EndIf

    Local $AkkTime = FileGetTime($AkkPath, $FT_MODIFIED, $FT_STRING)
    Local $AkkNetTime = FileGetTime($AkkNetPath, $FT_MODIFIED, $FT_STRING)
    If $AkkTime <> $AkkNetTime And @Compiled Then
        CheckAndRunProc($AkkUpdaterFileName, $AkkUpdaterDir, $AkkUpdaterPath, $AkkUpdaterExists)
        ConsoleLog("Reload Akk " & $AkkNetPath)
    EndIf
EndFunc   ;==>GetGlobalConfig

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

Func ReadGlobalConfig()
    If FileExists($IniGlobalPath) Then
        $LowSpaceThresholdPerc = IniRead($IniGlobalPath, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
        For $i = 0 To 9 Step 1
            $MailAddresses[$i][0] = IniRead($IniGlobalPath, "FreeSpaceCheck", "Mail" & $i & "Address", "")
            $MailAddresses[$i][1] = IniRead($IniGlobalPath, "FreeSpaceCheck", "Mail" & $i & "Active", 0)
        Next
        $SmtpMailSmtpServer = IniRead($IniGlobalPath, "SmtpMail", "SmtpServer", "")
    EndIf
    If FileExists($IniGlobalExPath) Then
        $WmiExporterMetadataString = IniRead($IniGlobalExPath, "MetaData", @ComputerName, "NULL")
        If $WmiExporterMetadataString = "NULL" Then
            IniWrite($IniGlobalExNetPath, "MetaData", @ComputerName, "")
        EndIf
    EndIf
EndFunc   ;==>ReadGlobalConfig

Func ReadLocalConfig()
    $LogFileID = IniRead($IniLocalPath, "LogFile", "ID", "NULL")
    If $LogFileID = "NULL" Then
        IniWrite($IniLocalPath, "LogFile", "ID", 0)
        $LogFileID = 0
    EndIf
EndFunc   ;==>ReadLocalConfig

Func SetVar(ByRef $Var, $Value)
    $Var = $Value
    Return $Value
EndFunc   ;==>SetVar

Func Timeout(ByRef $Timer, $Delay)
    Local $Diff = TimerDiff($Timer)
    If $Diff > $Delay Then
        $Timer = TimerInit()
        Return $Diff
    EndIf
    Return 0
EndFunc   ;==>Timeout

Func WriteLogStartup()
    Local Const $DelimItem = $ArrayDelimItem
    IniWrite($IniGlobalNetLogPath, "Computername", @IPAddress1, @ComputerName)
    IniWrite($IniGlobalNetLogPath, "IPAddress1", @ComputerName, @IPAddress1)
    IniWrite($IniGlobalNetLogPath, "AkkVersion", @ComputerName, FileGetVersion(@ScriptFullPath))

    _ArrayAdd($MacroAutoIt, "Compiled" & $DelimItem & @Compiled, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "ScriptName" & $DelimItem & @ScriptName, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "ScriptDir" & $DelimItem & @ScriptDir, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "ScriptFullPath" & $DelimItem & @ScriptFullPath, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "WorkingDir" & $DelimItem & @WorkingDir, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "AutoItExe" & $DelimItem & @AutoItExe, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "AutoItPID" & $DelimItem & @AutoItPID, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "AutoItVersion" & $DelimItem & @AutoItVersion, 0, $DelimItem)
    _ArrayAdd($MacroAutoIt, "AutoItX64" & $DelimItem & @AutoItX64, 0, $DelimItem)
;~     _ArrayDisplay($MacroAutoIt)
    IniWriteSection($IniGlobalNetLogInstancePath, "MacroAutoIt", $MacroAutoIt)

    _ArrayAdd($MacroDirectory, "AppDataCommonDir" & $DelimItem & @AppDataCommonDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "DesktopCommonDir" & $DelimItem & @DesktopCommonDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "DocumentsCommonDir" & $DelimItem & @DocumentsCommonDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "FavoritesCommonDir" & $DelimItem & @FavoritesCommonDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "ProgramsCommonDir" & $DelimItem & @ProgramsCommonDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "StartMenuCommonDir" & $DelimItem & @StartMenuCommonDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "StartupCommonDir" & $DelimItem & @StartupCommonDir, 0, $DelimItem)

    _ArrayAdd($MacroDirectory, "AppDataDir" & $DelimItem & @AppDataDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "LocalAppDataDir" & $DelimItem & @LocalAppDataDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "DesktopDir" & $DelimItem & @DesktopDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "MyDocumentsDir" & $DelimItem & @MyDocumentsDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "FavoritesDir" & $DelimItem & @FavoritesDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "ProgramsDir" & $DelimItem & @ProgramsDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "StartMenuDir" & $DelimItem & @StartMenuDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "StartupDir" & $DelimItem & @StartupDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "UserProfileDir" & $DelimItem & @UserProfileDir, 0, $DelimItem)

    _ArrayAdd($MacroDirectory, "HomeDrive" & $DelimItem & @HomeDrive, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "HomePath" & $DelimItem & @HomePath, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "HomeShare" & $DelimItem & @HomeShare, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "LogonDNSDomain" & $DelimItem & @LogonDNSDomain, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "LogonDomain" & $DelimItem & @LogonDomain, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "LogonServer" & $DelimItem & @LogonServer, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "ProgramFilesDir" & $DelimItem & @ProgramFilesDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "CommonFilesDir" & $DelimItem & @CommonFilesDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "WindowsDir" & $DelimItem & @WindowsDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "SystemDir" & $DelimItem & @SystemDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "TempDir" & $DelimItem & @TempDir, 0, $DelimItem)
    _ArrayAdd($MacroDirectory, "ComSpec" & $DelimItem & @ComSpec, 0, $DelimItem)
;~     _ArrayDisplay($MacroDirectory)
    IniWriteSection($IniGlobalNetLogInstancePath, "MacroDirectory", $MacroDirectory)

    _ArrayAdd($MacroSystemInfo, "CPUArch" & $DelimItem & @CPUArch, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "KBLayout" & $DelimItem & @KBLayout, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "MUILang" & $DelimItem & @MUILang, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "OSArch" & $DelimItem & @OSArch, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "OSLang" & $DelimItem & @OSLang, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "OSType" & $DelimItem & @OSType, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "OSVersion" & $DelimItem & @OSVersion, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "OSBuild" & $DelimItem & @OSBuild, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "OSServicePack" & $DelimItem & @OSServicePack, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "ComputerName" & $DelimItem & @ComputerName, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "UserName" & $DelimItem & @UserName, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "IPAddress1" & $DelimItem & @IPAddress1, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "IPAddress2" & $DelimItem & @IPAddress2, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "IPAddress3" & $DelimItem & @IPAddress3, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "IPAddress4" & $DelimItem & @IPAddress4, 0, $DelimItem)

    _ArrayAdd($MacroSystemInfo, "DesktopHeight" & $DelimItem & @DesktopHeight, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "DesktopWidth" & $DelimItem & @DesktopWidth, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "DesktopDepth" & $DelimItem & @DesktopDepth, 0, $DelimItem)
    _ArrayAdd($MacroSystemInfo, "DesktopRefresh" & $DelimItem & @DesktopRefresh, 0, $DelimItem)
;~     _ArrayDisplay($MacroSystemInfo)
    IniWriteSection($IniGlobalNetLogInstancePath, "MacroSystemInfo", $MacroSystemInfo)
EndFunc   ;==>WriteLogStartup
#EndRegion
#Region CheckAndRunProc
Func Check()
    CheckAndRunProc($SpawnFileName, $SpawnDir, $SpawnPath, $SpawnExists)
    CheckAndRunProc($KPSInfoFileName, $KPSInfoDir, $KPSInfoPath, $KPSInfoExists)
    $WmiExporter1PID = CheckAndRunProc($WmiExporterLocalFileName, $WmiExporterLocalDir, $WmiExporterLocalPath & $WmiExporterParams, $WmiExporterLocalExists)
;~     CheckAndRunProcAs($PowerkatalogFileName, $PowerkatalogDir, $PowerkatalogPath, $PowerkatalogExists, "Administrator", "Brauckhoff", "")
;~     CheckAndRunProc($SHDUpdaterFileName, $SHDUpdaterDir, $SHDUpdaterPath, $SHDUpdaterExists)
EndFunc   ;==>Check

Func CheckAndRunProc($Name, $Dir, $Path, $Exists, $ShowFlag = @SW_HIDE)
    If $Exists And Not ProcessExists($Name) Then
        ConsoleLog($Name & " wird gestartet")
        Return Run($Path, $Dir, $ShowFlag)
    EndIf
    Return 0
EndFunc   ;==>CheckAndRunProc

Func CheckAndRunProcAs($Name, $Dir, $Path, $Exists, $UserName, $Domain, $Password)
    If $Exists And Not ProcessExists($Name) Then
        ConsoleLog($Name & " wird gestartet als " & $UserName & " in " & $Domain & " mit Network credentials only")
        RunAs($UserName, $Domain, $Password, $RUN_LOGON_NETWORK, $Path, $Dir)
    EndIf
EndFunc   ;==>CheckAndRunProcAs
#EndRegion CheckAndRunProc
#Region CleaningDownloads
Func CleaningDownloads()
    If DownloadsNeedCleaning() Then
        DirRemove($DownloadsOldDir, $DIR_REMOVE)
        FileDirMoveRec($DownloadsDir, $DownloadsOldDir)
        FileDelete($DownloadsOldDir & "\Downloads alt.lnk")
        FileCreateShortcut($DownloadsOldDir, $DownloadsDir & "\Downloads alt")
        IniWrite($IniLocalPath, "Downloads", "LastCleaningDate", _DateToDayValue(@YEAR, @MON, @MDAY))
        Local Const $Warning = '' _
                 & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF _
                 & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF _
                 & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF _
                 & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF _
                 & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF _
                 & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
        If MsgBox($MB_YESNO + $MB_ICONWARNING + $MB_SYSTEMMODAL, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $Warning, $MsgBoxTimeout) = $IDYES Then
            ShellExecute($DownloadsOldDir)
        EndIf
    EndIf
EndFunc   ;==>CleaningDownloads

Func DownloadsNeedCleaning()
    Return (_DateToDayValue(@YEAR, @MON, @MDAY) - GetDownloadsLastCleaningDate()) >= 14
EndFunc   ;==>DownloadsNeedCleaning
Func FileDirMoveRec($SourceDir, $DestDir)
    If FileExists($SourceDir) Then
        If Not FileExists($DestDir) Then DirCreate($DestDir)
        FileMove($SourceDir & "\*.*", $DestDir, $FC_OVERWRITE + $FC_CREATEPATH)
        Local Const $FolderList = _FileListToArray($SourceDir, Default, $FLTA_FOLDERS, True)
        If Not @error Then
            For $Folder In $FolderList
                DirMove($Folder, $DestDir, $FC_OVERWRITE)
            Next
        EndIf
    EndIf
EndFunc   ;==>FileDirMoveRec

Func GetDownloadsLastCleaningDate()
    Return IniRead($IniLocalPath, "Downloads", "LastCleaningDate", "NULL")
EndFunc   ;==>GetDownloadsLastCleaningDate
#EndRegion CleaningDownloads
#Region FreeSpaceCheck
Func ByteSuffix($iBytes)
    Local $iIndex = 0, $aArray = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
    While $iBytes > 1023
        $iIndex += 1
        $iBytes /= 1024
    WEnd
    Return Round($iBytes) & $aArray[$iIndex]
EndFunc   ;==>ByteSuffix

Func CheckHomeDriveSpaceFree()
    Local Const $sLabel = DriveGetLabel(@HomeDrive & "\")
;~     Local Const $sSerial = DriveGetSerial(@HomeDrive & "\")
    Local Const $iFreeSpace = DriveSpaceFree(@HomeDrive & "\")
    Local Const $iTotalSpace = DriveSpaceTotal(@HomeDrive & "\")
    Local Const $iFreeSpacePerc = ($iFreeSpace / $iTotalSpace) * 100
    If $iFreeSpacePerc < $LowSpaceThresholdPerc Then
        If (_DateToDayValue(@YEAR, @MON, @MDAY) - IniRead($IniLocalPath, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
            IniWrite($IniLocalPath, "FreeSpaceCheck", "LastMailSendDate", _DateToDayValue(@YEAR, @MON, @MDAY))
            For $i = 0 To 9 Step 1
                If $MailAddresses[$i][0] <> "" And $MailAddresses[$i][1] = 1 Then
                    ConsoleLog("Sending Mail to " & $MailAddresses[$i][0])
                    SendMailLowSpace($MailAddresses[$i][0], Round($iFreeSpacePerc, 2), $sLabel, $iFreeSpace, $iTotalSpace)
                    Sleep(3000)
                EndIf
            Next
        EndIf
    EndIf
EndFunc   ;==>CheckHomeDriveSpaceFree

Func SendMailLowSpace($sToAddress, $iFreeSpacePerc, $sLabel, $iFreeSpace, $iTotalSpace)
    Local $sFromName = "akk.exe (Gerrit)"
    Local $sFromAddress = "akk@kuechen-brauckhoff.de"
    Local $sSubject = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $iFreeSpacePerc & "% !"
    Local $asBody[0]
    _ArrayAdd($asBody, "Akk Warnung wenig Speicherplatz auf:")
    _ArrayAdd($asBody, @ComputerName)
    If @IPAddress1 <> "0.0.0.0" Then _ArrayAdd($asBody, @IPAddress1)
    If @IPAddress2 <> "0.0.0.0" Then _ArrayAdd($asBody, @IPAddress2)
    If @IPAddress3 <> "0.0.0.0" Then _ArrayAdd($asBody, @IPAddress3)
    If @IPAddress4 <> "0.0.0.0" Then _ArrayAdd($asBody, @IPAddress4)
    _ArrayAdd($asBody, $sLabel & " (" & @HomeDrive & ")")
    _ArrayAdd($asBody, Round($iFreeSpace / 1024, 2) & " GB frei von " & Round($iTotalSpace / 1024, 2) & " GB")
    _ArrayAdd($asBody, $iFreeSpacePerc & "% frei")
    Local $iResponse = _INetSmtpMail($SmtpMailSmtpServer, $sFromName, $sFromAddress, $sToAddress, $sSubject, $asBody, $SmtpMailEHLO, $SmtpMailFirst, $SmtpMailTrace)
    Local $iErr = @error
    If $iResponse = 0 Then
        Local Const $Warning = '' _
                 & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF _
                 & 'Bitte Herrn Heger bescheid geben:' & @CRLF _
                 & 'heger@easyconnectit.de' & @CRLF _
                 & 'oder 0176 23984427' & @CRLF & @CRLF _
                 & _ArrayToString($asBody, @CRLF) & @CRLF & @CRLF _
                 & 'Mail failed with error code ' & $iErr & @CRLF
        MsgBox($MB_ICONWARNING + $MB_SYSTEMMODAL, "Warnung!", $Warning)
    EndIf
EndFunc   ;==>SendMailLowSpace
#EndRegion FreeSpaceCheck
#Region WMI Exporter
Func Scrape()
    If $ScrapeComplete And ProcessExists($WmiExporterLocalFileName) Then
        $hDownload = InetGet("http://localhost:9182/metrics", $LogScrapePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
        $ScrapeComplete = 0
    EndIf
EndFunc   ;==>Scrape

Func ScrapeDownload()
    If Not $ScrapeComplete Then
        If InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE) Then
            If InetGetInfo($hDownload, $INET_DOWNLOADSUCCESS) Then
                If FileGetSize($LogScrapePath) Then FileCopy($LogScrapePath, $LogScrapeNetPath, $FC_OVERWRITE + $FC_CREATEPATH)
            Else
                FileDelete($LogScrapePath)
                ConsoleLog("Error ScrapeDownload")
            EndIf
            InetClose($hDownload)
            $hDownload = 0
            $ScrapeComplete = 1
        EndIf
    EndIf
EndFunc   ;==>ScrapeDownload

Func SetupWmiExporter()
    ProcessClose($WmiExporterLocalFileName)
    If Not $WmiExporterLocalExists Then
        Local $SourcePath = (@OSArch = "X64") ? $WmiExporterX64GlobalNetSetupPath : $WmiExporterX32GlobalNetSetupPath
        If FileCopy($SourcePath, $WmiExporterLocalPath, $FC_OVERWRITE + $FC_CREATEPATH) Then
            $WmiExporterLocalExists = FileExists($WmiExporterLocalPath)
        EndIf
    EndIf
    If Not FileExists($WmiExporterCollectorTextfileDir) Then DirCreate($WmiExporterCollectorTextfileDir)
    WriteMetaDataFile()
EndFunc   ;==>SetupWmiExporter

Func WriteMetaDataFile()
    Local $MetaData = 'metadata{computername="' & @ComputerName & '"' & ',username="' & @UserName & '"'
    If $WmiExporterMetadataString <> "NULL" And StringLen($WmiExporterMetadataString) And Not StringIsSpace($WmiExporterMetadataString) Then
        $MetaData &= "," & $WmiExporterMetadataString
    EndIf
    $MetaData &= '} 1'
    $WmiExporterMetadataArray[1] = $MetaData
    $WmiExporterMetadataArray[0] = UBound($WmiExporterMetadataArray) - 1
    _FileReadToArray($WmiExporterMetadataPath, $WmiExporterMetadataArrayRet)
    If Not _ArrayCompare($WmiExporterMetadataArray, $WmiExporterMetadataArrayRet, 3) Then
        _FileWriteFromArray($WmiExporterMetadataPath, $WmiExporterMetadataArray, 1)
    EndIf
EndFunc   ;==>WriteMetaDataFile
#EndRegion WMI Exporter
#Region UDF
;~ https://www.autoitscript.com/forum/topic/182506-array-comparison/
;~ Melba23
Func _ArrayCompare(Const ByRef $aArray1, Const ByRef $aArray2, $iMode = 0)

    ; Check if arrays
    If Not (IsArray($aArray1)) Or Not (IsArray($aArray2)) Then
        Return SetError(1, 0, 0)
    EndIf

    ; Check if same number of dimensions
    Local $iDims = UBound($aArray1, $UBOUND_DIMENSIONS)
    If $iDims <> UBound($aArray2, $UBOUND_DIMENSIONS) Then
        Return SetError(2, 0, 0)
    EndIf

    ; Check if same size
    Local $iRows = UBound($aArray1, $UBOUND_ROWS)
    Local $iCols = UBound($aArray1, $UBOUND_COLUMNS)
    If $iRows <> UBound($aArray2, $UBOUND_ROWS) Or $iCols <> UBound($aArray2, $UBOUND_COLUMNS) Then
        Return SetError(3, 0, 0)
    EndIf

    Local $sString_1, $sString_2

    Switch $iMode

        Case 0     ; Compare each element
            For $i = 0 To $iRows - 1
                For $j = 0 To $iCols - 1
                    If $aArray1[$i][$j] <> $aArray1[$i][$j] Then
                        Return SetError(4, 0, 0)
                    EndIf
                Next
            Next

        Case 1     ; Convert rows to strings
            For $i = 0 To $iRows - 1
                For $j = 0 To $iCols - 1
                    $sString_1 &= $aArray1[$i][$j]
                    $sString_2 &= $aArray2[$i][$j]
                Next
                If $sString_1 <> $sString_2 Then
                    Return SetError(4, 0, 0)
                EndIf
            Next

        Case 2     ; Convert columnss to strings
            For $j = 0 To $iCols - 1
                For $i = 0 To $iRows - 1
                    $sString_1 &= $aArray1[$i][$j]
                    $sString_2 &= $aArray2[$i][$j]
                Next
                If $sString_1 <> $sString_2 Then
                    Return SetError(4, 0, 0)
                EndIf
            Next

        Case 3     ; Convert whole array to string
            If _ArrayToString($aArray1) <> _ArrayToString($aArray2) Then
                Return SetError(4, 0, 0)
            EndIf

    EndSwitch

    ; Looks as if they match
    Return 1

EndFunc   ;==>_ArrayCompare
#EndRegion UDF

