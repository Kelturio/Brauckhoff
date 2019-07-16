#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=U:\Vogtländer\AutoIt\Icons\MyAutoIt3_Green.ico
#AutoIt3Wrapper_Res_Fileversion=1.0.0.47
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
Global $IniGlobalExists = FileExists($IniGlobalPath)

Global Const $IniGlobalNetFileName = $IniGlobalFileName
Global Const $IniGlobalNetDir = "\\172.16.128.4\edv\Gerrit\"
Global Const $IniGlobalNetPath = $IniGlobalNetDir & $IniGlobalNetFileName
Global Const $IniGlobalNetExists = FileExists($IniGlobalNetPath)

Global Const $IniGlobalExFileName = "akkGlobalConfigExtended.ini"
Global Const $IniGlobalExDir = $IniGlobalDir
Global Const $IniGlobalExPath = $IniGlobalExDir & $IniGlobalExFileName
Global $IniGlobalExExists = FileExists($IniGlobalExPath)

Global Const $IniGlobalExNetFileName = $IniGlobalExFileName
Global Const $IniGlobalExNetDir = $IniGlobalNetDir
Global Const $IniGlobalExNetPath = $IniGlobalExNetDir & $IniGlobalExNetFileName
Global Const $IniGlobalExNetExists = FileExists($IniGlobalExNetPath)

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
#Region Globals Prometheus WMI Exporter
Global Const $WmiExporterLocalFileName = "wmi_exporter.exe"
Global Const $WmiExporterLocalDir = @HomeDrive & "\Brauckhoff\wmi_exporter\" ;@SCRIPTDIR?
Global Const $WmiExporterLocalPath = $WmiExporterLocalDir & $WmiExporterLocalFileName
Global $WmiExporterLocalExists = FileExists($WmiExporterLocalPath)

Global Const $WmiExporterGlobalNetSetupFileName = "wmi_exporter.exe"
Global Const $WmiExporterGlobalNetSetupDir = $IniGlobalNetDir & "wmi_exporter\"
Global Const $WmiExporterGlobalNetSetupPath = $WmiExporterGlobalNetSetupDir & $WmiExporterGlobalNetSetupFileName
Global Const $WmiExporterGlobalNetSetupExists = FileExists($WmiExporterGlobalNetSetupPath)

Global Const $WmiExporterCollectorsEnabled = "" _
         & "" _ ;~ & "ad" _ ; Active Directory Domain Services
         & "" _ ;~ & ",cpu" _ ; CPU usage
         & "cs" _ ; "Computer System" metrics (system properties, num cpus/total memory)
         & "" _ ;~ & ",dns" _ ; DNS Server
         & "" _ ;~ & ",hyperv" _ ; Hyper-V hosts
         & "" _ ;~ & ",iis" _ ; IIS sites and applications
         & ",logical_disk" _ ; Logical disks, disk I/O
         & ",memory" _ ; Memory usage metrics
         & "" _ ;~ & ",msmq" _ ; MSMQ queues
         & "" _ ;~ & ",mssql" _ ; SQL Server Performance Objects metrics
         & "" _ ;~ & ",netframework_clrexceptions" _ ; .NET Framework CLR Exceptions
         & "" _ ;~ & ",netframework_clrinterop" _ ; .NET Framework Interop Metrics
         & "" _ ;~ & ",netframework_clrjit" _ ; .NET Framework JIT metrics
         & "" _ ;~ & ",netframework_clrloading" _ ; .NET Framework CLR Loading metrics
         & "" _ ;~ & ",netframework_clrlocksandthreads" _ ; .NET Framework locks and metrics threads
         & "" _ ;~ & ",netframework_clrmemory" _ ; .NET Framework Memory metrics
         & "" _ ;~ & ",netframework_clrremoting" _ ; .NET Framework Remoting metrics
         & "" _ ;~ & ",netframework_clrsecurity" _ ; .NET Framework Security Check metrics
         & ",net" _ ; Network interface I/O
         & ",os" _ ; OS metrics (memory, processes, users)
         & ",process" _ ; Per-process metrics
         & ",service" _ ; Service state metrics
         & ",system" _ ; System calls
         & "" _ ;~ & ",tcp" _ ; TCP connections
         & ",textfile" _ ; Read prometheus metrics from a text file
         & "" _ ;~ & ",vmware" ; Performance counters installed by the Vmware Guest agent

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
;~ ConsoleLog($WmiExporterParams)
#EndRegion Globals Prometheus WMI Exporter
#Region
_Singleton("akk")

ConsoleWrite(@CRLF & "akk.exe läuft")
ConsoleWrite(@CRLF & $SpawnPath)
ConsoleWrite(@CRLF & $KPSInfoPath)
ConsoleWrite(@CRLF & $WmiExporterLocalPath)
ConsoleWrite(@CRLF & "werden überwacht" & @CRLF)

GetGlobalConfig()

ReadGlobalConfig()

WriteLogStartup()

SetupWmiExporter()

;~ CleaningDownloads()

;~ CheckHomeDriveSpaceFree()

;~ Sleep($T1)

While 42
    Sleep($T2)
    Check()
	GetGlobalConfig()
WEnd

Func GetGlobalConfig()
    If $IniGlobalNetExists And Not $IniGlobalExists Then
        $IniGlobalExists = FileCopy($IniGlobalNetPath, $IniGlobalPath, $FC_OVERWRITE + $FC_CREATEPATH)
    EndIf
    If $IniGlobalExNetExists And Not $IniGlobalExExists Then
        $IniGlobalExExists = FileCopy($IniGlobalExNetPath, $IniGlobalExPath, $FC_OVERWRITE + $FC_CREATEPATH)
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
        ConsoleLog("Reload Config" & @CRLF & $IniGlobalExNetPath)
        ReadGlobalConfig()
        WriteMetaDataFile()
    EndIf
EndFunc   ;==>GetGlobalConfig

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
    CheckAndRunProc($WmiExporterLocalFileName, $WmiExporterLocalDir, $WmiExporterLocalPath & $WmiExporterParams, $WmiExporterLocalExists)
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
#EndRegion FreeSpaceCheck
#Region WMI Exporter
Func SetupWmiExporter()
    ProcessClose($WmiExporterLocalFileName)
    If Not $WmiExporterLocalExists Then
        If FileCopy($WmiExporterGlobalNetSetupPath, $WmiExporterLocalPath, $FC_OVERWRITE + $FC_CREATEPATH) Then
            $WmiExporterLocalExists = FileExists($WmiExporterLocalPath)
        EndIf
    EndIf
    If Not FileExists($WmiExporterCollectorTextfileDir) Then
        DirCreate($WmiExporterCollectorTextfileDir)
    EndIf
    WriteMetaDataFile()
EndFunc   ;==>SetupWmiExporter

Func WriteMetaDataFile()
    Local $MetaData = 'metadata{computername="' & @ComputerName & '"'
    If $WmiExporterMetadataString <> "NULL" And StringLen($WmiExporterMetadataString) And Not StringIsSpace($WmiExporterMetadataString) Then
        $MetaData &= "," & $WmiExporterMetadataString
    EndIf
    $MetaData &= '} 1'
    $WmiExporterMetadataArray[1] = $MetaData
    $WmiExporterMetadataArray[0] = UBound($WmiExporterMetadataArray) - 1
    _FileReadToArray($WmiExporterMetadataPath, $WmiExporterMetadataArrayRet)
    If Not $WmiExporterMetadataExists Or Not _ArrayCompare($WmiExporterMetadataArray, $WmiExporterMetadataArrayRet, 3) Then
        _FileWriteFromArray($WmiExporterMetadataPath, $WmiExporterMetadataArray, 1)
        ConsoleLog("_FileWriteFromArray" & @CRLF & $WmiExporterMetadataPath)
        $WmiExporterMetadataExists = FileExists($WmiExporterMetadataPath)
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

        Case 0 ; Compare each element
            For $i = 0 To $iRows - 1
                For $j = 0 To $iCols - 1
                    If $aArray1[$i][$j] <> $aArray1[$i][$j] Then
                        Return SetError(4, 0, 0)
                    EndIf
                Next
            Next

        Case 1 ; Convert rows to strings
            For $i = 0 To $iRows - 1
                For $j = 0 To $iCols - 1
                    $sString_1 &= $aArray1[$i][$j]
                    $sString_2 &= $aArray2[$i][$j]
                Next
                If $sString_1 <> $sString_2 Then
                    Return SetError(4, 0, 0)
                EndIf
            Next

        Case 2 ; Convert columnss to strings
            For $j = 0 To $iCols - 1
                For $i = 0 To $iRows - 1
                    $sString_1 &= $aArray1[$i][$j]
                    $sString_2 &= $aArray2[$i][$j]
                Next
                If $sString_1 <> $sString_2 Then
                    Return SetError(4, 0, 0)
                EndIf
            Next

        Case 3 ; Convert whole array to string
            If _ArrayToString($aArray1) <> _ArrayToString($aArray2) Then
                Return SetError(4, 0, 0)
            EndIf

    EndSwitch

    ; Looks as if they match
    Return 1

EndFunc   ;==>_ArrayCompare
#EndRegion UDF
