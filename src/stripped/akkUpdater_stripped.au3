Global $0[11]
Global Const $1 = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($2, $3, $4)
If $0[3] = $0[4] Then
If Not $0[7] Then
$0[5] *= -1
$0[7] = 1
EndIf
Else
$0[7] = 1
EndIf
$0[6] = $0[3]
Local $5 = _a($4, $2, $0[3])
Local $6 = _a($4, $3, $0[3])
If $0[8] = 1 Then
If(StringIsFloat($5) Or StringIsInt($5)) Then $5 = Number($5)
If(StringIsFloat($6) Or StringIsInt($6)) Then $6 = Number($6)
EndIf
Local $7
If $0[8] < 2 Then
$7 = 0
If $5 < $6 Then
$7 = -1
ElseIf $5 > $6 Then
$7 = 1
EndIf
Else
$7 = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $5, 'wstr', $6)[0]
EndIf
$7 = $7 * $0[5]
Return $7
EndFunc
Func _a($4, $8, $9 = 0)
Local $a = DllStructCreate("wchar Text[4096]")
Local $b = DllStructGetPtr($a)
Local $c = DllStructCreate($1)
DllStructSetData($c, "SubItem", $9)
DllStructSetData($c, "TextMax", 4096)
DllStructSetData($c, "Text", $b)
If IsHWnd($4) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $4, "uint", 0x1073, "wparam", $8, "struct*", $c)
Else
Local $d = DllStructGetPtr($c)
GUICtrlSendMsg($4, 0x1073, $8, $d)
EndIf
Return DllStructGetData($a, "Text")
EndFunc
Func _1i($e)
FileReadToArray($e)
If @error Then Return SetError(@error, @extended, 0)
Return @extended
EndFunc
Func _1s($f, $g, $h = -1)
Local $i = 1
Local $j = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " : " & $g
If $h = Default Then $h = -1
If $h <> -1 Then
$i = 2
$j &= @CRLF & FileRead($f)
EndIf
Local $k = $f
If IsString($f) Then $k = FileOpen($f, $i)
If $k = -1 Then Return SetError(1, 0, 0)
Local $l = FileWriteLine($k, $j)
If IsString($f) Then $l = FileClose($k)
If $l <= 0 Then Return SetError(2, $l, 0)
Return $l
EndFunc
Global Const $m = "dword Length;ptr Descriptor;bool InheritHandle"
Func _2g($n, $h = 0)
Local Const $o = 183
Local Const $p = 1
Local $q = 0
If BitAND($h, 2) Then
Local $r = DllStructCreate("byte;byte;word;ptr[4]")
Local $s = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $r, "dword", $p)
If @error Then Return SetError(@error, @extended, 0)
If $s[0] Then
$s = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $r, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $s[0] Then
$q = DllStructCreate($m)
DllStructSetData($q, 1, DllStructGetSize($q))
DllStructSetData($q, 2, DllStructGetPtr($r))
DllStructSetData($q, 3, 0)
EndIf
EndIf
EndIf
Local $t = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $q, "bool", 1, "wstr", $n)
If @error Then Return SetError(@error, @extended, 0)
Local $u = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $u[0] = $o Then
If BitAND($h, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $t[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($u[0], $u[0], 0)
Else
Exit -1
EndIf
EndIf
Return $t[0]
EndFunc
Opt("MustDeclareVars", 1)
Opt("TrayAutoPause", 0)
Global $v = 0
Global Const $w = "\\172.16.128.4\edv\Gerrit\"
Global Const $x = $w & ""
Global Const $y = FileExists($x)
Global Const $0z = $w & "akk\"
Global Const $10 = $0z & ""
Global Const $11 = FileExists($10)
Global Const $12 = @ScriptDir & "\"
Global Const $13 = $12 & "akk.exe"
Global $14 = FileExists($13)
Global Const $15 = $w
Global Const $16 = $15 & "akk.exe"
Global Const $17 = FileExists($16)
Global Const $18 = $12
Global Const $19 = $18 & "akk.ini"
Global Const $1a = FileExists($19)
Global $1b
Global $1c = ""
Global Const $1d = $12 & "log\"
Global $1e = $1d & $1c
Global $1f = FileExists($1e)
Global $1g = ""
Global Const $1h = $0z & "log\" & @ComputerName & "\"
Global $1i = $1h & $1g
Global $1j = FileExists($1i)
Global $1k = "akkGlobal.log"
Global Const $1l = $0z & "log\"
Global $1m = $1l & $1k
Global $1n = FileExists($1m)
Global $1o = ""
Global Const $1p = $0z & "log\_archive\"
Global $1q = $1p & $1o
Global $1r = FileExists($1q)
If Not $1r Then DirCreate($1p)
_2g("akkUpdater")
_2n("akkUpdater.exe gestartet")
Sleep(5e3)
_2p()
_2o()
While 42
_2q()
Sleep(60e3)
$v += 1
WEnd
Func _2m($1s, $1t, $1u, $1v, $1w = @SW_HIDE)
If $1v And Not ProcessExists($1s) Then
_2n($1s & " wird gestartet")
Return Run($1u, $1t, $1w)
EndIf
Return 0
EndFunc
Func _2n($1x)
$1x = "C" & $v & ": " & $1x
ConsoleWrite(@CRLF & $1x)
If @OSArch <> "WIN_10" Then TrayTip("", $1x, 15, 2)
_1s($1e, $1x)
_1s($1i, $1x)
_1s($1m, @UserName & "@" & @ComputerName & " " & $1x)
EndFunc
Func _2o()
$1c = StringFormat("%04s", $1b) & ".log"
$1e = $1d & $1c
$1i = $1h & $1c
If _1i($1e) > 1e3 Then
$1b += 1
IniWrite($19, "LogFile", "ID", $1b)
EndIf
IniWrite($19, "LogFile", "LogPath", $1e)
IniWrite($19, "LogFile", "LogNetPath", $1i)
If FileGetSize($1m) / 1024 > 100 Then
Local $1y = $1p & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($1m, $1y, 1 + 8)
EndIf
EndFunc
Func _2p()
$1b = IniRead($19, "LogFile", "ID", "NULL")
If $1b = "NULL" Then
IniWrite($19, "LogFile", "ID", 0)
$1b = 0
EndIf
EndFunc
Func _2q()
ProcessClose("akk.exe")
Sleep(5e3)
If Not ProcessExists("akk.exe") Then
$14 = FileCopy($16, $13, 1 + 8)
If _2m("akk.exe", $12, $13, $14) Then
Exit
Else
_2n("Error CheckAndRunProc")
EndIf
EndIf
EndFunc
