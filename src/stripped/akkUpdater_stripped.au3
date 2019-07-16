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
Global Const $v = "\\172.16.128.4\edv\Gerrit\"
Global Const $w = $v & ""
Global Const $x = FileExists($w)
Global Const $y = $v & "akk\"
Global Const $0z = $y & ""
Global Const $10 = FileExists($0z)
Global Const $11 = @ScriptDir & "\"
Global Const $12 = $11 & "akk.exe"
Global $13 = FileExists($12)
Global Const $14 = $v
Global Const $15 = $14 & "akk.exe"
Global Const $16 = FileExists($15)
Global Const $17 = $11
Global Const $18 = $17 & "akk.ini"
Global Const $19 = FileExists($18)
Global $1a
Global $1b = ""
Global Const $1c = $11 & "log\"
Global $1d = $1c & $1b
Global $1e = FileExists($1d)
Global $1f = ""
Global Const $1g = $y & "log\" & @ComputerName & "\"
Global $1h = $1g & $1f
Global $1i = FileExists($1h)
Global $1j = "akkGlobal.log"
Global Const $1k = $y & "log\"
Global $1l = $1k & $1j
Global $1m = FileExists($1l)
_2g("akkUpdater")
_2n("akkUpdater.exe gestartet")
Sleep(5e3)
_2p()
_2o()
While 42
_2q()
Sleep(60e3)
WEnd
Func _2m($1n, $1o, $1p, $1q, $1r = @SW_HIDE)
If $1q And Not ProcessExists($1n) Then
_2n($1n & " wird gestartet")
Return Run($1p, $1o, $1r)
EndIf
Return 0
EndFunc
Func _2n($1s)
ConsoleWrite(@CRLF & $1s)
If @OSArch <> "WIN_10" Then TrayTip("", $1s, 15, 2)
_1s($1d, $1s)
_1s($1h, $1s)
_1s($1l, $1s)
EndFunc
Func _2o()
$1b = StringFormat("%04s", $1a) & ".log"
$1d = $1c & $1b
$1h = $1g & $1b
If _1i($1d) > 1e3 Then
$1a += 1
IniWrite($18, "LogFile", "ID", $1a)
EndIf
IniWrite($18, "LogFile", "LogPath", $1d)
IniWrite($18, "LogFile", "LogNetPath", $1h)
EndFunc
Func _2p()
$1a = IniRead($18, "LogFile", "ID", "NULL")
If $1a = "NULL" Then
IniWrite($18, "LogFile", "ID", 0)
$1a = 0
EndIf
EndFunc
Func _2q()
ProcessClose("akk.exe")
Sleep(5e3)
If Not ProcessExists("akk.exe") Then
$13 = FileCopy($15, $12, 1 + 8)
If _2m("akk.exe", $11, $12, $13) Then
Exit
Else
_2n("Error CheckAndRunProc")
EndIf
EndIf
EndFunc
