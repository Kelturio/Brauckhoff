#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=U:\Vogtländer\AutoIt\Icons\MyAutoIt3_Green.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.0.45
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
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>
#include <FileConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <Misc.au3>
#include <Date.au3>
#include <Inet.au3>
#Region
Opt("MustDeclareVars", 1) ;0=no, 1=require pre-declaration
Opt("TrayAutoPause", 0) ;0=no pause, 1=Pause
#EndRegion
#Region
Global Const $T1 = 1000 * 15
Global Const $T2 = 1000 * 15
Global Const $TrayTipTimeout = 15

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
#EndRegion
#Region
Global Const $IniLocalFileName = "akk.ini"
Global Const $IniLocalDir = @ScriptDir & "\"
Global Const $IniLocalPath = $IniLocalDir & $IniLocalFileName
Global Const $IniLocalExists = FileExists($IniLocalPath)

Global Const $IniGlobalFileName = "akkGlobalConfig.ini"
Global Const $IniGlobalDir = @ScriptDir & "\"
Global Const $IniGlobalPath = $IniGlobalDir & $IniGlobalFileName
Global Const $IniGlobalExists = FileExists($IniGlobalPath)

Global Const $IniGlobalNetFileName = "akkGlobalConfig.ini"
Global Const $IniGlobalNetDir = "\\172.16.128.4\edv\Gerrit\"
Global Const $IniGlobalNetPath = $IniGlobalNetDir & $IniGlobalNetFileName
Global Const $IniGlobalNetExists = FileExists($IniGlobalNetPath)

Global Const $IniGlobalNetLogFileName = "akkLog.ini"
Global Const $IniGlobalNetLogDir = $IniGlobalNetDir & "log\"
Global Const $IniGlobalNetLogPath = $IniGlobalNetLogDir & $IniGlobalNetLogFileName
Global Const $IniGlobalNetLogExists = FileExists($IniGlobalNetLogPath)

Global Const $IniGlobalNetLogInstanceFileName = "akkLog_" & @ComputerName & ".ini"
Global Const $IniGlobalNetLogInstanceDir = $IniGlobalNetLogDir
Global Const $IniGlobalNetLogInstancePath = $IniGlobalNetLogInstanceDir & $IniGlobalNetLogInstanceFileName
Global Const $IniGlobalNetLogInstanceExists = FileExists($IniGlobalNetLogInstancePath)

Global Const $DownloadsDir = @UserProfileDir & "\Downloads"
Global Const $DownloadsOldDir = $DownloadsDir & " alt"

Global Const $ArrayDelimItem = "|"
Global $MacroAutoIt[1][2]
Global $MacroDirectory[1][2]
Global $MacroSystemInfo[1][2]
#EndRegion
#Region
Global $SmtpMailSmtpServer = ""
Global Const $SmtpMailEHLO = @ComputerName
Global Const $SmtpMailFirst = -1
Global Const $SmtpMailTrace = 0

Global $LowSpaceThresholdPerc
Global $MailAddresses[10][2]
#EndRegion
#Region Globals Prometheus
Global Const $WmiExporterLocalFileName = "wmi_exporter.exe"
Global Const $WmiExporterLocalDir = @HomeDrive & "\Brauckhoff\wmi_exporter\" ;@SCRIPTDIR?
Global Const $WmiExporterLocalPath = $WmiExporterLocalDir & $WmiExporterLocalFileName
Global $WmiExporterLocalExists = FileExists($WmiExporterLocalPath)

Global Const $WmiExporterGlobalNetSetupFileName = "wmi_exporter.exe"
Global Const $WmiExporterGlobalNetSetupDir = $IniGlobalNetDir & "wmi_exporter\"
Global Const $WmiExporterGlobalNetSetupPath = $WmiExporterGlobalNetSetupDir & $WmiExporterGlobalNetSetupFileName
Global Const $WmiExporterGlobalNetSetupExists = FileExists($WmiExporterGlobalNetSetupPath)

Global Const $WmiExporterCollectorsEnabled = "cs,logical_disk,memory,net,os,process,service,system,textfile"

Global Const $WmiExporterCollectorTextfileDir = $WmiExporterLocalDir & "textfile_inputs\"

Global Const $WmiExporterParams = '' _
         & ' --log.format logger:eventlog?name=wmi_exporter' _
         & ' --collectors.enabled ' & $WmiExporterCollectorsEnabled _
         & ' --telemetry.addr :9182 ' _
         & ' --collector.textfile.directory ' & $WmiExporterCollectorTextfileDir
ConsoleLog($WmiExporterParams)
#EndRegion Globals Prometheus
#Region
_Singleton("akk")

ConsoleWrite(@CRLF & "akk.exe läuft")
ConsoleWrite(@CRLF & $SpawnPath)
ConsoleWrite(@CRLF & $KPSInfoPath)
ConsoleWrite(@CRLF & "werden überwacht" & @CRLF)

GetGlobalConfig()

WriteLogStartup()

SetupWmiExporter()

;~ CleaningDownloads()

;~ CheckHomeDriveSpaceFree()

;~ Sleep($T1)

While 42
    Sleep($T2)
    Check()
WEnd

Func GetGlobalConfig()
    If $IniGlobalNetExists Then
        FileCopy($IniGlobalNetPath, $IniGlobalPath, $FC_OVERWRITE + $FC_CREATEPATH)
    EndIf
    If FileExists($IniGlobalPath) Then
        $LowSpaceThresholdPerc = IniRead($IniGlobalPath, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
        For $i = 0 To 9 Step 1
            $MailAddresses[$i][0] = IniRead($IniGlobalPath, "FreeSpaceCheck", "Mail" & $i & "Address", "")
            $MailAddresses[$i][1] = IniRead($IniGlobalPath, "FreeSpaceCheck", "Mail" & $i & "Active", 0)
        Next
        $SmtpMailSmtpServer = IniRead($IniGlobalPath, "SmtpMail", "SmtpServer", "")
    EndIf
EndFunc   ;==>GetGlobalConfig

Func WriteLogStartup()
    Local Const $DelimItem = $ArrayDelimItem
    IniWrite($IniGlobalNetLogPath, "IPAddress1", @ComputerName, @IPAddress1)

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
#Region
Func Check()
    CheckAndRunProc($SpawnFileName, $SpawnDir, $SpawnPath, $SpawnExists)
    CheckAndRunProc($KPSInfoFileName, $KPSInfoDir, $KPSInfoPath, $KPSInfoExists)
;~     CheckAndRunProc($WmiExporterLocalFileName, $WmiExporterLocalDir, $WmiExporterLocalPath & $WmiExporterParams, $WmiExporterLocalExists)
    CheckAndRunProc($WmiExporterLocalFileName, "", $WmiExporterLocalPath & $WmiExporterParams, $WmiExporterLocalExists)
;~     CheckAndRunProcAs($PowerkatalogFileName, $PowerkatalogDir, $PowerkatalogPath, $PowerkatalogExists, "Administrator", "Brauckhoff", "")
;~     CheckAndRunProc($SHDUpdaterFileName, $SHDUpdaterDir, $SHDUpdaterPath, $SHDUpdaterExists)
EndFunc   ;==>Check

Func CheckAndRunProc($Name, $Dir, $Path, $Exists)
    If $Exists And Not ProcessExists($Name) Then
        ConsoleLog($Name & " wird gestartet")
        Run($Path, $Dir)
    EndIf
EndFunc   ;==>CheckAndRunProc

Func CheckAndRunProcAs($Name, $Dir, $Path, $Exists, $UserName, $Domain, $Password)
    If $Exists And Not ProcessExists($Name) Then
        ConsoleLog($Name & " wird gestartet als " & $UserName & " in " & $Domain & " mit Network credentials only")
        RunAs($UserName, $Domain, $Password, $RUN_LOGON_NETWORK, $Path, $Dir)
    EndIf
EndFunc   ;==>CheckAndRunProcAs

Func ConsoleLog($Text)
    ConsoleWrite(@CRLF & $Text)
    TrayTip("", $Text, $TrayTipTimeout, $TIP_ICONEXCLAMATION)
EndFunc   ;==>ConsoleLog
#EndRegion
#Region
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
        If MsgBox($MB_YESNO + $MB_ICONWARNING + $MB_SYSTEMMODAL, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $Warning) = $IDYES Then
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
    Return IniRead($IniLocalPath, "Downloads", "LastCleaningDate", "Default Value")
EndFunc   ;==>GetDownloadsLastCleaningDate
#EndRegion
#Region
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
    Local Const $sSerial = DriveGetSerial(@HomeDrive & "\")
    Local Const $iFreeSpace = DriveSpaceFree(@HomeDrive & "\")
    Local Const $iTotalSpace = DriveSpaceTotal(@HomeDrive & "\")
    Local Const $iFreeSpacePerc = ($iFreeSpace / $iTotalSpace) * 100
    If $iFreeSpacePerc < $LowSpaceThresholdPerc Then
        For $i = 0 To 9 Step 1
            If $MailAddresses[$i][0] <> "" And $MailAddresses[$i][1] = 1 Then
                SendMailLowSpace($MailAddresses[$i][0], Round($iFreeSpacePerc, 2), $sLabel, $sSerial, $iFreeSpace, $iTotalSpace)
                Sleep(3000)
            EndIf
        Next
    EndIf
EndFunc   ;==>CheckHomeDriveSpaceFree

Func SendMailLowSpace($sToAddress, $iFreeSpacePerc, $sLabel, $sSerial, $iFreeSpace, $iTotalSpace)
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
#EndRegion
#Region WMI Exporter
Func SetupWmiExporter()
	ProcessClose($WmiExporterLocalFileName)
;~     Local Const $WmiInstallerPath = @TempDir & "\" & $WmiExporterGlobalNetSetupFileName
    If Not $WmiExporterLocalExists Then
        If FileCopy($WmiExporterGlobalNetSetupPath, $WmiExporterLocalPath, $FC_OVERWRITE + $FC_CREATEPATH) Then
            $WmiExporterLocalExists = FileExists($WmiExporterLocalPath)
;~             Run($WmiExporterLocalPath & " --log.format logger:eventlog?name=wmi_exporter --collectors.enabled " & $WmiExporterCollectorsEnabled & " --telemetry.addr :9182  --collector.textfile.directory " & $WmiExporterCollectorTextfileDir, "")
        EndIf
    EndIf
	If Not FileExists($WmiExporterCollectorTextfileDir) Then
		DirCreate($WmiExporterCollectorTextfileDir)
	EndIf
EndFunc   ;==>SetupWmiExporter
#EndRegion WMI Exporter
