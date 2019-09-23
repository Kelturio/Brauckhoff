#include "Ini.au3"

_IniFileSort(@ScriptDir & "\log\AutoIt.ini")
_IniFileSort(@ScriptDir & "\log\Directory.ini")
_IniFileSort(@ScriptDir & "\log\EventLog.ini")
_IniFileSort(@ScriptDir & "\log\Global.ini")
_IniFileSort(@ScriptDir & "\log\NetPhoneUser.ini")
_IniFileSort(@ScriptDir & "\log\SpawnStats.ini")
_IniFileSort(@ScriptDir & "\log\SystemInfo.ini")
_IniFileSort(@ScriptDir & "\log\Wmi.ini")

Func _IniFileSort($sFilePath)
	Local $hFileOpen = FileOpen($sFilePath, $FO_READ + $FO_ANSI)
	Local $aIni = _IniReadToArray($hFileOpen)
	FileClose($hFileOpen)
	$aIni = _IniArraySort($aIni, 0, 0, 1)
	$hFileOpen = FileOpen($sFilePath, $FO_ANSI + $FO_OVERWRITE)
	Return _IniArrayWriteToFile($hFileOpen, $aIni)
	FileClose($hFileOpen)
EndFunc
