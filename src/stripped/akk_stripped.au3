Func _1()
Local $0 = DllStructCreate("uint;dword")
DllStructSetData($0, 1, DllStructGetSize($0))
Local $1 = DllCall("user32.dll", "bool", "GetLastInputInfo", "struct*", $0)
If @error Or $1[0] = 0 Then Return SetError(@error, @extended, 0)
Local $2 = DllCall("kernel32.dll", "dword", "GetTickCount")
If @error Or Not $1[0] Then Return SetError(@error, @extended, 0)
Local $3 = $2[0] - DllStructGetData($0, 2)
If $3 < 0 Then Return SetExtended(1, $2[0])
Return $3
EndFunc
Global $4[11]
Global Const $5 = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($6, $7, $8)
If $4[3] = $4[4] Then
If Not $4[7] Then
$4[5] *= -1
$4[7] = 1
EndIf
Else
$4[7] = 1
EndIf
$4[6] = $4[3]
Local $9 = _j($8, $6, $4[3])
Local $a = _j($8, $7, $4[3])
If $4[8] = 1 Then
If(StringIsFloat($9) Or StringIsInt($9)) Then $9 = Number($9)
If(StringIsFloat($a) Or StringIsInt($a)) Then $a = Number($a)
EndIf
Local $b
If $4[8] < 2 Then
$b = 0
If $9 < $a Then
$b = -1
ElseIf $9 > $a Then
$b = 1
EndIf
Else
$b = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $9, 'wstr', $a)[0]
EndIf
$b = $b * $4[5]
Return $b
EndFunc
Func _j($8, $c, $d = 0)
Local $e = DllStructCreate("wchar Text[4096]")
Local $f = DllStructGetPtr($e)
Local $g = DllStructCreate($5)
DllStructSetData($g, "SubItem", $d)
DllStructSetData($g, "TextMax", 4096)
DllStructSetData($g, "Text", $f)
If IsHWnd($8) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $8, "uint", 0x1073, "wparam", $c, "struct*", $g)
Else
Local $h = DllStructGetPtr($g)
GUICtrlSendMsg($8, 0x1073, $c, $h)
EndIf
Return DllStructGetData($e, "Text")
EndFunc
Global Enum $i, $j, $k, $l, $m, $n, $o, $p
Func _n(ByRef $q, $r, $s = 0, $t = "|", $u = @CRLF, $v = $i)
If $s = Default Then $s = 0
If $t = Default Then $t = "|"
If $u = Default Then $u = @CRLF
If $v = Default Then $v = $i
If Not IsArray($q) Then Return SetError(1, 0, -1)
Local $w = UBound($q, 1)
Local $x = 0
Switch $v
Case $k
$x = Int
Case $l
$x = Number
Case $m
$x = Ptr
Case $n
$x = Hwnd
Case $o
$x = String
Case $p
$x = "Boolean"
EndSwitch
Switch UBound($q, 0)
Case 1
If $v = $j Then
ReDim $q[$w + 1]
$q[$w] = $r
Return $w
EndIf
If IsArray($r) Then
If UBound($r, 0) <> 1 Then Return SetError(5, 0, -1)
$x = 0
Else
Local $y = StringSplit($r, $t, 2 + 1)
If UBound($y, 1) = 1 Then
$y[0] = $r
EndIf
$r = $y
EndIf
Local $0z = UBound($r, 1)
ReDim $q[$w + $0z]
For $10 = 0 To $0z - 1
If String($x) = "Boolean" Then
Switch $r[$10]
Case "True", "1"
$q[$w + $10] = True
Case "False", "0", ""
$q[$w + $10] = False
EndSwitch
ElseIf IsFunc($x) Then
$q[$w + $10] = $x($r[$10])
Else
$q[$w + $10] = $r[$10]
EndIf
Next
Return $w + $0z - 1
Case 2
Local $11 = UBound($q, 2)
If $s < 0 Or $s > $11 - 1 Then Return SetError(4, 0, -1)
Local $12, $13 = 0, $14
If IsArray($r) Then
If UBound($r, 0) <> 2 Then Return SetError(5, 0, -1)
$12 = UBound($r, 1)
$13 = UBound($r, 2)
$x = 0
Else
Local $15 = StringSplit($r, $u, 2 + 1)
$12 = UBound($15, 1)
Local $y[$12][0], $16
For $10 = 0 To $12 - 1
$16 = StringSplit($15[$10], $t, 2 + 1)
$14 = UBound($16)
If $14 > $13 Then
$13 = $14
ReDim $y[$12][$13]
EndIf
For $17 = 0 To $14 - 1
$y[$10][$17] = $16[$17]
Next
Next
$r = $y
EndIf
If UBound($r, 2) + $s > UBound($q, 2) Then Return SetError(3, 0, -1)
ReDim $q[$w + $12][$11]
For $18 = 0 To $12 - 1
For $17 = 0 To $11 - 1
If $17 < $s Then
$q[$18 + $w][$17] = ""
ElseIf $17 - $s > $13 - 1 Then
$q[$18 + $w][$17] = ""
Else
If String($x) = "Boolean" Then
Switch $r[$18][$17 - $s]
Case "True", "1"
$q[$18 + $w][$17] = True
Case "False", "0", ""
$q[$18 + $w][$17] = False
EndSwitch
ElseIf IsFunc($x) Then
$q[$18 + $w][$17] = $x($r[$18][$17 - $s])
Else
$q[$18 + $w][$17] = $r[$18][$17 - $s]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($q, 1) - 1
EndFunc
Func _1e(Const ByRef $q, $19 = "|", $1a = -1, $1b = -1, $u = @CRLF, $1c = -1, $1d = -1)
If $19 = Default Then $19 = "|"
If $u = Default Then $u = @CRLF
If $1a = Default Then $1a = -1
If $1b = Default Then $1b = -1
If $1c = Default Then $1c = -1
If $1d = Default Then $1d = -1
If Not IsArray($q) Then Return SetError(1, 0, -1)
Local $w = UBound($q, 1) - 1
If $1a = -1 Then $1a = 0
If $1b = -1 Then $1b = $w
If $1a < -1 Or $1b < -1 Then Return SetError(3, 0, -1)
If $1a > $w Or $1b > $w Then Return SetError(3, 0, "")
If $1a > $1b Then Return SetError(4, 0, -1)
Local $1e = ""
Switch UBound($q, 0)
Case 1
For $10 = $1a To $1b
$1e &= $q[$10] & $19
Next
Return StringTrimRight($1e, StringLen($19))
Case 2
Local $11 = UBound($q, 2) - 1
If $1c = -1 Then $1c = 0
If $1d = -1 Then $1d = $11
If $1c < -1 Or $1d < -1 Then Return SetError(5, 0, -1)
If $1c > $11 Or $1d > $11 Then Return SetError(5, 0, -1)
If $1c > $1d Then Return SetError(6, 0, -1)
For $10 = $1a To $1b
For $17 = $1c To $1d
$1e &= $q[$10][$17] & $19
Next
$1e = StringTrimRight($1e, StringLen($19)) & $u
Next
Return StringTrimRight($1e, StringLen($u))
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _1r($1f)
FileReadToArray($1f)
If @error Then Return SetError(@error, @extended, 0)
Return @extended
EndFunc
Func _1t($1f, $1g = "*", $1h = 0, $1i = False)
Local $1j = "|", $1k = "", $1l = "", $1m = ""
$1f = StringRegExpReplace($1f, "[\\/]+$", "") & "\"
If $1h = Default Then $1h = 0
If $1i Then $1m = $1f
If $1g = Default Then $1g = "*"
If Not FileExists($1f) Then Return SetError(1, 0, 0)
If StringRegExp($1g, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
If Not($1h = 0 Or $1h = 1 Or $1h = 2) Then Return SetError(3, 0, 0)
Local $1n = FileFindFirstFile($1f & $1g)
If @error Then Return SetError(4, 0, 0)
While 1
$1l = FileFindNextFile($1n)
If @error Then ExitLoop
If($1h + @extended = 2) Then ContinueLoop
$1k &= $1j & $1m & $1l
WEnd
FileClose($1n)
If $1k = "" Then Return SetError(4, 0, 0)
Return StringSplit(StringTrimLeft($1k, 1), $1j)
EndFunc
Func _1z($1f, ByRef $1o, $1p = 1, $1j = "")
$1o = 0
If $1p = Default Then $1p = 1
If $1j = Default Then $1j = ""
Local $1q = True
If BitAND($1p, 2) Then
$1q = False
$1p -= 2
EndIf
Local $1r = 0
If BitAND($1p, 4) Then
$1r = 1
$1p -= 4
EndIf
Local $1s = 0
If $1p <> 1 Then
$1p = 0
$1s = 2
EndIf
If $1j Then
Local $1t = FileReadToArray($1f)
If @error Then Return SetError(@error, 0, 0)
Local $w = UBound($1t) + $1p
If $1q Then
Local $11 = UBound(StringSplit($1t[0], $1j, $1r + 2))
Local $1u[$w][$11]
Local $1v, $1w
For $10 = 0 To $w - $1p - 1
$1w = StringSplit($1t[$10], $1j, $1r + 2)
$1v = UBound($1w)
If $1v <> $11 Then
Return SetError(3, 0, 0)
EndIf
For $17 = 0 To $1v - 1
$1u[$10 + $1p][$17] = $1w[$17]
Next
Next
If $11 < 2 Then Return SetError(4, 0, 0)
If $1p Then
$1u[0][0] = $w - $1p
$1u[0][1] = $11
EndIf
Else
Local $1u[$w]
For $10 = 0 To $w - $1p - 1
$1u[$10 + $1p] = StringSplit($1t[$10], $1j, $1r + $1s)
Next
If $1p Then
$1u[0] = $w - $1p
EndIf
EndIf
$1o = $1u
Else
If $1p Then
Local $1x = FileOpen($1f, 0)
If $1x = -1 Then Return SetError(1, 0, 0)
Local $1y = FileRead($1x)
FileClose($1x)
If StringLen($1y) Then
$1o = StringRegExp(@LF & $1y, "(?|(\N+)\z|(\N*)(?:\R))", 3)
$1o[0] = UBound($1o) - 1
Else
Return SetError(2, 0, 0)
EndIf
Else
$1o = FileReadToArray($1f)
If @error Then
$1o = 0
Return SetError(@error, 0, 0)
EndIf
EndIf
EndIf
Return 1
EndFunc
Func _20($1f, Const ByRef $q, $1z = Default, $20 = Default, $1j = "|")
Local $21 = 0
If Not IsArray($q) Then Return SetError(2, 0, $21)
Local $22 = UBound($q, 0)
If $22 > 2 Then Return SetError(4, 0, 0)
Local $23 = UBound($q) - 1
If $20 = Default Or $20 > $23 Then $20 = $23
If $1z < 0 Or $1z = Default Then $1z = 0
If $1z > $20 Then Return SetError(5, 0, $21)
If $1j = Default Then $1j = "|"
Local $1x = $1f
If IsString($1f) Then
$1x = FileOpen($1f, 2)
If $1x = -1 Then Return SetError(1, 0, $21)
EndIf
Local $24 = 0
$21 = 1
Switch $22
Case 1
For $10 = $1z To $20
If Not FileWrite($1x, $q[$10] & @CRLF) Then
$24 = 3
$21 = 0
ExitLoop
EndIf
Next
Case 2
Local $25 = ""
For $10 = $1z To $20
$25 = $q[$10][0]
For $17 = 1 To UBound($q, 2) - 1
$25 &= $1j & $q[$10][$17]
Next
If Not FileWrite($1x, $25 & @CRLF) Then
$24 = 3
$21 = 0
ExitLoop
EndIf
Next
EndSwitch
If IsString($1f) Then FileClose($1x)
Return SetError($24, 0, $21)
EndFunc
Func _21($26, $27, $1h = -1)
Local $28 = 1
Local $29 = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " : " & $27
If $1h = Default Then $1h = -1
If $1h <> -1 Then
$28 = 2
$29 &= @CRLF & FileRead($26)
EndIf
Local $1x = $26
If IsString($26) Then $1x = FileOpen($26, $28)
If $1x = -1 Then Return SetError(1, 0, 0)
Local $21 = FileWriteLine($1x, $29)
If IsString($26) Then $21 = FileClose($1x)
If $21 <= 0 Then Return SetError(2, $21, 0)
Return $21
EndFunc
Global Const $2a = "struct;word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds;endstruct"
Global Const $2b = "struct;long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias;endstruct"
Global Const $2c = "dword Length;ptr Descriptor;bool InheritHandle"
Func _2p($2d, $1h = 0)
Local Const $2e = 183
Local Const $2f = 1
Local $2g = 0
If BitAND($1h, 2) Then
Local $2h = DllStructCreate("byte;byte;word;ptr[4]")
Local $2i = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $2h, "dword", $2f)
If @error Then Return SetError(@error, @extended, 0)
If $2i[0] Then
$2i = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $2h, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2i[0] Then
$2g = DllStructCreate($2c)
DllStructSetData($2g, 1, DllStructGetSize($2g))
DllStructSetData($2g, 2, DllStructGetPtr($2h))
DllStructSetData($2g, 3, 0)
EndIf
EndIf
EndIf
Local $2j = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $2g, "bool", 1, "wstr", $2d)
If @error Then Return SetError(@error, @extended, 0)
Local $2k = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $2k[0] = $2e Then
If BitAND($1h, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $2j[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($2k[0], $2k[0], 0)
Else
Exit -1
EndIf
EndIf
Return $2j[0]
EndFunc
Global Const $2l = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $2m = _4e()
Func _4e()
Local $2n = DllStructCreate($2l)
DllStructSetData($2n, 1, DllStructGetSize($2n))
Local $2i = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $2n)
If @error Or Not $2i[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($2n, 2), -8), DllStructGetData($2n, 3))
EndFunc
Global Const $2o = 0x007F
Func _4x($2p = 0, $2q = 0, $1p = 0, $2r = '')
If Not $2p Then $2p = 0x0400
Local $2s = 'wstr'
If Not StringStripWS($2r, 1 + 2) Then
$2s = 'ptr'
$2r = 0
EndIf
Local $2i = DllCall('kernel32.dll', 'int', 'GetDateFormatW', 'dword', $2p, 'dword', $1p, 'struct*', $2q, $2s, $2r, 'wstr', '', 'int', 2048)
If @error Or Not $2i[0] Then Return SetError(@error, @extended, '')
Return $2i[5]
EndFunc
Func _5l($2t, $2u = Default)
Local Const $2v = 128
If $2u = Default Then $2u = 0
$2t = Int($2t)
If $2t < 1 Or $2t > 7 Then Return SetError(1, 0, "")
Local $2q = DllStructCreate($2a)
DllStructSetData($2q, "Year", BitAND($2u, $2v) ? 2007 : 2006)
DllStructSetData($2q, "Month", 1)
DllStructSetData($2q, "Day", $2t)
Return _4x(BitAND($2u, 2) ? 0x0400 : $2o, $2q, 0, BitAND($2u, 1) ? "ddd" : "dddd")
EndFunc
Func _5o($2w)
If StringIsInt($2w) Then
Select
Case Mod($2w, 4) = 0 And Mod($2w, 100) <> 0
Return 1
Case Mod($2w, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1, 0, 0)
EndFunc
Func _5p($2x)
$2x = Int($2x)
Return $2x >= 1 And $2x <= 12
EndFunc
Func _5q($2y)
Local $2z[4], $30[4]
_5z($2y, $2z, $30)
If Not StringIsInt($2z[1]) Then Return 0
If Not StringIsInt($2z[2]) Then Return 0
If Not StringIsInt($2z[3]) Then Return 0
$2z[1] = Int($2z[1])
$2z[2] = Int($2z[2])
$2z[3] = Int($2z[3])
Local $31 = _6i($2z[1])
If $2z[1] < 1000 Or $2z[1] > 2999 Then Return 0
If $2z[2] < 1 Or $2z[2] > 12 Then Return 0
If $2z[3] < 1 Or $2z[3] > $31[$2z[2]] Then Return 0
If $30[0] < 1 Then Return 1
If $30[0] < 2 Then Return 0
If $30[0] = 2 Then $30[3] = "00"
If Not StringIsInt($30[1]) Then Return 0
If Not StringIsInt($30[2]) Then Return 0
If Not StringIsInt($30[3]) Then Return 0
$30[1] = Int($30[1])
$30[2] = Int($30[2])
$30[3] = Int($30[3])
If $30[1] < 0 Or $30[1] > 23 Then Return 0
If $30[2] < 0 Or $30[2] > 59 Then Return 0
If $30[3] < 0 Or $30[3] > 59 Then Return 0
Return 1
EndFunc
Func _5z($2y, ByRef $32, ByRef $33)
Local $34 = StringSplit($2y, " T")
If $34[0] > 0 Then $32 = StringSplit($34[1], "/-.")
If $34[0] > 1 Then
$33 = StringSplit($34[2], ":")
If UBound($33) < 4 Then ReDim $33[4]
Else
Dim $33[4]
EndIf
If UBound($32) < 4 Then ReDim $32[4]
For $35 = 1 To 3
If StringIsInt($32[$35]) Then
$32[$35] = Int($32[$35])
Else
$32[$35] = -1
EndIf
If StringIsInt($33[$35]) Then
$33[$35] = Int($33[$35])
Else
$33[$35] = 0
EndIf
Next
Return 1
EndFunc
Func _62($2w, $36, $37)
If Not _5q(StringFormat("%04d/%02d/%02d", $2w, $36, $37)) Then
Return SetError(1, 0, "")
EndIf
If $36 < 3 Then
$36 = $36 + 12
$2w = $2w - 1
EndIf
Local $38 = Int($2w / 100)
Local $39 = Int($38 / 4)
Local $3a = 2 - $38 + $39
Local $3b = Int(1461 *($2w + 4716) / 4)
Local $3c = Int(153 *($36 + 1) / 5)
Local $3d = $3a + $37 + $3b + $3c - 1524.5
Return $3d
EndFunc
Func _63($3e, $2u = Default)
If $2u = Default Then $2u = 0
$3e = Int($3e)
If Not _5p($3e) Then Return SetError(1, 0, "")
Local $2q = DllStructCreate($2a)
DllStructSetData($2q, "Year", @YEAR)
DllStructSetData($2q, "Month", $3e)
DllStructSetData($2q, "Day", 1)
Return _4x(BitAND($2u, 2) ? 0x0400 : $2o, $2q, 0, BitAND($2u, 1) ? "MMM" : "MMMM")
EndFunc
Func _6i($2w)
Local $3f = [12, 31,(_5o($2w) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Return $3f
EndFunc
Func _6j($3g)
Local $3h = DllStructCreate($2a, $3g)
Local $3i = DllStructCreate($2a)
DllStructSetData($3i, "Month", DllStructGetData($3h, "Month"))
DllStructSetData($3i, "Day", DllStructGetData($3h, "Day"))
DllStructSetData($3i, "Year", DllStructGetData($3h, "Year"))
DllStructSetData($3i, "Hour", DllStructGetData($3h, "Hour"))
DllStructSetData($3i, "Minute", DllStructGetData($3h, "Minute"))
DllStructSetData($3i, "Second", DllStructGetData($3h, "Second"))
DllStructSetData($3i, "MSeconds", DllStructGetData($3h, "MSeconds"))
DllStructSetData($3i, "DOW", DllStructGetData($3h, "DOW"))
Return $3i
EndFunc
Func _76()
Local $3j = DllStructCreate($2b)
Local $1 = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "struct*", $3j)
If @error Or $1[0] = -1 Then Return SetError(@error, @extended, 0)
Local $3k[8]
$3k[0] = $1[0]
$3k[1] = DllStructGetData($3j, "Bias")
$3k[2] = DllStructGetData($3j, "StdName")
$3k[3] = _6j(DllStructGetPtr($3j, "StdDate"))
$3k[4] = DllStructGetData($3j, "StdBias")
$3k[5] = DllStructGetData($3j, "DayName")
$3k[6] = _6j(DllStructGetPtr($3j, "DayDate"))
$3k[7] = DllStructGetData($3j, "DayBias")
Return $3k
EndFunc
Func _7o($3l, $3m, $3n, $3o, $3p = "", $3q = "", $3r = "", $3s = "", $3t = 0)
If $3l = "" Or $3n = "" Or $3o = "" Or $3m = "" Or StringLen($3m) > 256 Then Return SetError(1, 0, 0)
If $3r = "" Then $3r = @ComputerName
If TCPStartup() = 0 Then Return SetError(2, 0, 0)
Local $3u, $3v
If StringRegExp($3l, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") Then
$3u = $3l
Else
$3u = TCPNameToIP($3l)
EndIf
If $3u = "" Then
TCPShutdown()
Return SetError(3, 0, 0)
EndIf
Local $3w = TCPConnect($3u, 25)
If $3w = -1 Then
TCPShutdown()
Return SetError(4, 0, 0)
EndIf
Local $3x[6], $3y[6]
$3x[0] = "HELO " & $3r & @CRLF
If StringLeft($3r, 5) = "EHLO " Then $3x[0] = $3r & @CRLF
$3y[0] = "250"
$3x[1] = "MAIL FROM: <" & $3n & ">" & @CRLF
$3y[1] = "250"
$3x[2] = "RCPT TO: <" & $3o & ">" & @CRLF
$3y[2] = "250"
$3x[3] = "DATA" & @CRLF
$3y[3] = "354"
Local $1 = _76()
Local $3z = -$1[1] / 60
Local $40 = Int($3z)
Local $41 = 0
If $40 <> $3z Then $41 = Abs($3z - $40) * 60
$3z = StringFormat(" (%+.2d%.2d)", $40, $41)
$3x[4] = "From:" & $3m & "<" & $3n & ">" & @CRLF & "To:" & "<" & $3o & ">" & @CRLF & "Subject:" & $3p & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _5l(@WDAY, 1) & ", " & @MDAY & " " & _63(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $3z & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$3y[4] = ""
$3x[5] = @CRLF & "." & @CRLF
$3y[5] = "250"
If _7q($3w, $3x[0], $3y[0], $3t, "220", $3s) Then Return SetError(50, 0, 0)
For $3v = 1 To UBound($3x) - 2
If _7q($3w, $3x[$3v], $3y[$3v], $3t) Then Return SetError(50 + $3v, 0, 0)
Next
For $3v = 0 To UBound($3q) - 1
If StringLeft($3q[$3v], 1) = "." Then $3q[$3v] = "." & $3q[$3v]
If _7q($3w, $3q[$3v] & @CRLF, "", $3t) Then Return SetError(500 + $3v, 0, 0)
Next
$3v = UBound($3x) - 1
If _7q($3w, $3x[$3v], $3y[$3v], $3t) Then Return SetError(5000, 0, 0)
TCPCloseSocket($3w)
TCPShutdown()
Return 1
EndFunc
Func _7p($42, $43 = 0)
Local $44 = "SMTP trace"
Local $45 = ControlGetText($44, "", "Static1")
$42 = StringLeft(StringReplace($42, @CRLF, ""), 70)
$45 &= @HOUR & ":" & @MIN & ":" & @SEC & " " & $42 & @LF
If WinExists($44) Then
ControlSetText($44, "", "Static1", $45)
Else
SplashTextOn($44, $45, 400, 500, 500, 100, 4 + 16, "", 8)
EndIf
If $43 Then Sleep($43 * 1000)
EndFunc
Func _7q($3w, $46, $47, $3t, $48 = "", $3s = "")
Local $49, $10, $4a
If $3t Then _7p($46)
If $48 <> "" Then
If $3s <> -1 Then
If TCPSend($3w, $3s) = 0 Then
TCPCloseSocket($3w)
TCPShutdown()
Return 1
EndIf
EndIf
$49 = ""
$4a = TimerInit()
While StringLeft($49, StringLen($48)) <> $48 And TimerDiff($4a) < 45000
$49 = TCPRecv($3w, 1000)
If $3t And $49 <> "" Then _7p("intermediate->" & $49)
WEnd
EndIf
If TCPSend($3w, $46) = 0 Then
TCPCloseSocket($3w)
TCPShutdown()
Return 1
EndIf
$4a = TimerInit()
$49 = ""
While $49 = "" And TimerDiff($4a) < 45000
$10 += 1
$49 = TCPRecv($3w, 1000)
If $47 = "" Then ExitLoop
WEnd
If $47 <> "" Then
If $3t Then _7p($10 & " <- " & $49)
If StringLeft($49, StringLen($47)) <> $47 Then
TCPCloseSocket($3w)
TCPShutdown()
If $3t Then _7p("<-> " & $47, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Opt('ExpandVarStrings', 1)
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 0)
Global Const $4b = 60 * 5
Global $4c = 0
Global $4d = TimerInit()
Global $4e = $4d
Global $4f = $4d
Global $4g = $4d
Global $4h = $4d
Global $4i = $4d
Global Const $4j = "ShadowSpawn.exe"
Global Const $4k = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $4l = $4k & $4j
Global Const $4m = FileExists($4l)
Global Const $4n = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $4o = $4n & "KPSInfo.exe"
Global Const $4p = FileExists($4o)
Global Const $4q = "Powerkatalog-Schnittstelle.exe"
Global Const $4r = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $4s = $4r & $4q
Global Const $4t = FileExists($4s)
Global Const $4u = "SHDUpdater_min.exe"
Global Const $4v = @ProgramFilesDir & "\SHDUpdater\"
Global Const $4w = $4v & $4u
Global Const $4x = FileExists($4w)
Global Const $4y = "\\172.16.128.4\edv\Gerrit\"
Global Const $4z = $4y & ""
Global Const $50 = FileExists($4z)
Global Const $51 = $4y & "akk\"
Global Const $52 = $51 & ""
Global Const $53 = FileExists($52)
Global Const $54 = @ScriptDir & "\"
Global Const $55 = $54 & "akk.exe"
Global Const $56 = FileExists($55)
Global Const $57 = $4y
Global Const $58 = $57 & "akk.exe"
Global Const $59 = FileExists($58)
Global Const $5a = "akkUpdater.exe"
Global Const $5b = $54
Global Const $5c = $5b & $5a
Global $5d = FileExists($5c)
Global Const $5e = $5a
Global Const $5f = $4y
Global Const $5g = $5f & $5e
Global Const $5h = FileExists($5g)
Global Const $5i = $54
Global Const $5j = $5i & "akk.ini"
Global Const $5k = FileExists($5j)
Global Const $5l = "akkGlobalConfig.ini"
Global Const $5m = $54
Global Const $5n = $5m & $5l
Global $5o = FileExists($5n)
Global Const $5p = $5l
Global Const $5q = $51
Global Const $5r = $5q & $5p
Global Const $5s = FileExists($5r)
Global Const $5t = "akkGlobalConfigExtended.ini"
Global Const $5u = $5m
Global Const $5v = $5u & $5t
Global $5w = FileExists($5v)
Global Const $5x = $5t
Global Const $5y = $51
Global Const $5z = $5y & $5x
Global Const $60 = FileExists($5z)
Global $61
Global $62 = ""
Global Const $63 = $54 & "log\"
Global $64 = $63 & $62
Global $65 = FileExists($64)
If Not $65 Then DirCreate($63)
Global $66 = ""
Global Const $67 = $51 & "log\" & @ComputerName & "\"
Global $68 = $67 & $66
Global $69 = FileExists($68)
If Not $69 Then DirCreate($67)
Global $6a = "akkGlobal.log"
Global Const $6b = $51 & "log\"
Global $6c = $6b & $6a
Global $6d = FileExists($6c)
Global $6e = ""
Global Const $6f = $51 & "log\_archive\"
Global $6g = $6f & $6e
Global $6h = FileExists($6g)
If Not $6h Then DirCreate($6f)
Global Const $6i = $51 & "log\"
Global Const $6j = $6i & "akkGlobal.ini"
Global Const $6k = FileExists($6j)
Global Const $6l = $67
Global Const $6m = $6l & "akkMacro.ini"
Global Const $6n = FileExists($6m)
Global Const $6o = $54 & "log\"
Global Const $6p = $6o & "scrape.prom"
Global Const $6q = FileExists($6p)
Global Const $6r = $67
Global Const $6s = $6r & "scrape.prom"
Global Const $6t = FileExists($6s)
Global Const $6u = @UserProfileDir & "\Downloads"
Global Const $6v = $6u & " alt"
Global $6w[1][2]
Global $6x[1][2]
Global $6y[1][2]
Global $6z = ""
Global Const $70 = @ComputerName
Global $71
Global $72[10][2]
Global $73 = 0
Global $74 = 1
Global $75
Global $76 = 0
Global Const $77 = "wmi_exporter.exe"
Global Const $78 = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $79 = $78 & $77
Global $7a = FileExists($79)
Global Const $7b = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $7c = $51 & "wmi_exporter\"
Global Const $7d = $7c & $7b
Global Const $7e = FileExists($7d)
Global Const $7f = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $7g = $51 & "wmi_exporter\"
Global Const $7h = $7g & $7f
Global Const $7i = FileExists($7h)
Global Const $7j = "cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $7k = $78 & "textfile_inputs\"
Global Const $7l = $7k
Global Const $7m = $7l & "metadata.prom"
Global $7n = FileExists($7m)
Global $7o
Global $7p[3]
Global $7q
Global Const $7r = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $7j & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $7k
_2p("akk")
Sleep(5e3)
_7x()
_7v()
_7t("akk.exe läuft")
_7t($4l)
_7t($4o)
_7t($79)
_7t("werden überwacht")
_7u()
_7w()
_80()
_8d()
_84()
_89()
Sleep(5e3)
While 42
Sleep(10)
If(Mod($4c, 300) = 0) Then
If _7z($4e, 15e3 * 1) Then _81()
If _7z($4f, 60e3 * 5) Then _7u()
If _7z($4g, 60e3 * 5) Then _7v()
If _7z($4h, 60e3 * 5) Then _8b()
If _7z($4i, 10e3 * 1) Then _8e()
EndIf
If(Mod($4c, 500) = 0) Then _8c()
$4c += 1
WEnd
Func _7t($7s)
$7s = StringFormat("%10s", $4c) & " : " & $7s
ConsoleWrite(@CRLF & $7s)
_21($64, $7s)
_21($68, $7s)
_21($6c, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $7s)
EndFunc
Func _7u()
If $5s And Not $5o Then
$5o = FileCopy($5r, $5n, 1 + 8)
EndIf
If $60 And Not $5w Then
$5w = FileCopy($5z, $5v, 1 + 8)
EndIf
If $5h And Not $5d Then
$5d = FileCopy($5g, $5c, 1 + 8)
EndIf
Local $7t = FileGetTime($5n, 0, 1)
Local $7u = FileGetTime($5r, 0, 1)
If $7t <> $7u Then
$5o = FileCopy($5r, $5n, 1 + 8)
_7t("Reload Config " & $5r)
_7w()
EndIf
Local $7v = FileGetTime($5v, 0, 1)
Local $7w = FileGetTime($5z, 0, 1)
If $7v <> $7w Then
$5w = FileCopy($5z, $5v, 1 + 8)
_7t("Reload Config Ex" & $5z)
_7w()
_8e()
EndIf
Local $7x = FileGetTime($5c, 0, 1)
Local $7y = FileGetTime($5g, 0, 1)
If $7x <> $7y And @Compiled Then
$5d = FileCopy($5g, $5c, 1 + 8)
_7t("Reload Akk Updater " & $5g)
EndIf
Local $7z = FileGetTime($55, 0, 1)
Local $80 = FileGetTime($58, 0, 1)
If $7z <> $80 And @Compiled Then
_82($5a, $5b, $5c, $5d)
_7t("Reload Akk " & $58)
EndIf
EndFunc
Func _7v()
$62 = StringFormat("%04s", $61) & ".log"
$64 = $63 & $62
$68 = $67 & $62
If _1r($64) > 1e3 Then
$61 += 1
IniWrite($5j, "LogFile", "ID", $61)
EndIf
IniWrite($5j, "LogFile", "LogPath", $64)
IniWrite($5j, "LogFile", "LogNetPath", $68)
If FileGetSize($6c) / 1024 > 100 Then
Local $81 = $6f & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($6c, $81, 1 + 8)
EndIf
EndFunc
Func _7w()
If FileExists($5n) Then
$71 = IniRead($5n, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $10 = 0 To 9 Step 1
$72[$10][0] = IniRead($5n, "FreeSpaceCheck", "Mail" & $10 & "Address", "")
$72[$10][1] = IniRead($5n, "FreeSpaceCheck", "Mail" & $10 & "Active", 0)
Next
$6z = IniRead($5n, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($5v) Then
$7o = IniRead($5v, "MetaData", @ComputerName, "NULL")
If $7o = "NULL" Then
IniWrite($5z, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _7x()
$61 = IniRead($5j, "LogFile", "ID", "NULL")
If $61 = "NULL" Then
IniWrite($5j, "LogFile", "ID", 0)
$61 = 0
EndIf
EndFunc
Func _7z(ByRef $82, $83)
Local $84 = TimerDiff($82)
If $84 > $83 Then
$82 = TimerInit()
Return $84
EndIf
Return 0
EndFunc
Func _80()
Local Const $85 = "|"
IniWrite($6j, "Computername", @IPAddress1, @ComputerName)
IniWrite($6j, "IPAddress1", @ComputerName, @IPAddress1)
IniWrite($6j, "AkkVersion", @ComputerName, FileGetVersion(@ScriptFullPath))
_n($6w, "Compiled" & $85 & @Compiled, 0, $85)
_n($6w, "ScriptName" & $85 & @ScriptName, 0, $85)
_n($6w, "ScriptDir" & $85 & @ScriptDir, 0, $85)
_n($6w, "ScriptFullPath" & $85 & @ScriptFullPath, 0, $85)
_n($6w, "WorkingDir" & $85 & @WorkingDir, 0, $85)
_n($6w, "AutoItExe" & $85 & @AutoItExe, 0, $85)
_n($6w, "AutoItPID" & $85 & @AutoItPID, 0, $85)
_n($6w, "AutoItVersion" & $85 & @AutoItVersion, 0, $85)
_n($6w, "AutoItX64" & $85 & @AutoItX64, 0, $85)
IniWriteSection($6m, "MacroAutoIt", $6w)
_n($6x, "AppDataCommonDir" & $85 & @AppDataCommonDir, 0, $85)
_n($6x, "DesktopCommonDir" & $85 & @DesktopCommonDir, 0, $85)
_n($6x, "DocumentsCommonDir" & $85 & @DocumentsCommonDir, 0, $85)
_n($6x, "FavoritesCommonDir" & $85 & @FavoritesCommonDir, 0, $85)
_n($6x, "ProgramsCommonDir" & $85 & @ProgramsCommonDir, 0, $85)
_n($6x, "StartMenuCommonDir" & $85 & @StartMenuCommonDir, 0, $85)
_n($6x, "StartupCommonDir" & $85 & @StartupCommonDir, 0, $85)
_n($6x, "AppDataDir" & $85 & @AppDataDir, 0, $85)
_n($6x, "LocalAppDataDir" & $85 & @LocalAppDataDir, 0, $85)
_n($6x, "DesktopDir" & $85 & @DesktopDir, 0, $85)
_n($6x, "MyDocumentsDir" & $85 & @MyDocumentsDir, 0, $85)
_n($6x, "FavoritesDir" & $85 & @FavoritesDir, 0, $85)
_n($6x, "ProgramsDir" & $85 & @ProgramsDir, 0, $85)
_n($6x, "StartMenuDir" & $85 & @StartMenuDir, 0, $85)
_n($6x, "StartupDir" & $85 & @StartupDir, 0, $85)
_n($6x, "UserProfileDir" & $85 & @UserProfileDir, 0, $85)
_n($6x, "HomeDrive" & $85 & @HomeDrive, 0, $85)
_n($6x, "HomePath" & $85 & @HomePath, 0, $85)
_n($6x, "HomeShare" & $85 & @HomeShare, 0, $85)
_n($6x, "LogonDNSDomain" & $85 & @LogonDNSDomain, 0, $85)
_n($6x, "LogonDomain" & $85 & @LogonDomain, 0, $85)
_n($6x, "LogonServer" & $85 & @LogonServer, 0, $85)
_n($6x, "ProgramFilesDir" & $85 & @ProgramFilesDir, 0, $85)
_n($6x, "CommonFilesDir" & $85 & @CommonFilesDir, 0, $85)
_n($6x, "WindowsDir" & $85 & @WindowsDir, 0, $85)
_n($6x, "SystemDir" & $85 & @SystemDir, 0, $85)
_n($6x, "TempDir" & $85 & @TempDir, 0, $85)
_n($6x, "ComSpec" & $85 & @ComSpec, 0, $85)
IniWriteSection($6m, "MacroDirectory", $6x)
_n($6y, "CPUArch" & $85 & @CPUArch, 0, $85)
_n($6y, "KBLayout" & $85 & @KBLayout, 0, $85)
_n($6y, "MUILang" & $85 & @MUILang, 0, $85)
_n($6y, "OSArch" & $85 & @OSArch, 0, $85)
_n($6y, "OSLang" & $85 & @OSLang, 0, $85)
_n($6y, "OSType" & $85 & @OSType, 0, $85)
_n($6y, "OSVersion" & $85 & @OSVersion, 0, $85)
_n($6y, "OSBuild" & $85 & @OSBuild, 0, $85)
_n($6y, "OSServicePack" & $85 & @OSServicePack, 0, $85)
_n($6y, "ComputerName" & $85 & @ComputerName, 0, $85)
_n($6y, "UserName" & $85 & @UserName, 0, $85)
_n($6y, "IPAddress1" & $85 & @IPAddress1, 0, $85)
_n($6y, "IPAddress2" & $85 & @IPAddress2, 0, $85)
_n($6y, "IPAddress3" & $85 & @IPAddress3, 0, $85)
_n($6y, "IPAddress4" & $85 & @IPAddress4, 0, $85)
_n($6y, "DesktopHeight" & $85 & @DesktopHeight, 0, $85)
_n($6y, "DesktopWidth" & $85 & @DesktopWidth, 0, $85)
_n($6y, "DesktopDepth" & $85 & @DesktopDepth, 0, $85)
_n($6y, "DesktopRefresh" & $85 & @DesktopRefresh, 0, $85)
IniWriteSection($6m, "MacroSystemInfo", $6y)
EndFunc
Func _81()
_82($4j, $4k, $4l, $4m)
_82("KPSInfo.exe", $4n, $4o, $4p)
$75 = _82($77, $78, $79 & $7r, $7a)
EndFunc
Func _82($86, $87, $88, $89, $8a = @SW_HIDE)
If $89 And Not ProcessExists($86) Then
_7t($86 & " wird gestartet")
Return Run($88, $87, $8a)
EndIf
Return 0
EndFunc
Func _84()
If _85() Then
DirRemove($6v, 1)
_86($6u, $6v)
FileDelete($6v & "\Downloads alt.lnk")
FileCreateShortcut($6v, $6u & "\Downloads alt")
IniWrite($5j, "Downloads", "LastCleaningDate", _62(@YEAR, @MON, @MDAY))
Local Const $8b = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $8b, $4b) = 6 Then
ShellExecute($6v)
EndIf
EndIf
EndFunc
Func _85()
Return(_62(@YEAR, @MON, @MDAY) - _87()) >= 14
EndFunc
Func _86($8c, $8d)
If FileExists($8c) Then
If Not FileExists($8d) Then DirCreate($8d)
FileMove($8c & "\*.*", $8d, 1 + 8)
Local Const $8e = _1t($8c, Default, 2, True)
If Not @error Then
For $8f In $8e
DirMove($8f, $8d, 1)
Next
EndIf
EndIf
EndFunc
Func _87()
Return IniRead($5j, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _89()
Local Const $8g = DriveGetLabel(@HomeDrive & "\")
Local Const $8h = DriveSpaceFree(@HomeDrive & "\")
Local Const $8i = DriveSpaceTotal(@HomeDrive & "\")
Local Const $8j =($8h / $8i) * 100
If $8j < $71 Then
If(_62(@YEAR, @MON, @MDAY) - IniRead($5j, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($5j, "FreeSpaceCheck", "LastMailSendDate", _62(@YEAR, @MON, @MDAY))
For $10 = 0 To 9 Step 1
If $72[$10][0] <> "" And $72[$10][1] = 1 Then
_7t("Sending Mail to " & $72[$10][0])
_8a($72[$10][0], Round($8j, 2), $8g, $8h, $8i)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _8a($3o, $8j, $8g, $8h, $8i)
Local $3m = "akk.exe (Gerrit)"
Local $3n = "akk@kuechen-brauckhoff.de"
Local $3p = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $8j & "% !"
Local $8k[0]
_n($8k, "Akk Warnung wenig Speicherplatz auf:")
_n($8k, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _n($8k, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _n($8k, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _n($8k, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _n($8k, @IPAddress4)
_n($8k, $8g & " (" & @HomeDrive & ")")
_n($8k, Round($8h / 1024, 2) & " GB frei von " & Round($8i / 1024, 2) & " GB")
_n($8k, $8j & "% frei")
Local $8l = _7o($6z, $3m, $3n, $3o, $3p, $8k, $70, -1, 0)
Local $8m = @error
If $8l = 0 Then
Local Const $8b = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _1e($8k, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $8m & @CRLF
MsgBox(48 + 4096, "Warnung!", $8b)
EndIf
EndFunc
Func _8b()
If $74 And ProcessExists($77) Then
$73 = InetGet("http://localhost:9182/metrics", $6p, 1, 1)
$74 = 0
EndIf
EndFunc
Func _8c()
If Not $74 Then
If InetGetInfo($73, 2) Then
If InetGetInfo($73, 3) Then
If FileGetSize($6p) Then FileCopy($6p, $6s, 1 + 8)
Else
FileDelete($6p)
_7t("Error ScrapeDownload")
EndIf
InetClose($73)
$73 = 0
$74 = 1
EndIf
EndIf
EndFunc
Func _8d()
ProcessClose($77)
If Not $7a Then
Local $8n =(@OSArch = "X64") ? $7h : $7d
If FileCopy($8n, $79, 1 + 8) Then
$7a = FileExists($79)
EndIf
EndIf
If Not FileExists($7k) Then DirCreate($7k)
EndFunc
Func _8e()
Local $8o = 'metadata{computername="@ComputerName@",username="@UserName@"'
If $7o <> "NULL" And StringLen($7o) And Not StringIsSpace($7o) Then
$8o &= "," & $7o
EndIf
$8o &= '} 1'
$76 = _1() / 1e3
Local $8p = 'akk_idletime_sec{computername="@ComputerName@"} $IdleTime$'
$7p[1] = $8o
$7p[2] = $8p
$7p[0] = UBound($7p) - 1
_1z($7m, $7q)
If Not _8f($7p, $7q, 3) Then
_20($7m, $7p, 1)
EndIf
EndFunc
Func _8f(Const ByRef $8q, Const ByRef $8r, $8s = 0)
If Not(IsArray($8q)) Or Not(IsArray($8r)) Then
Return SetError(1, 0, 0)
EndIf
Local $22 = UBound($8q, 0)
If $22 <> UBound($8r, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $8t = UBound($8q, 1)
Local $8u = UBound($8q, 2)
If $8t <> UBound($8r, 1) Or $8u <> UBound($8r, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $8v, $8w
Switch $8s
Case 0
For $10 = 0 To $8t - 1
For $17 = 0 To $8u - 1
If $8q[$10][$17] <> $8q[$10][$17] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case 1
For $10 = 0 To $8t - 1
For $17 = 0 To $8u - 1
$8v &= $8q[$10][$17]
$8w &= $8r[$10][$17]
Next
If $8v <> $8w Then
Return SetError(4, 0, 0)
EndIf
Next
Case 2
For $17 = 0 To $8u - 1
For $10 = 0 To $8t - 1
$8v &= $8q[$10][$17]
$8w &= $8r[$10][$17]
Next
If $8v <> $8w Then
Return SetError(4, 0, 0)
EndIf
Next
Case 3
If _1e($8q) <> _1e($8r) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
