#include <MsgBoxConstants.au3>

Local $aArray[2] = [1, "Example"]
Local $mMap[]
Local $dBinary = Binary("0x00204060")
Local $bBoolean = False
Local $pPtr = Ptr(-1)
Local $hWnd = WinGetHandle(AutoItWinGetTitle())
Local $iInt = 1
Local $fFloat = 2.0
Local $oObject = ObjCreate("Scripting.Dictionary")
Local $sString = "Some text"
Local $tStruct = DllStructCreate("wchar[256]")
Local $vKeyword = Default
Local $fuFunc = ConsoleWrite
Local $fuUserFunc = Test

ConsoleWrite(StringFormat("%05i", @ScriptLineNumber) & @CRLF)

ConsoleWrite("" & _
		"Variable Types" & @CRLF & @CRLF & _
		"$aArray : " & @TAB & @TAB & VarGetType($aArray) & "" & @CRLF & _
        "@ScriptLineNumber : " & @TAB & @TAB & VarGetType(@ScriptLineNumber) & "" & @CRLF & _
		"$mMap : " & @TAB & @TAB & VarGetType($mMap) & "" & @CRLF & _
		"$dBinary : " & @TAB & @TAB & VarGetType($dBinary) & "" & @CRLF & _
		"$bBoolean : " & @TAB & VarGetType($bBoolean) & "" & @CRLF & _
		"$pPtr : " & @TAB & @TAB & VarGetType($pPtr) & "" & @CRLF & _
		"$hWnd : " & @TAB & @TAB & VarGetType($hWnd) & "" & @CRLF & _
		"$iInt : " & @TAB & @TAB & VarGetType($iInt) & "" & @CRLF & _
		"$fFloat : " & @TAB & @TAB & VarGetType($fFloat) & "" & @CRLF & _
		"$oObject : " & @TAB & VarGetType($oObject) & "" & @CRLF & _
		"$sString : " & @TAB & @TAB & VarGetType($sString) & "" & @CRLF & _
		"$tStruct : " & @TAB & @TAB & VarGetType($tStruct) & "" & @CRLF & _
		"$vKeyword : " & @TAB & VarGetType($vKeyword) & "" & @CRLF & _
		"MsgBox : " & @TAB & @TAB & VarGetType(MsgBox) & "" & @CRLF & _
		"$fuFunc : " & @TAB & @TAB & VarGetType($fuFunc) & "" & @CRLF & _
		"Func 'Test' : " & @TAB & VarGetType(Test) & "" & @CRLF & _
		"$fuUserFunc : " & @TAB & VarGetType($fuUserFunc) & "" & @CRLF)

Func Test()
EndFunc   ;==>Test
