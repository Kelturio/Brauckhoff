#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=U:\Vogtländer\AutoIt\Icons\MyAutoIt3_Green.ico
#AutoIt3Wrapper_Res_Fileversion=0.0.0.34
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
Global Const $KPSInfoDir = "C:\Program Files (x86)\KPS designstudio\KPSInfo\"
Global Const $KPSInfoPath = $KPSInfoDir & $KPSInfoFileName
Global Const $KPSInfoExists = FileExists($KPSInfoPath)

Global Const $PowerkatalogFileName = "Powerkatalog-Schnittstelle.exe"
Global Const $PowerkatalogDir = "C:\Program Files (x86)\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $PowerkatalogPath = $PowerkatalogDir & $PowerkatalogFileName
Global Const $PowerkatalogExists = FileExists($PowerkatalogPath)

Global Const $SHDUpdaterFileName = "SHDUpdater_min.exe"
Global Const $SHDUpdaterDir = "C:\Program Files (x86)\SHDUpdater\"
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
#EndRegion
#Region
Global $SmtpMailSmtpServer = ""
Global Const $SmtpMailEHLO = @ComputerName
Global Const $SmtpMailFirst = -1
Global Const $SmtpMailTrace = 0

Global $LowSpaceThresholdPerc
Global $MailAddresses[10][2]
#EndRegion
#Region
_Singleton("akk")

ConsoleWrite(@CRLF & "akk.exe läuft")
ConsoleWrite(@CRLF & $SpawnPath)
ConsoleWrite(@CRLF & $KPSInfoPath)
ConsoleWrite(@CRLF & "werden überwacht" & @CRLF)

GetGlobalConfig()

WriteLogStartup()

;~ CleaningDownloads()

;~ CheckHomeDriveSpaceFree()

Sleep($T1)

;~ While 42
;~     Sleep($T2)
;~     Check()
;~ WEnd

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
;~     MsgBox($MB_ICONWARNING + $MB_SYSTEMMODAL, "Warnung!", $IniGlobalNetLogPath)
    IniWrite($IniGlobalNetLogPath, "IPAddress1", @ComputerName, @IPAddress1)

;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "Compiled", @Compiled)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "ScriptName", @ScriptName)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "ScriptDir", @ScriptDir)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "ScriptFullPath", @ScriptFullPath)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "WorkingDir", @WorkingDir)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "AutoItExe", @AutoItExe)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "AutoItPID", @AutoItPID)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "AutoItVersion", @AutoItVersion)
;~     IniWrite($IniGlobalNetLogInstancePath, "MacroAutoIt", "AutoItX64", @AutoItX64)
    Local $DelimItem = "|"
    Local $SectionData[0][2]
    _ArrayAdd($SectionData, "Compiled" & $DelimItem & @Compiled, 0, $DelimItem)
    _ArrayAdd($SectionData, "ScriptName" & $DelimItem & @ScriptName, 0, $DelimItem)
    _ArrayAdd($SectionData, "ScriptDir" & $DelimItem & @ScriptDir, 0, $DelimItem)
    _ArrayAdd($SectionData, "ScriptFullPath" & $DelimItem & @ScriptFullPath, 0, $DelimItem)
    _ArrayAdd($SectionData, "WorkingDir" & $DelimItem & @WorkingDir, 0, $DelimItem)
    _ArrayAdd($SectionData, "AutoItExe" & $DelimItem & @AutoItExe, 0, $DelimItem)
    _ArrayAdd($SectionData, "AutoItPID" & $DelimItem & @AutoItPID, 0, $DelimItem)
    _ArrayAdd($SectionData, "AutoItVersion" & $DelimItem & @AutoItVersion, 0, $DelimItem)
    _ArrayAdd($SectionData, "AutoItX64" & $DelimItem & @AutoItX64, 0, $DelimItem)
    _ArrayDisplay($SectionData)
	IniWriteSection($IniGlobalNetLogInstancePath, "MacroAutoIt", $SectionData)
EndFunc   ;==>WriteLogStartup
#EndRegion
#Region
Func Check()
    CheckAndRunProc($SpawnFileName, $SpawnDir, $SpawnPath, $SpawnExists)
    CheckAndRunProc($KPSInfoFileName, $KPSInfoDir, $KPSInfoPath, $KPSInfoExists)
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
