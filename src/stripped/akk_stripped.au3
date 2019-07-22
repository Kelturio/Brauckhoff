Global Enum $0, $1, $2, $3, $4, $5, $6
Global Const $7 = "struct;word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds;endstruct"
Global Const $8 = "struct;long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias;endstruct"
Global Const $9 = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $a = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $b = _1v()
Func _1v()
Local $c = DllStructCreate($a)
DllStructSetData($c, 1, DllStructGetSize($c))
Local $d = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $c)
If @error Or Not $d[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($c, 2), -8), DllStructGetData($c, 3))
EndFunc
Global Const $e = 0x007F
Func _2e($f = 0, $g = 0, $h = 0, $i = '')
If Not $f Then $f = 0x0400
Local $j = 'wstr'
If Not StringStripWS($i, 1 + 2) Then
$j = 'ptr'
$i = 0
EndIf
Local $d = DllCall('kernel32.dll', 'int', 'GetDateFormatW', 'dword', $f, 'dword', $h, 'struct*', $g, $j, $i, 'wstr', '', 'int', 2048)
If @error Or Not $d[0] Then Return SetError(@error, @extended, '')
Return $d[5]
EndFunc
Func _32($k, $l = Default)
Local Const $m = 128
If $l = Default Then $l = 0
$k = Int($k)
If $k < 1 Or $k > 7 Then Return SetError(1, 0, "")
Local $g = DllStructCreate($7)
DllStructSetData($g, "Year", BitAND($l, $m) ? 2007 : 2006)
DllStructSetData($g, "Month", 1)
DllStructSetData($g, "Day", $k)
Return _2e(BitAND($l, 2) ? 0x0400 : $e, $g, 0, BitAND($l, 1) ? "ddd" : "dddd")
EndFunc
Func _35($n)
If StringIsInt($n) Then
Select
Case Mod($n, 4) = 0 And Mod($n, 100) <> 0
Return 1
Case Mod($n, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1, 0, 0)
EndFunc
Func _36($o)
$o = Int($o)
Return $o >= 1 And $o <= 12
EndFunc
Func _37($p)
Local $q[4], $r[4]
_3g($p, $q, $r)
If Not StringIsInt($q[1]) Then Return 0
If Not StringIsInt($q[2]) Then Return 0
If Not StringIsInt($q[3]) Then Return 0
$q[1] = Int($q[1])
$q[2] = Int($q[2])
$q[3] = Int($q[3])
Local $s = _3z($q[1])
If $q[1] < 1000 Or $q[1] > 2999 Then Return 0
If $q[2] < 1 Or $q[2] > 12 Then Return 0
If $q[3] < 1 Or $q[3] > $s[$q[2]] Then Return 0
If $r[0] < 1 Then Return 1
If $r[0] < 2 Then Return 0
If $r[0] = 2 Then $r[3] = "00"
If Not StringIsInt($r[1]) Then Return 0
If Not StringIsInt($r[2]) Then Return 0
If Not StringIsInt($r[3]) Then Return 0
$r[1] = Int($r[1])
$r[2] = Int($r[2])
$r[3] = Int($r[3])
If $r[1] < 0 Or $r[1] > 23 Then Return 0
If $r[2] < 0 Or $r[2] > 59 Then Return 0
If $r[3] < 0 Or $r[3] > 59 Then Return 0
Return 1
EndFunc
Func _3g($p, ByRef $t, ByRef $u)
Local $v = StringSplit($p, " T")
If $v[0] > 0 Then $t = StringSplit($v[1], "/-.")
If $v[0] > 1 Then
$u = StringSplit($v[2], ":")
If UBound($u) < 4 Then ReDim $u[4]
Else
Dim $u[4]
EndIf
If UBound($t) < 4 Then ReDim $t[4]
For $w = 1 To 3
If StringIsInt($t[$w]) Then
$t[$w] = Int($t[$w])
Else
$t[$w] = -1
EndIf
If StringIsInt($u[$w]) Then
$u[$w] = Int($u[$w])
Else
$u[$w] = 0
EndIf
Next
Return 1
EndFunc
Func _3j($n, $x, $y)
If Not _37(StringFormat("%04d/%02d/%02d", $n, $x, $y)) Then
Return SetError(1, 0, "")
EndIf
If $x < 3 Then
$x = $x + 12
$n = $n - 1
EndIf
Local $0z = Int($n / 100)
Local $10 = Int($0z / 4)
Local $11 = 2 - $0z + $10
Local $12 = Int(1461 *($n + 4716) / 4)
Local $13 = Int(153 *($x + 1) / 5)
Local $14 = $11 + $y + $12 + $13 - 1524.5
Return $14
EndFunc
Func _3k($15, $l = Default)
If $l = Default Then $l = 0
$15 = Int($15)
If Not _36($15) Then Return SetError(1, 0, "")
Local $g = DllStructCreate($7)
DllStructSetData($g, "Year", @YEAR)
DllStructSetData($g, "Month", $15)
DllStructSetData($g, "Day", 1)
Return _2e(BitAND($l, 2) ? 0x0400 : $e, $g, 0, BitAND($l, 1) ? "MMM" : "MMMM")
EndFunc
Func _3z($n)
Local $16 = [12, 31,(_35($n) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Return $16
EndFunc
Func _40($17)
Local $18 = DllStructCreate($7, $17)
Local $19 = DllStructCreate($7)
DllStructSetData($19, "Month", DllStructGetData($18, "Month"))
DllStructSetData($19, "Day", DllStructGetData($18, "Day"))
DllStructSetData($19, "Year", DllStructGetData($18, "Year"))
DllStructSetData($19, "Hour", DllStructGetData($18, "Hour"))
DllStructSetData($19, "Minute", DllStructGetData($18, "Minute"))
DllStructSetData($19, "Second", DllStructGetData($18, "Second"))
DllStructSetData($19, "MSeconds", DllStructGetData($18, "MSeconds"))
DllStructSetData($19, "DOW", DllStructGetData($18, "DOW"))
Return $19
EndFunc
Func _4n()
Local $1a = DllStructCreate($8)
Local $1b = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "struct*", $1a)
If @error Or $1b[0] = -1 Then Return SetError(@error, @extended, 0)
Local $1c[8]
$1c[0] = $1b[0]
$1c[1] = DllStructGetData($1a, "Bias")
$1c[2] = DllStructGetData($1a, "StdName")
$1c[3] = _40(DllStructGetPtr($1a, "StdDate"))
$1c[4] = DllStructGetData($1a, "StdBias")
$1c[5] = DllStructGetData($1a, "DayName")
$1c[6] = _40(DllStructGetPtr($1a, "DayDate"))
$1c[7] = DllStructGetData($1a, "DayBias")
Return $1c
EndFunc
Global $1d
Func _gg($1e)
Local $1b = DllCall("advapi32.dll", "bool", "CloseEventLog", "handle", $1e)
If @error Then Return SetError(@error, @extended, False)
Return $1b[0] <> 0
EndFunc
Func _gh($1e)
Local $1b = DllCall("advapi32.dll", "bool", "GetNumberOfEventLogRecords", "handle", $1e, "dword*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $1b[0] = 0 Then Return -1
Return $1b[2]
EndFunc
Func _gu($1e)
Local $1b = DllCall("advapi32.dll", "bool", "GetEventLogInformation", "handle", $1e, "dword", 0, "dword*", 0, "dword", 4, "dword*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $1b[3] <> 0
EndFunc
Func _gw($1e)
Local $1b = DllCall("advapi32.dll", "bool", "GetOldestEventLogRecord", "handle", $1e, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return $1b[2]
EndFunc
Func _gx($1f, $1g)
$1d = $1g
Local $1b = DllCall("advapi32.dll", "handle", "OpenEventLogW", "wstr", $1f, "wstr", $1g)
If @error Then Return SetError(@error, @extended, 0)
Return $1b[0]
EndFunc
Func _h3()
Local $1h = DllStructCreate("uint;dword")
DllStructSetData($1h, 1, DllStructGetSize($1h))
Local $1b = DllCall("user32.dll", "bool", "GetLastInputInfo", "struct*", $1h)
If @error Or $1b[0] = 0 Then Return SetError(@error, @extended, 0)
Local $1i = DllCall("kernel32.dll", "dword", "GetTickCount")
If @error Or Not $1b[0] Then Return SetError(@error, @extended, 0)
Local $1j = $1i[0] - DllStructGetData($1h, 2)
If $1j < 0 Then Return SetExtended(1, $1i[0])
Return $1j
EndFunc
Global $1k[11]
Global Const $1l = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($1m, $1n, $1o)
If $1k[3] = $1k[4] Then
If Not $1k[7] Then
$1k[5] *= -1
$1k[7] = 1
EndIf
Else
$1k[7] = 1
EndIf
$1k[6] = $1k[3]
Local $1p = _hl($1o, $1m, $1k[3])
Local $1q = _hl($1o, $1n, $1k[3])
If $1k[8] = 1 Then
If(StringIsFloat($1p) Or StringIsInt($1p)) Then $1p = Number($1p)
If(StringIsFloat($1q) Or StringIsInt($1q)) Then $1q = Number($1q)
EndIf
Local $1r
If $1k[8] < 2 Then
$1r = 0
If $1p < $1q Then
$1r = -1
ElseIf $1p > $1q Then
$1r = 1
EndIf
Else
$1r = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $1p, 'wstr', $1q)[0]
EndIf
$1r = $1r * $1k[5]
Return $1r
EndFunc
Func _hl($1o, $1s, $1t = 0)
Local $1u = DllStructCreate("wchar Text[4096]")
Local $1v = DllStructGetPtr($1u)
Local $1w = DllStructCreate($1l)
DllStructSetData($1w, "SubItem", $1t)
DllStructSetData($1w, "TextMax", 4096)
DllStructSetData($1w, "Text", $1v)
If IsHWnd($1o) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $1o, "uint", 0x1073, "wparam", $1s, "struct*", $1w)
Else
Local $1x = DllStructGetPtr($1w)
GUICtrlSendMsg($1o, 0x1073, $1s, $1x)
EndIf
Return DllStructGetData($1u, "Text")
EndFunc
Global Enum $1y, $1z, $20, $21, $22, $23, $24, $25
Func _hp(ByRef $26, $27, $28 = 0, $29 = "|", $2a = @CRLF, $2b = $1y)
If $28 = Default Then $28 = 0
If $29 = Default Then $29 = "|"
If $2a = Default Then $2a = @CRLF
If $2b = Default Then $2b = $1y
If Not IsArray($26) Then Return SetError(1, 0, -1)
Local $2c = UBound($26, 1)
Local $2d = 0
Switch $2b
Case $20
$2d = Int
Case $21
$2d = Number
Case $22
$2d = Ptr
Case $23
$2d = Hwnd
Case $24
$2d = String
Case $25
$2d = "Boolean"
EndSwitch
Switch UBound($26, 0)
Case 1
If $2b = $1z Then
ReDim $26[$2c + 1]
$26[$2c] = $27
Return $2c
EndIf
If IsArray($27) Then
If UBound($27, 0) <> 1 Then Return SetError(5, 0, -1)
$2d = 0
Else
Local $2e = StringSplit($27, $29, 2 + 1)
If UBound($2e, 1) = 1 Then
$2e[0] = $27
EndIf
$27 = $2e
EndIf
Local $2f = UBound($27, 1)
ReDim $26[$2c + $2f]
For $2g = 0 To $2f - 1
If String($2d) = "Boolean" Then
Switch $27[$2g]
Case "True", "1"
$26[$2c + $2g] = True
Case "False", "0", ""
$26[$2c + $2g] = False
EndSwitch
ElseIf IsFunc($2d) Then
$26[$2c + $2g] = $2d($27[$2g])
Else
$26[$2c + $2g] = $27[$2g]
EndIf
Next
Return $2c + $2f - 1
Case 2
Local $2h = UBound($26, 2)
If $28 < 0 Or $28 > $2h - 1 Then Return SetError(4, 0, -1)
Local $2i, $2j = 0, $2k
If IsArray($27) Then
If UBound($27, 0) <> 2 Then Return SetError(5, 0, -1)
$2i = UBound($27, 1)
$2j = UBound($27, 2)
$2d = 0
Else
Local $2l = StringSplit($27, $2a, 2 + 1)
$2i = UBound($2l, 1)
Local $2e[$2i][0], $2m
For $2g = 0 To $2i - 1
$2m = StringSplit($2l[$2g], $29, 2 + 1)
$2k = UBound($2m)
If $2k > $2j Then
$2j = $2k
ReDim $2e[$2i][$2j]
EndIf
For $2n = 0 To $2k - 1
$2e[$2g][$2n] = $2m[$2n]
Next
Next
$27 = $2e
EndIf
If UBound($27, 2) + $28 > UBound($26, 2) Then Return SetError(3, 0, -1)
ReDim $26[$2c + $2i][$2h]
For $2o = 0 To $2i - 1
For $2n = 0 To $2h - 1
If $2n < $28 Then
$26[$2o + $2c][$2n] = ""
ElseIf $2n - $28 > $2j - 1 Then
$26[$2o + $2c][$2n] = ""
Else
If String($2d) = "Boolean" Then
Switch $27[$2o][$2n - $28]
Case "True", "1"
$26[$2o + $2c][$2n] = True
Case "False", "0", ""
$26[$2o + $2c][$2n] = False
EndSwitch
ElseIf IsFunc($2d) Then
$26[$2o + $2c][$2n] = $2d($27[$2o][$2n - $28])
Else
$26[$2o + $2c][$2n] = $27[$2o][$2n - $28]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($26, 1) - 1
EndFunc
Func _ig(Const ByRef $26, $2p = "|", $2q = -1, $2r = -1, $2a = @CRLF, $2s = -1, $2t = -1)
If $2p = Default Then $2p = "|"
If $2a = Default Then $2a = @CRLF
If $2q = Default Then $2q = -1
If $2r = Default Then $2r = -1
If $2s = Default Then $2s = -1
If $2t = Default Then $2t = -1
If Not IsArray($26) Then Return SetError(1, 0, -1)
Local $2c = UBound($26, 1) - 1
If $2q = -1 Then $2q = 0
If $2r = -1 Then $2r = $2c
If $2q < -1 Or $2r < -1 Then Return SetError(3, 0, -1)
If $2q > $2c Or $2r > $2c Then Return SetError(3, 0, "")
If $2q > $2r Then Return SetError(4, 0, -1)
Local $2u = ""
Switch UBound($26, 0)
Case 1
For $2g = $2q To $2r
$2u &= $26[$2g] & $2p
Next
Return StringTrimRight($2u, StringLen($2p))
Case 2
Local $2h = UBound($26, 2) - 1
If $2s = -1 Then $2s = 0
If $2t = -1 Then $2t = $2h
If $2s < -1 Or $2t < -1 Then Return SetError(5, 0, -1)
If $2s > $2h Or $2t > $2h Then Return SetError(5, 0, -1)
If $2s > $2t Then Return SetError(6, 0, -1)
For $2g = $2q To $2r
For $2n = $2s To $2t
$2u &= $26[$2g][$2n] & $2p
Next
$2u = StringTrimRight($2u, StringLen($2p)) & $2a
Next
Return StringTrimRight($2u, StringLen($2a))
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _it($2v)
FileReadToArray($2v)
If @error Then Return SetError(@error, @extended, 0)
Return @extended
EndFunc
Func _iv($2v, $2w = "*", $2x = 0, $2y = False)
Local $2z = "|", $30 = "", $31 = "", $32 = ""
$2v = StringRegExpReplace($2v, "[\\/]+$", "") & "\"
If $2x = Default Then $2x = 0
If $2y Then $32 = $2v
If $2w = Default Then $2w = "*"
If Not FileExists($2v) Then Return SetError(1, 0, 0)
If StringRegExp($2w, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
If Not($2x = 0 Or $2x = 1 Or $2x = 2) Then Return SetError(3, 0, 0)
Local $33 = FileFindFirstFile($2v & $2w)
If @error Then Return SetError(4, 0, 0)
While 1
$31 = FileFindNextFile($33)
If @error Then ExitLoop
If($2x + @extended = 2) Then ContinueLoop
$30 &= $2z & $32 & $31
WEnd
FileClose($33)
If $30 = "" Then Return SetError(4, 0, 0)
Return StringSplit(StringTrimLeft($30, 1), $2z)
EndFunc
Func _j1($2v, ByRef $34, $h = 1, $2z = "")
$34 = 0
If $h = Default Then $h = 1
If $2z = Default Then $2z = ""
Local $35 = True
If BitAND($h, 2) Then
$35 = False
$h -= 2
EndIf
Local $36 = 0
If BitAND($h, 4) Then
$36 = 1
$h -= 4
EndIf
Local $37 = 0
If $h <> 1 Then
$h = 0
$37 = 2
EndIf
If $2z Then
Local $38 = FileReadToArray($2v)
If @error Then Return SetError(@error, 0, 0)
Local $2c = UBound($38) + $h
If $35 Then
Local $2h = UBound(StringSplit($38[0], $2z, $36 + 2))
Local $39[$2c][$2h]
Local $3a, $3b
For $2g = 0 To $2c - $h - 1
$3b = StringSplit($38[$2g], $2z, $36 + 2)
$3a = UBound($3b)
If $3a <> $2h Then
Return SetError(3, 0, 0)
EndIf
For $2n = 0 To $3a - 1
$39[$2g + $h][$2n] = $3b[$2n]
Next
Next
If $2h < 2 Then Return SetError(4, 0, 0)
If $h Then
$39[0][0] = $2c - $h
$39[0][1] = $2h
EndIf
Else
Local $39[$2c]
For $2g = 0 To $2c - $h - 1
$39[$2g + $h] = StringSplit($38[$2g], $2z, $36 + $37)
Next
If $h Then
$39[0] = $2c - $h
EndIf
EndIf
$34 = $39
Else
If $h Then
Local $3c = FileOpen($2v, 0)
If $3c = -1 Then Return SetError(1, 0, 0)
Local $3d = FileRead($3c)
FileClose($3c)
If StringLen($3d) Then
$34 = StringRegExp(@LF & $3d, "(?|(\N+)\z|(\N*)(?:\R))", 3)
$34[0] = UBound($34) - 1
Else
Return SetError(2, 0, 0)
EndIf
Else
$34 = FileReadToArray($2v)
If @error Then
$34 = 0
Return SetError(@error, 0, 0)
EndIf
EndIf
EndIf
Return 1
EndFunc
Func _j2($2v, Const ByRef $26, $3e = Default, $3f = Default, $2z = "|")
Local $3g = 0
If Not IsArray($26) Then Return SetError(2, 0, $3g)
Local $3h = UBound($26, 0)
If $3h > 2 Then Return SetError(4, 0, 0)
Local $3i = UBound($26) - 1
If $3f = Default Or $3f > $3i Then $3f = $3i
If $3e < 0 Or $3e = Default Then $3e = 0
If $3e > $3f Then Return SetError(5, 0, $3g)
If $2z = Default Then $2z = "|"
Local $3c = $2v
If IsString($2v) Then
$3c = FileOpen($2v, 2)
If $3c = -1 Then Return SetError(1, 0, $3g)
EndIf
Local $3j = 0
$3g = 1
Switch $3h
Case 1
For $2g = $3e To $3f
If Not FileWrite($3c, $26[$2g] & @CRLF) Then
$3j = 3
$3g = 0
ExitLoop
EndIf
Next
Case 2
Local $3k = ""
For $2g = $3e To $3f
$3k = $26[$2g][0]
For $2n = 1 To UBound($26, 2) - 1
$3k &= $2z & $26[$2g][$2n]
Next
If Not FileWrite($3c, $3k & @CRLF) Then
$3j = 3
$3g = 0
ExitLoop
EndIf
Next
EndSwitch
If IsString($2v) Then FileClose($3c)
Return SetError($3j, 0, $3g)
EndFunc
Func _j3($3l, $3m, $2x = -1)
Local $3n = 1
Local $3o = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " : " & $3m
If $2x = Default Then $2x = -1
If $2x <> -1 Then
$3n = 2
$3o &= @CRLF & FileRead($3l)
EndIf
Local $3c = $3l
If IsString($3l) Then $3c = FileOpen($3l, $3n)
If $3c = -1 Then Return SetError(1, 0, 0)
Local $3g = FileWriteLine($3c, $3o)
If IsString($3l) Then $3g = FileClose($3c)
If $3g <= 0 Then Return SetError(2, $3g, 0)
Return $3g
EndFunc
Func _jf($3p, $2x = 0)
Local Const $3q = 183
Local Const $3r = 1
Local $3s = 0
If BitAND($2x, 2) Then
Local $3t = DllStructCreate("byte;byte;word;ptr[4]")
Local $d = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $3t, "dword", $3r)
If @error Then Return SetError(@error, @extended, 0)
If $d[0] Then
$d = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $3t, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $d[0] Then
$3s = DllStructCreate($9)
DllStructSetData($3s, 1, DllStructGetSize($3s))
DllStructSetData($3s, 2, DllStructGetPtr($3t))
DllStructSetData($3s, 3, 0)
EndIf
EndIf
EndIf
Local $3u = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $3s, "bool", 1, "wstr", $3p)
If @error Then Return SetError(@error, @extended, 0)
Local $3v = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $3v[0] = $3q Then
If BitAND($2x, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $3u[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($3v[0], $3v[0], 0)
Else
Exit -1
EndIf
EndIf
Return $3u[0]
EndFunc
Func _jp($3w, $3x, $3y, $3z, $40 = "", $41 = "", $42 = "", $43 = "", $44 = 0)
If $3w = "" Or $3y = "" Or $3z = "" Or $3x = "" Or StringLen($3x) > 256 Then Return SetError(1, 0, 0)
If $42 = "" Then $42 = @ComputerName
If TCPStartup() = 0 Then Return SetError(2, 0, 0)
Local $45, $46
If StringRegExp($3w, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") Then
$45 = $3w
Else
$45 = TCPNameToIP($3w)
EndIf
If $45 = "" Then
TCPShutdown()
Return SetError(3, 0, 0)
EndIf
Local $47 = TCPConnect($45, 25)
If $47 = -1 Then
TCPShutdown()
Return SetError(4, 0, 0)
EndIf
Local $48[6], $49[6]
$48[0] = "HELO " & $42 & @CRLF
If StringLeft($42, 5) = "EHLO " Then $48[0] = $42 & @CRLF
$49[0] = "250"
$48[1] = "MAIL FROM: <" & $3y & ">" & @CRLF
$49[1] = "250"
$48[2] = "RCPT TO: <" & $3z & ">" & @CRLF
$49[2] = "250"
$48[3] = "DATA" & @CRLF
$49[3] = "354"
Local $1b = _4n()
Local $4a = -$1b[1] / 60
Local $4b = Int($4a)
Local $4c = 0
If $4b <> $4a Then $4c = Abs($4a - $4b) * 60
$4a = StringFormat(" (%+.2d%.2d)", $4b, $4c)
$48[4] = "From:" & $3x & "<" & $3y & ">" & @CRLF & "To:" & "<" & $3z & ">" & @CRLF & "Subject:" & $40 & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _32(@WDAY, 1) & ", " & @MDAY & " " & _3k(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $4a & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$49[4] = ""
$48[5] = @CRLF & "." & @CRLF
$49[5] = "250"
If _jr($47, $48[0], $49[0], $44, "220", $43) Then Return SetError(50, 0, 0)
For $46 = 1 To UBound($48) - 2
If _jr($47, $48[$46], $49[$46], $44) Then Return SetError(50 + $46, 0, 0)
Next
For $46 = 0 To UBound($41) - 1
If StringLeft($41[$46], 1) = "." Then $41[$46] = "." & $41[$46]
If _jr($47, $41[$46] & @CRLF, "", $44) Then Return SetError(500 + $46, 0, 0)
Next
$46 = UBound($48) - 1
If _jr($47, $48[$46], $49[$46], $44) Then Return SetError(5000, 0, 0)
TCPCloseSocket($47)
TCPShutdown()
Return 1
EndFunc
Func _jq($4d, $4e = 0)
Local $4f = "SMTP trace"
Local $4g = ControlGetText($4f, "", "Static1")
$4d = StringLeft(StringReplace($4d, @CRLF, ""), 70)
$4g &= @HOUR & ":" & @MIN & ":" & @SEC & " " & $4d & @LF
If WinExists($4f) Then
ControlSetText($4f, "", "Static1", $4g)
Else
SplashTextOn($4f, $4g, 400, 500, 500, 100, 4 + 16, "", 8)
EndIf
If $4e Then Sleep($4e * 1000)
EndFunc
Func _jr($47, $4h, $4i, $44, $4j = "", $43 = "")
Local $4k, $2g, $4l
If $44 Then _jq($4h)
If $4j <> "" Then
If $43 <> -1 Then
If TCPSend($47, $43) = 0 Then
TCPCloseSocket($47)
TCPShutdown()
Return 1
EndIf
EndIf
$4k = ""
$4l = TimerInit()
While StringLeft($4k, StringLen($4j)) <> $4j And TimerDiff($4l) < 45000
$4k = TCPRecv($47, 1000)
If $44 And $4k <> "" Then _jq("intermediate->" & $4k)
WEnd
EndIf
If TCPSend($47, $4h) = 0 Then
TCPCloseSocket($47)
TCPShutdown()
Return 1
EndIf
$4l = TimerInit()
$4k = ""
While $4k = "" And TimerDiff($4l) < 45000
$2g += 1
$4k = TCPRecv($47, 1000)
If $4i = "" Then ExitLoop
WEnd
If $4i <> "" Then
If $44 Then _jq($2g & " <- " & $4k)
If StringLeft($4k, StringLen($4i)) <> $4i Then
TCPCloseSocket($47)
TCPShutdown()
If $44 Then _jq("<-> " & $4i, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Opt('ExpandVarStrings', 1)
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 0)
Global Const $4m = 60 * 5
Global $4n = 0
Global $4o = TimerInit()
Global $4p = $4o
Global $4q = $4o
Global $4r = $4o
Global $4s = $4o
Global $4t = $4o
Global $4u = $4o
Global Const $4v = StringReplace(StringFormat("%-16s", @ComputerName), " ", ".")
Global Const $4w = FileGetVersion(@ScriptFullPath)
Global Const $4x = "ShadowSpawn.exe"
Global Const $4y = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $4z = $4y & $4x
Global Const $50 = FileExists($4z)
Global Const $51 = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $52 = $51 & "KPSInfo.exe"
Global Const $53 = FileExists($52)
Global Const $54 = "Powerkatalog-Schnittstelle.exe"
Global Const $55 = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $56 = $55 & $54
Global Const $57 = FileExists($56)
Global Const $58 = "SHDUpdater_min.exe"
Global Const $59 = @ProgramFilesDir & "\SHDUpdater\"
Global Const $5a = $59 & $58
Global Const $5b = FileExists($5a)
Global Const $5c = "\\172.16.128.4\edv\Gerrit\"
Global Const $5d = $5c & ""
Global Const $5e = FileExists($5d)
Global Const $5f = $5c & "akk\"
Global Const $5g = $5f & ""
Global Const $5h = FileExists($5g)
Global Const $5i = @ScriptDir & "\"
Global Const $5j = $5i & "akk.exe"
Global Const $5k = FileExists($5j)
Global Const $5l = $5c
Global Const $5m = $5l & "akk.exe"
Global Const $5n = FileExists($5m)
Global Const $5o = "akkUpdater.exe"
Global Const $5p = $5i
Global Const $5q = $5p & $5o
Global $5r = FileExists($5q)
Global Const $5s = $5o
Global Const $5t = $5c
Global Const $5u = $5t & $5s
Global Const $5v = FileExists($5u)
Global Const $5w = $5i
Global Const $5x = $5w & "akk.ini"
Global Const $5y = FileExists($5x)
Global Const $5z = "akkGlobalConfig.ini"
Global Const $60 = $5i
Global Const $61 = $60 & $5z
Global $62 = FileExists($61)
Global Const $63 = $5z
Global Const $64 = $5f
Global Const $65 = $64 & $63
Global Const $66 = FileExists($65)
Global Const $67 = "akkGlobalConfigExtended.ini"
Global Const $68 = $60
Global Const $69 = $68 & $67
Global $6a = FileExists($69)
Global Const $6b = $67
Global Const $6c = $5f
Global Const $6d = $6c & $6b
Global Const $6e = FileExists($6d)
Global $6f
Global $6g = ""
Global Const $6h = $5i & "log\"
Global $6i = $6h & $6g
Global $6j = FileExists($6i)
If Not $6j Then DirCreate($6h)
Global $6k = ""
Global Const $6l = $5f & "log\" & @ComputerName & "\"
Global $6m = $6l & $6k
Global $6n = FileExists($6m)
If Not $6n Then DirCreate($6l)
Global $6o = "akkGlobal.log"
Global Const $6p = $5f & "log\"
Global $6q = $6p & $6o
Global $6r = FileExists($6q)
Global $6s = ""
Global Const $6t = $5f & "log\_archive\"
Global $6u = $6t & $6s
Global $6v = FileExists($6u)
If Not $6v Then DirCreate($6t)
Global Const $6w = $5f & "log\"
Global Const $6x = $6w & "akkGlobal.ini"
Global Const $6y = FileExists($6x)
Global Const $6z = "akkGlobalSpawnStats.ini"
Global Const $70 = $5f & "log\"
Global Const $71 = $70 & $6z
Global Const $72 = FileExists($71)
Global Const $73 = $6l
Global Const $74 = $73 & "akkMacro.ini"
Global Const $75 = FileExists($74)
Global Const $76 = $5i & "log\"
Global Const $77 = $76 & "scrape.prom"
Global Const $78 = FileExists($77)
Global Const $79 = $6l
Global Const $7a = $79 & "scrape.prom"
Global Const $7b = FileExists($7a)
Global Const $7c = @UserProfileDir & "\Downloads"
Global Const $7d = $7c & " alt"
Global $7e = ""
Global Const $7f = @ComputerName
Global $7g
Global $7h[10][2]
Global $7i = 0
Global $7j = 1
Global $7k
Global $7l = 0
Global $7m
Global $7n
Global $7o
Global Const $7p = @HomeDrive & "\Brauckhoff\akk\"
Global Const $7q = $7p & "exf.exe"
Global $7r = FileExists($7q)
Global Const $7s = $5f
Global Const $7t = $7s & "exf.exe"
Global Const $7u = FileExists($7t)
Global Const $7v = "wmi_exporter.exe"
Global Const $7w = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $7x = $7w & $7v
Global $7y = FileExists($7x)
Global Const $7z = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $80 = $5f & "wmi_exporter\"
Global Const $81 = $80 & $7z
Global Const $82 = FileExists($81)
Global Const $83 = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $84 = $5f & "wmi_exporter\"
Global Const $85 = $84 & $83
Global Const $86 = FileExists($85)
Global Const $87 = "cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $88 = $7w & "textfile_inputs\"
Global Const $89 = $88
Global Const $8a = $89 & "metadata.prom"
Global $8b = FileExists($8a)
Global $8c
Global $8d[13]
Global $8e
Global Const $8f = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $87 & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $88
_jf("akk")
If @Compiled Then Sleep(5e3)
_jz()
_jx()
_ju("akk.exe läuft")
_ju($4z)
_ju($52)
_ju($7x)
_ju("werden überwacht")
_jw()
_jy()
_jv()
_k2()
_kh()
_kg()
_k7()
_kc()
If @Compiled Then Sleep(5e3)
While 42
Sleep(10)
If(Mod($4n, 300) = 0) Then
If _k1($4p, 15e3 * 1) Then _k4()
If _k1($4q, 60e3 * 5) Then _jw()
If _k1($4r, 60e3 * 5) Then _jx()
If _k1($4s, 60e3 * 5) Then _ke()
If _k1($4t, 10e3 * 1) Then _jv()
If _k1($4u, 10e3 * 1) Then _ki()
EndIf
If(Mod($4n, 500) = 0) Then _kf()
$4n += 1
WEnd
Func _ju($8g)
$8g = StringFormat("%10s", $4n) & " : " & $8g
ConsoleWrite(@CRLF & $8g)
_j3($6i, $8g)
_j3($6m, $8g)
_j3($6q, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $8g)
EndFunc
Func _jv()
Local $1e = _gx("", "Application")
$7m = _gu($1e)
$7n = _gh($1e)
$7o = _gw($1e)
_gg($1e)
EndFunc
Func _jw()
If $66 And Not $62 Then
$62 = FileCopy($65, $61, 1 + 8)
EndIf
If $6e And Not $6a Then
$6a = FileCopy($6d, $69, 1 + 8)
EndIf
If $5v And Not $5r Then
$5r = FileCopy($5u, $5q, 1 + 8)
EndIf
Local $8h = FileGetTime($61, 0, 1)
Local $8i = FileGetTime($65, 0, 1)
If $8h <> $8i Then
$62 = FileCopy($65, $61, 1 + 8)
_ju("Reload Config " & $65)
_jy()
EndIf
Local $8j = FileGetTime($69, 0, 1)
Local $8k = FileGetTime($6d, 0, 1)
If $8j <> $8k Then
$6a = FileCopy($6d, $69, 1 + 8)
_ju("Reload Config Ex" & $6d)
_jy()
_ki()
EndIf
Local $8l = FileGetTime($5q, 0, 1)
Local $8m = FileGetTime($5u, 0, 1)
If $8l <> $8m And @Compiled Then
$5r = FileCopy($5u, $5q, 1 + 8)
_ju("Reload Akk Updater " & $5u)
EndIf
Local $8n = FileGetTime($5j, 0, 1)
Local $8o = FileGetTime($5m, 0, 1)
If $8n <> $8o And @Compiled Then
_k5($5o, $5p, $5q, $5r)
_ju("Reload Akk " & $5m)
EndIf
EndFunc
Func _jx()
$6g = StringFormat("%04s", $6f) & ".log"
$6i = $6h & $6g
$6m = $6l & $6g
If _it($6i) > 1e3 Then
$6f += 1
IniWrite($5x, "LogFile", "ID", $6f)
EndIf
IniWrite($5x, "LogFile", "LogPath", $6i)
IniWrite($5x, "LogFile", "LogNetPath", $6m)
If FileGetSize($6q) / 1024 > 100 Then
Local $8p = $6t & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($6q, $8p, 1 + 8)
EndIf
EndFunc
Func _jy()
If FileExists($61) Then
$7g = IniRead($61, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $2g = 0 To 9 Step 1
$7h[$2g][0] = IniRead($61, "FreeSpaceCheck", "Mail" & $2g & "Address", "")
$7h[$2g][1] = IniRead($61, "FreeSpaceCheck", "Mail" & $2g & "Active", 0)
Next
$7e = IniRead($61, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($69) Then
$8c = IniRead($69, "MetaData", @ComputerName, "NULL")
If $8c = "NULL" Then
IniWrite($6d, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _jz()
$6f = IniRead($5x, "LogFile", "ID", "NULL")
If $6f = "NULL" Then
IniWrite($5x, "LogFile", "ID", 0)
$6f = 0
EndIf
EndFunc
Func _k1(ByRef $8q, $8r)
Local $8s = TimerDiff($8q)
If $8s > $8r Then
$8q = TimerInit()
Return $8s
EndIf
Return 0
EndFunc
Func _k2()
IniWrite($6w & "Global" & ".ini", "@ComputerName", StringReplace(StringFormat("%-16s", @IPAddress1), " ", "."), @ComputerName)
_k3("", "Global", "@IPAddress1", 0, @IPAddress1)
_k3("", "Global", "$AkkVersion", 0, $4w)
_k3("", "Global", "$SpawnExists", 0, $50)
_k3("", "EventLog", "$EventLogFull", 0, $7m)
_k3("", "EventLog", "$EventLogCount", 0, $7n)
_k3("", "EventLog", "$EventLogOldest", 0, $7o)
_k3("", "SpawnStats", $4x & "TimeModified", 0, $7o)
_k3("", "AutoIt", "@Compiled", 0, @Compiled)
_k3("", "AutoIt", "@ScriptName", 0, @ScriptName)
_k3("", "AutoIt", "@ScriptDir", 0, @ScriptDir)
_k3("", "AutoIt", "@ScriptFullPath", 0, @ScriptFullPath)
_k3("", "AutoIt", "@WorkingDir", 0, @WorkingDir)
_k3("", "AutoIt", "@AutoItExe", 0, @AutoItExe)
_k3("", "AutoIt", "@AutoItPID", 0, @AutoItPID)
_k3("", "AutoIt", "@AutoItVersion", 0, @AutoItVersion)
_k3("", "AutoIt", "@AutoItX64", 0, @AutoItX64)
_k3("", "Directory", "@AppDataCommonDir", 0, @AppDataCommonDir)
_k3("", "Directory", "@DesktopCommonDir", 0, @DesktopCommonDir)
_k3("", "Directory", "@DocumentsCommonDir", 0, @DocumentsCommonDir)
_k3("", "Directory", "@FavoritesCommonDir", 0, @FavoritesCommonDir)
_k3("", "Directory", "@ProgramsCommonDir", 0, @ProgramsCommonDir)
_k3("", "Directory", "@StartMenuCommonDir", 0, @StartMenuCommonDir)
_k3("", "Directory", "@StartupCommonDir", 0, @StartupCommonDir)
_k3("", "Directory", "@AppDataDir", 0, @AppDataDir)
_k3("", "Directory", "@LocalAppDataDir", 0, @LocalAppDataDir)
_k3("", "Directory", "@DesktopDir", 0, @DesktopDir)
_k3("", "Directory", "@MyDocumentsDir", 0, @MyDocumentsDir)
_k3("", "Directory", "@FavoritesDir", 0, @FavoritesDir)
_k3("", "Directory", "@ProgramsDir", 0, @ProgramsDir)
_k3("", "Directory", "@StartMenuDir", 0, @StartMenuDir)
_k3("", "Directory", "@UserProfileDir", 0, @UserProfileDir)
_k3("", "Directory", "@HomeDrive", 0, @HomeDrive)
_k3("", "Directory", "@HomePath", 0, @HomePath)
_k3("", "Directory", "@HomeShare", 0, @HomeShare)
_k3("", "Directory", "@LogonDNSDomain", 0, @LogonDNSDomain)
_k3("", "Directory", "@LogonDomain", 0, @LogonDomain)
_k3("", "Directory", "@LogonServer", 0, @LogonServer)
_k3("", "Directory", "@ProgramFilesDir", 0, @ProgramFilesDir)
_k3("", "Directory", "@CommonFilesDir", 0, @CommonFilesDir)
_k3("", "Directory", "@WindowsDir", 0, @WindowsDir)
_k3("", "Directory", "@SystemDir", 0, @SystemDir)
_k3("", "Directory", "@TempDir", 0, @TempDir)
_k3("", "Directory", "@ComSpec", 0, @ComSpec)
_k3("", "SystemInfo", "@CPUArch", 0, @CPUArch)
_k3("", "SystemInfo", "@KBLayout", 0, @KBLayout)
_k3("", "SystemInfo", "@MUILang", 0, @MUILang)
_k3("", "SystemInfo", "@OSArch", 0, @OSArch)
_k3("", "SystemInfo", "@OSLang", 0, @OSLang)
_k3("", "SystemInfo", "@OSType", 0, @OSType)
_k3("", "SystemInfo", "@OSVersion", 0, @OSVersion)
_k3("", "SystemInfo", "@OSBuild", 0, @OSBuild)
_k3("", "SystemInfo", "@OSServicePack", 0, @OSServicePack)
_k3("", "SystemInfo", "@ComputerName", 0, @ComputerName)
_k3("", "SystemInfo", "@UserName", 0, @UserName)
_k3("", "SystemInfo", "@IPAddress1", 0, @IPAddress1)
_k3("", "SystemInfo", "@IPAddress2", 0, @IPAddress2)
_k3("", "SystemInfo", "@IPAddress3", 0, @IPAddress3)
_k3("", "SystemInfo", "@IPAddress4", 0, @IPAddress4)
_k3("", "SystemInfo", "@DesktopHeight", 0, @DesktopHeight)
_k3("", "SystemInfo", "@DesktopWidth", 0, @DesktopWidth)
_k3("", "SystemInfo", "@DesktopDepth", 0, @DesktopDepth)
_k3("", "SystemInfo", "@DesktopRefresh", 0, @DesktopRefresh)
EndFunc
Func _k3($8t, $8u, $8v, $8w, $8x)
If $8t = "" Then
$8t = $6w & $8u & ".ini"
EndIf
IniWrite($8t,($8w ? $8u & $8v : $8v), $4v, $8x)
IniWrite($74, $8u, $8v, $8x)
EndFunc
Func _k4()
_k5($4x, $4y, $4z, $50)
_k5("KPSInfo.exe", $51, $52, $53)
$7k = _k5($7v, $7w, $7x & $8f, $7y)
EndFunc
Func _k5($8y, $8z, $90, $91, $92 = @SW_HIDE)
If $91 And Not ProcessExists($8y) Then
_ju($8y & " wird gestartet")
Return Run($90, $8z, $92)
EndIf
Return 0
EndFunc
Func _k7()
If _k8() Then
DirRemove($7d, 1)
_k9($7c, $7d)
FileDelete($7d & "\Downloads alt.lnk")
FileCreateShortcut($7d, $7c & "\Downloads alt")
IniWrite($5x, "Downloads", "LastCleaningDate", _3j(@YEAR, @MON, @MDAY))
Local Const $93 = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $93, $4m) = 6 Then
ShellExecute($7d)
EndIf
EndIf
EndFunc
Func _k8()
Return(_3j(@YEAR, @MON, @MDAY) - _ka()) >= 14
EndFunc
Func _k9($94, $95)
If FileExists($94) Then
If Not FileExists($95) Then DirCreate($95)
FileMove($94 & "\*.*", $95, 1 + 8)
Local Const $96 = _iv($94, Default, 2, True)
If Not @error Then
For $97 In $96
DirMove($97, $95, 1)
Next
EndIf
EndIf
EndFunc
Func _ka()
Return IniRead($5x, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _kc()
Local Const $98 = DriveGetLabel(@HomeDrive & "\")
Local Const $99 = DriveSpaceFree(@HomeDrive & "\")
Local Const $9a = DriveSpaceTotal(@HomeDrive & "\")
Local Const $9b =($99 / $9a) * 100
If $9b < $7g Then
If(_3j(@YEAR, @MON, @MDAY) - IniRead($5x, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($5x, "FreeSpaceCheck", "LastMailSendDate", _3j(@YEAR, @MON, @MDAY))
For $2g = 0 To 9 Step 1
If $7h[$2g][0] <> "" And $7h[$2g][1] = 1 Then
_ju("Sending Mail to " & $7h[$2g][0])
_kd($7h[$2g][0], Round($9b, 2), $98, $99, $9a)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _kd($3z, $9b, $98, $99, $9a)
Local $3x = "akk.exe (Gerrit)"
Local $3y = "manager@kuechen-brauckhoff.de"
Local $40 = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $9b & "% !"
Local $9c[0]
_hp($9c, "Akk Warnung wenig Speicherplatz auf:")
_hp($9c, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _hp($9c, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _hp($9c, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _hp($9c, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _hp($9c, @IPAddress4)
_hp($9c, $98 & " (" & @HomeDrive & ")")
_hp($9c, Round($99 / 1024, 2) & " GB frei von " & Round($9a / 1024, 2) & " GB")
_hp($9c, $9b & "% frei")
Local $9d = _jp($7e, $3x, $3y, $3z, $40, $9c, $7f, -1, 0)
Local $9e = @error
If $9d = 0 Then
Local Const $93 = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _ig($9c, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $9e & @CRLF
MsgBox(48 + 4096, "Warnung!", $93)
EndIf
EndFunc
Func _ke()
If $7j And ProcessExists($7v) Then
$7i = InetGet("http://localhost:9182/metrics", $77, 1, 1)
$7j = 0
EndIf
EndFunc
Func _kf()
If Not $7j Then
If InetGetInfo($7i, 2) Then
If InetGetInfo($7i, 3) Then
If FileGetSize($77) Then FileCopy($77, $7a, 1 + 8)
Else
FileDelete($77)
_ju("Error ScrapeDownload")
EndIf
InetClose($7i)
$7i = 0
$7j = 1
EndIf
EndIf
EndFunc
Func _kg()
If Not $7r Then
If FileCopy($7t, $7q, 1 + 8) Then
$7r = FileExists($7q)
EndIf
EndIf
EndFunc
Func _kh()
ProcessClose($7v)
If Not $7y Then
Local $9f =(@OSArch = "X64") ? $85 : $81
If FileCopy($9f, $7x, 1 + 8) Then
$7y = FileExists($7x)
EndIf
EndIf
If Not FileExists($88) Then DirCreate($88)
EndFunc
Func _ki()
Local $9g = 'metadata{computername="@ComputerName@",username="@UserName@"'
If $8c <> "NULL" And StringLen($8c) And Not StringIsSpace($8c) Then
$9g &= "," & $8c
EndIf
$9g &= '} 1'
$7l = _h3()
Local $9h = 'akk_idletime_sec{computername="@ComputerName@"} ' & $7l / 1e3
Local $9i = MemGetStats()
Local $9j = 'akk_memstats_load{computername="@ComputerName@"} ' & $9i[$0]
Local $9k = 'akk_memstats_total_physram_gb{computername="@ComputerName@"} ' & Round($9i[$1] / 1024 / 1024, 2)
Local $9l = 'akk_memstats_avail_physram_gb{computername="@ComputerName@"} ' & Round($9i[$2] / 1024 / 1024, 2)
Local $9m = 'akk_memstats_total_pagefile_gb{computername="@ComputerName@"} ' & Round($9i[$3] / 1024 / 1024, 2)
Local $9n = 'akk_memstats_avail_pagefile_gb{computername="@ComputerName@"} ' & Round($9i[$4] / 1024 / 1024, 2)
Local $9o = 'akk_memstats_total_virtual_gb{computername="@ComputerName@"} ' & Round($9i[$5] / 1024 / 1024, 2)
Local $9p = 'akk_memstats_avail_virtual_gb{computername="@ComputerName@"} ' & Round($9i[$6] / 1024 / 1024, 2)
Local $9q = 'akk_eventlog_full{computername="@ComputerName@"} ' &($7m ? 1 : 0)
Local $9r = 'akk_eventlog_count{computername="@ComputerName@"} ' & $7n
Local $9s = 'akk_eventlog_oldest{computername="@ComputerName@"} ' & $7o
$8d[1] = $9g
$8d[2] = $9h
$8d[3] = $9j
$8d[4] = $9k
$8d[5] = $9l
$8d[6] = $9m
$8d[7] = $9n
$8d[8] = $9o
$8d[9] = $9p
$8d[10] = $9q
$8d[11] = $9r
$8d[12] = $9s
$8d[0] = UBound($8d) - 1
_j1($8a, $8e)
If Not _kj($8d, $8e, 3) Then
_j2($8a, $8d, 1)
EndIf
EndFunc
Func _kj(Const ByRef $9t, Const ByRef $9u, $9v = 0)
If Not(IsArray($9t)) Or Not(IsArray($9u)) Then
Return SetError(1, 0, 0)
EndIf
Local $3h = UBound($9t, 0)
If $3h <> UBound($9u, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $9w = UBound($9t, 1)
Local $9x = UBound($9t, 2)
If $9w <> UBound($9u, 1) Or $9x <> UBound($9u, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $9y, $9z
Switch $9v
Case 0
For $2g = 0 To $9w - 1
For $2n = 0 To $9x - 1
If $9t[$2g][$2n] <> $9t[$2g][$2n] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case 1
For $2g = 0 To $9w - 1
For $2n = 0 To $9x - 1
$9y &= $9t[$2g][$2n]
$9z &= $9u[$2g][$2n]
Next
If $9y <> $9z Then
Return SetError(4, 0, 0)
EndIf
Next
Case 2
For $2n = 0 To $9x - 1
For $2g = 0 To $9w - 1
$9y &= $9t[$2g][$2n]
$9z &= $9u[$2g][$2n]
Next
If $9y <> $9z Then
Return SetError(4, 0, 0)
EndIf
Next
Case 3
If _ig($9t) <> _ig($9u) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
