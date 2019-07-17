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
Global Enum $e, $f, $g, $h, $i, $j, $k, $l
Func _e(ByRef $m, $n, $o = 0, $p = "|", $q = @CRLF, $r = $e)
If $o = Default Then $o = 0
If $p = Default Then $p = "|"
If $q = Default Then $q = @CRLF
If $r = Default Then $r = $e
If Not IsArray($m) Then Return SetError(1, 0, -1)
Local $s = UBound($m, 1)
Local $t = 0
Switch $r
Case $g
$t = Int
Case $h
$t = Number
Case $i
$t = Ptr
Case $j
$t = Hwnd
Case $k
$t = String
Case $l
$t = "Boolean"
EndSwitch
Switch UBound($m, 0)
Case 1
If $r = $f Then
ReDim $m[$s + 1]
$m[$s] = $n
Return $s
EndIf
If IsArray($n) Then
If UBound($n, 0) <> 1 Then Return SetError(5, 0, -1)
$t = 0
Else
Local $u = StringSplit($n, $p, 2 + 1)
If UBound($u, 1) = 1 Then
$u[0] = $n
EndIf
$n = $u
EndIf
Local $v = UBound($n, 1)
ReDim $m[$s + $v]
For $w = 0 To $v - 1
If String($t) = "Boolean" Then
Switch $n[$w]
Case "True", "1"
$m[$s + $w] = True
Case "False", "0", ""
$m[$s + $w] = False
EndSwitch
ElseIf IsFunc($t) Then
$m[$s + $w] = $t($n[$w])
Else
$m[$s + $w] = $n[$w]
EndIf
Next
Return $s + $v - 1
Case 2
Local $x = UBound($m, 2)
If $o < 0 Or $o > $x - 1 Then Return SetError(4, 0, -1)
Local $y, $0z = 0, $10
If IsArray($n) Then
If UBound($n, 0) <> 2 Then Return SetError(5, 0, -1)
$y = UBound($n, 1)
$0z = UBound($n, 2)
$t = 0
Else
Local $11 = StringSplit($n, $q, 2 + 1)
$y = UBound($11, 1)
Local $u[$y][0], $12
For $w = 0 To $y - 1
$12 = StringSplit($11[$w], $p, 2 + 1)
$10 = UBound($12)
If $10 > $0z Then
$0z = $10
ReDim $u[$y][$0z]
EndIf
For $13 = 0 To $10 - 1
$u[$w][$13] = $12[$13]
Next
Next
$n = $u
EndIf
If UBound($n, 2) + $o > UBound($m, 2) Then Return SetError(3, 0, -1)
ReDim $m[$s + $y][$x]
For $14 = 0 To $y - 1
For $13 = 0 To $x - 1
If $13 < $o Then
$m[$14 + $s][$13] = ""
ElseIf $13 - $o > $0z - 1 Then
$m[$14 + $s][$13] = ""
Else
If String($t) = "Boolean" Then
Switch $n[$14][$13 - $o]
Case "True", "1"
$m[$14 + $s][$13] = True
Case "False", "0", ""
$m[$14 + $s][$13] = False
EndSwitch
ElseIf IsFunc($t) Then
$m[$14 + $s][$13] = $t($n[$14][$13 - $o])
Else
$m[$14 + $s][$13] = $n[$14][$13 - $o]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($m, 1) - 1
EndFunc
Func _15(Const ByRef $m, $15 = "|", $16 = -1, $17 = -1, $q = @CRLF, $18 = -1, $19 = -1)
If $15 = Default Then $15 = "|"
If $q = Default Then $q = @CRLF
If $16 = Default Then $16 = -1
If $17 = Default Then $17 = -1
If $18 = Default Then $18 = -1
If $19 = Default Then $19 = -1
If Not IsArray($m) Then Return SetError(1, 0, -1)
Local $s = UBound($m, 1) - 1
If $16 = -1 Then $16 = 0
If $17 = -1 Then $17 = $s
If $16 < -1 Or $17 < -1 Then Return SetError(3, 0, -1)
If $16 > $s Or $17 > $s Then Return SetError(3, 0, "")
If $16 > $17 Then Return SetError(4, 0, -1)
Local $1a = ""
Switch UBound($m, 0)
Case 1
For $w = $16 To $17
$1a &= $m[$w] & $15
Next
Return StringTrimRight($1a, StringLen($15))
Case 2
Local $x = UBound($m, 2) - 1
If $18 = -1 Then $18 = 0
If $19 = -1 Then $19 = $x
If $18 < -1 Or $19 < -1 Then Return SetError(5, 0, -1)
If $18 > $x Or $19 > $x Then Return SetError(5, 0, -1)
If $18 > $19 Then Return SetError(6, 0, -1)
For $w = $16 To $17
For $13 = $18 To $19
$1a &= $m[$w][$13] & $15
Next
$1a = StringTrimRight($1a, StringLen($15)) & $q
Next
Return StringTrimRight($1a, StringLen($q))
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _1i($1b)
FileReadToArray($1b)
If @error Then Return SetError(@error, @extended, 0)
Return @extended
EndFunc
Func _1k($1b, $1c = "*", $1d = 0, $1e = False)
Local $1f = "|", $1g = "", $1h = "", $1i = ""
$1b = StringRegExpReplace($1b, "[\\/]+$", "") & "\"
If $1d = Default Then $1d = 0
If $1e Then $1i = $1b
If $1c = Default Then $1c = "*"
If Not FileExists($1b) Then Return SetError(1, 0, 0)
If StringRegExp($1c, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
If Not($1d = 0 Or $1d = 1 Or $1d = 2) Then Return SetError(3, 0, 0)
Local $1j = FileFindFirstFile($1b & $1c)
If @error Then Return SetError(4, 0, 0)
While 1
$1h = FileFindNextFile($1j)
If @error Then ExitLoop
If($1d + @extended = 2) Then ContinueLoop
$1g &= $1f & $1i & $1h
WEnd
FileClose($1j)
If $1g = "" Then Return SetError(4, 0, 0)
Return StringSplit(StringTrimLeft($1g, 1), $1f)
EndFunc
Func _1q($1b, ByRef $1k, $1l = 1, $1f = "")
$1k = 0
If $1l = Default Then $1l = 1
If $1f = Default Then $1f = ""
Local $1m = True
If BitAND($1l, 2) Then
$1m = False
$1l -= 2
EndIf
Local $1n = 0
If BitAND($1l, 4) Then
$1n = 1
$1l -= 4
EndIf
Local $1o = 0
If $1l <> 1 Then
$1l = 0
$1o = 2
EndIf
If $1f Then
Local $1p = FileReadToArray($1b)
If @error Then Return SetError(@error, 0, 0)
Local $s = UBound($1p) + $1l
If $1m Then
Local $x = UBound(StringSplit($1p[0], $1f, $1n + 2))
Local $1q[$s][$x]
Local $1r, $1s
For $w = 0 To $s - $1l - 1
$1s = StringSplit($1p[$w], $1f, $1n + 2)
$1r = UBound($1s)
If $1r <> $x Then
Return SetError(3, 0, 0)
EndIf
For $13 = 0 To $1r - 1
$1q[$w + $1l][$13] = $1s[$13]
Next
Next
If $x < 2 Then Return SetError(4, 0, 0)
If $1l Then
$1q[0][0] = $s - $1l
$1q[0][1] = $x
EndIf
Else
Local $1q[$s]
For $w = 0 To $s - $1l - 1
$1q[$w + $1l] = StringSplit($1p[$w], $1f, $1n + $1o)
Next
If $1l Then
$1q[0] = $s - $1l
EndIf
EndIf
$1k = $1q
Else
If $1l Then
Local $1t = FileOpen($1b, 0)
If $1t = -1 Then Return SetError(1, 0, 0)
Local $1u = FileRead($1t)
FileClose($1t)
If StringLen($1u) Then
$1k = StringRegExp(@LF & $1u, "(?|(\N+)\z|(\N*)(?:\R))", 3)
$1k[0] = UBound($1k) - 1
Else
Return SetError(2, 0, 0)
EndIf
Else
$1k = FileReadToArray($1b)
If @error Then
$1k = 0
Return SetError(@error, 0, 0)
EndIf
EndIf
EndIf
Return 1
EndFunc
Func _1r($1b, Const ByRef $m, $1v = Default, $1w = Default, $1f = "|")
Local $1x = 0
If Not IsArray($m) Then Return SetError(2, 0, $1x)
Local $1y = UBound($m, 0)
If $1y > 2 Then Return SetError(4, 0, 0)
Local $1z = UBound($m) - 1
If $1w = Default Or $1w > $1z Then $1w = $1z
If $1v < 0 Or $1v = Default Then $1v = 0
If $1v > $1w Then Return SetError(5, 0, $1x)
If $1f = Default Then $1f = "|"
Local $1t = $1b
If IsString($1b) Then
$1t = FileOpen($1b, 2)
If $1t = -1 Then Return SetError(1, 0, $1x)
EndIf
Local $20 = 0
$1x = 1
Switch $1y
Case 1
For $w = $1v To $1w
If Not FileWrite($1t, $m[$w] & @CRLF) Then
$20 = 3
$1x = 0
ExitLoop
EndIf
Next
Case 2
Local $21 = ""
For $w = $1v To $1w
$21 = $m[$w][0]
For $13 = 1 To UBound($m, 2) - 1
$21 &= $1f & $m[$w][$13]
Next
If Not FileWrite($1t, $21 & @CRLF) Then
$20 = 3
$1x = 0
ExitLoop
EndIf
Next
EndSwitch
If IsString($1b) Then FileClose($1t)
Return SetError($20, 0, $1x)
EndFunc
Func _1s($22, $23, $1d = -1)
Local $24 = 1
Local $25 = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " : " & $23
If $1d = Default Then $1d = -1
If $1d <> -1 Then
$24 = 2
$25 &= @CRLF & FileRead($22)
EndIf
Local $1t = $22
If IsString($22) Then $1t = FileOpen($22, $24)
If $1t = -1 Then Return SetError(1, 0, 0)
Local $1x = FileWriteLine($1t, $25)
If IsString($22) Then $1x = FileClose($1t)
If $1x <= 0 Then Return SetError(2, $1x, 0)
Return $1x
EndFunc
Global Const $26 = "struct;word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds;endstruct"
Global Const $27 = "struct;long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias;endstruct"
Global Const $28 = "dword Length;ptr Descriptor;bool InheritHandle"
Func _2g($29, $1d = 0)
Local Const $2a = 183
Local Const $2b = 1
Local $2c = 0
If BitAND($1d, 2) Then
Local $2d = DllStructCreate("byte;byte;word;ptr[4]")
Local $2e = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $2d, "dword", $2b)
If @error Then Return SetError(@error, @extended, 0)
If $2e[0] Then
$2e = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $2d, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $2e[0] Then
$2c = DllStructCreate($28)
DllStructSetData($2c, 1, DllStructGetSize($2c))
DllStructSetData($2c, 2, DllStructGetPtr($2d))
DllStructSetData($2c, 3, 0)
EndIf
EndIf
EndIf
Local $2f = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $2c, "bool", 1, "wstr", $29)
If @error Then Return SetError(@error, @extended, 0)
Local $2g = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $2g[0] = $2a Then
If BitAND($1d, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $2f[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($2g[0], $2g[0], 0)
Else
Exit -1
EndIf
EndIf
Return $2f[0]
EndFunc
Global Const $2h = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $2i = _45()
Func _45()
Local $2j = DllStructCreate($2h)
DllStructSetData($2j, 1, DllStructGetSize($2j))
Local $2e = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $2j)
If @error Or Not $2e[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($2j, 2), -8), DllStructGetData($2j, 3))
EndFunc
Global Const $2k = 0x007F
Func _4o($2l = 0, $2m = 0, $1l = 0, $2n = '')
If Not $2l Then $2l = 0x0400
Local $2o = 'wstr'
If Not StringStripWS($2n, 1 + 2) Then
$2o = 'ptr'
$2n = 0
EndIf
Local $2e = DllCall('kernel32.dll', 'int', 'GetDateFormatW', 'dword', $2l, 'dword', $1l, 'struct*', $2m, $2o, $2n, 'wstr', '', 'int', 2048)
If @error Or Not $2e[0] Then Return SetError(@error, @extended, '')
Return $2e[5]
EndFunc
Func _5c($2p, $2q = Default)
Local Const $2r = 128
If $2q = Default Then $2q = 0
$2p = Int($2p)
If $2p < 1 Or $2p > 7 Then Return SetError(1, 0, "")
Local $2m = DllStructCreate($26)
DllStructSetData($2m, "Year", BitAND($2q, $2r) ? 2007 : 2006)
DllStructSetData($2m, "Month", 1)
DllStructSetData($2m, "Day", $2p)
Return _4o(BitAND($2q, 2) ? 0x0400 : $2k, $2m, 0, BitAND($2q, 1) ? "ddd" : "dddd")
EndFunc
Func _5f($2s)
If StringIsInt($2s) Then
Select
Case Mod($2s, 4) = 0 And Mod($2s, 100) <> 0
Return 1
Case Mod($2s, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1, 0, 0)
EndFunc
Func _5g($2t)
$2t = Int($2t)
Return $2t >= 1 And $2t <= 12
EndFunc
Func _5h($2u)
Local $2v[4], $2w[4]
_5q($2u, $2v, $2w)
If Not StringIsInt($2v[1]) Then Return 0
If Not StringIsInt($2v[2]) Then Return 0
If Not StringIsInt($2v[3]) Then Return 0
$2v[1] = Int($2v[1])
$2v[2] = Int($2v[2])
$2v[3] = Int($2v[3])
Local $2x = _69($2v[1])
If $2v[1] < 1000 Or $2v[1] > 2999 Then Return 0
If $2v[2] < 1 Or $2v[2] > 12 Then Return 0
If $2v[3] < 1 Or $2v[3] > $2x[$2v[2]] Then Return 0
If $2w[0] < 1 Then Return 1
If $2w[0] < 2 Then Return 0
If $2w[0] = 2 Then $2w[3] = "00"
If Not StringIsInt($2w[1]) Then Return 0
If Not StringIsInt($2w[2]) Then Return 0
If Not StringIsInt($2w[3]) Then Return 0
$2w[1] = Int($2w[1])
$2w[2] = Int($2w[2])
$2w[3] = Int($2w[3])
If $2w[1] < 0 Or $2w[1] > 23 Then Return 0
If $2w[2] < 0 Or $2w[2] > 59 Then Return 0
If $2w[3] < 0 Or $2w[3] > 59 Then Return 0
Return 1
EndFunc
Func _5q($2u, ByRef $2y, ByRef $2z)
Local $30 = StringSplit($2u, " T")
If $30[0] > 0 Then $2y = StringSplit($30[1], "/-.")
If $30[0] > 1 Then
$2z = StringSplit($30[2], ":")
If UBound($2z) < 4 Then ReDim $2z[4]
Else
Dim $2z[4]
EndIf
If UBound($2y) < 4 Then ReDim $2y[4]
For $31 = 1 To 3
If StringIsInt($2y[$31]) Then
$2y[$31] = Int($2y[$31])
Else
$2y[$31] = -1
EndIf
If StringIsInt($2z[$31]) Then
$2z[$31] = Int($2z[$31])
Else
$2z[$31] = 0
EndIf
Next
Return 1
EndFunc
Func _5t($2s, $32, $33)
If Not _5h(StringFormat("%04d/%02d/%02d", $2s, $32, $33)) Then
Return SetError(1, 0, "")
EndIf
If $32 < 3 Then
$32 = $32 + 12
$2s = $2s - 1
EndIf
Local $34 = Int($2s / 100)
Local $35 = Int($34 / 4)
Local $36 = 2 - $34 + $35
Local $37 = Int(1461 *($2s + 4716) / 4)
Local $38 = Int(153 *($32 + 1) / 5)
Local $39 = $36 + $33 + $37 + $38 - 1524.5
Return $39
EndFunc
Func _5u($3a, $2q = Default)
If $2q = Default Then $2q = 0
$3a = Int($3a)
If Not _5g($3a) Then Return SetError(1, 0, "")
Local $2m = DllStructCreate($26)
DllStructSetData($2m, "Year", @YEAR)
DllStructSetData($2m, "Month", $3a)
DllStructSetData($2m, "Day", 1)
Return _4o(BitAND($2q, 2) ? 0x0400 : $2k, $2m, 0, BitAND($2q, 1) ? "MMM" : "MMMM")
EndFunc
Func _69($2s)
Local $3b = [12, 31,(_5f($2s) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Return $3b
EndFunc
Func _6a($3c)
Local $3d = DllStructCreate($26, $3c)
Local $3e = DllStructCreate($26)
DllStructSetData($3e, "Month", DllStructGetData($3d, "Month"))
DllStructSetData($3e, "Day", DllStructGetData($3d, "Day"))
DllStructSetData($3e, "Year", DllStructGetData($3d, "Year"))
DllStructSetData($3e, "Hour", DllStructGetData($3d, "Hour"))
DllStructSetData($3e, "Minute", DllStructGetData($3d, "Minute"))
DllStructSetData($3e, "Second", DllStructGetData($3d, "Second"))
DllStructSetData($3e, "MSeconds", DllStructGetData($3d, "MSeconds"))
DllStructSetData($3e, "DOW", DllStructGetData($3d, "DOW"))
Return $3e
EndFunc
Func _6x()
Local $3f = DllStructCreate($27)
Local $3g = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "struct*", $3f)
If @error Or $3g[0] = -1 Then Return SetError(@error, @extended, 0)
Local $3h[8]
$3h[0] = $3g[0]
$3h[1] = DllStructGetData($3f, "Bias")
$3h[2] = DllStructGetData($3f, "StdName")
$3h[3] = _6a(DllStructGetPtr($3f, "StdDate"))
$3h[4] = DllStructGetData($3f, "StdBias")
$3h[5] = DllStructGetData($3f, "DayName")
$3h[6] = _6a(DllStructGetPtr($3f, "DayDate"))
$3h[7] = DllStructGetData($3f, "DayBias")
Return $3h
EndFunc
Func _7f($3i, $3j, $3k, $3l, $3m = "", $3n = "", $3o = "", $3p = "", $3q = 0)
If $3i = "" Or $3k = "" Or $3l = "" Or $3j = "" Or StringLen($3j) > 256 Then Return SetError(1, 0, 0)
If $3o = "" Then $3o = @ComputerName
If TCPStartup() = 0 Then Return SetError(2, 0, 0)
Local $3r, $3s
If StringRegExp($3i, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") Then
$3r = $3i
Else
$3r = TCPNameToIP($3i)
EndIf
If $3r = "" Then
TCPShutdown()
Return SetError(3, 0, 0)
EndIf
Local $3t = TCPConnect($3r, 25)
If $3t = -1 Then
TCPShutdown()
Return SetError(4, 0, 0)
EndIf
Local $3u[6], $3v[6]
$3u[0] = "HELO " & $3o & @CRLF
If StringLeft($3o, 5) = "EHLO " Then $3u[0] = $3o & @CRLF
$3v[0] = "250"
$3u[1] = "MAIL FROM: <" & $3k & ">" & @CRLF
$3v[1] = "250"
$3u[2] = "RCPT TO: <" & $3l & ">" & @CRLF
$3v[2] = "250"
$3u[3] = "DATA" & @CRLF
$3v[3] = "354"
Local $3g = _6x()
Local $3w = -$3g[1] / 60
Local $3x = Int($3w)
Local $3y = 0
If $3x <> $3w Then $3y = Abs($3w - $3x) * 60
$3w = StringFormat(" (%+.2d%.2d)", $3x, $3y)
$3u[4] = "From:" & $3j & "<" & $3k & ">" & @CRLF & "To:" & "<" & $3l & ">" & @CRLF & "Subject:" & $3m & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _5c(@WDAY, 1) & ", " & @MDAY & " " & _5u(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $3w & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$3v[4] = ""
$3u[5] = @CRLF & "." & @CRLF
$3v[5] = "250"
If _7h($3t, $3u[0], $3v[0], $3q, "220", $3p) Then Return SetError(50, 0, 0)
For $3s = 1 To UBound($3u) - 2
If _7h($3t, $3u[$3s], $3v[$3s], $3q) Then Return SetError(50 + $3s, 0, 0)
Next
For $3s = 0 To UBound($3n) - 1
If StringLeft($3n[$3s], 1) = "." Then $3n[$3s] = "." & $3n[$3s]
If _7h($3t, $3n[$3s] & @CRLF, "", $3q) Then Return SetError(500 + $3s, 0, 0)
Next
$3s = UBound($3u) - 1
If _7h($3t, $3u[$3s], $3v[$3s], $3q) Then Return SetError(5000, 0, 0)
TCPCloseSocket($3t)
TCPShutdown()
Return 1
EndFunc
Func _7g($3z, $40 = 0)
Local $41 = "SMTP trace"
Local $42 = ControlGetText($41, "", "Static1")
$3z = StringLeft(StringReplace($3z, @CRLF, ""), 70)
$42 &= @HOUR & ":" & @MIN & ":" & @SEC & " " & $3z & @LF
If WinExists($41) Then
ControlSetText($41, "", "Static1", $42)
Else
SplashTextOn($41, $42, 400, 500, 500, 100, 4 + 16, "", 8)
EndIf
If $40 Then Sleep($40 * 1000)
EndFunc
Func _7h($3t, $43, $44, $3q, $45 = "", $3p = "")
Local $46, $w, $47
If $3q Then _7g($43)
If $45 <> "" Then
If $3p <> -1 Then
If TCPSend($3t, $3p) = 0 Then
TCPCloseSocket($3t)
TCPShutdown()
Return 1
EndIf
EndIf
$46 = ""
$47 = TimerInit()
While StringLeft($46, StringLen($45)) <> $45 And TimerDiff($47) < 45000
$46 = TCPRecv($3t, 1000)
If $3q And $46 <> "" Then _7g("intermediate->" & $46)
WEnd
EndIf
If TCPSend($3t, $43) = 0 Then
TCPCloseSocket($3t)
TCPShutdown()
Return 1
EndIf
$47 = TimerInit()
$46 = ""
While $46 = "" And TimerDiff($47) < 45000
$w += 1
$46 = TCPRecv($3t, 1000)
If $44 = "" Then ExitLoop
WEnd
If $44 <> "" Then
If $3q Then _7g($w & " <- " & $46)
If StringLeft($46, StringLen($44)) <> $44 Then
TCPCloseSocket($3t)
TCPShutdown()
If $3q Then _7g("<-> " & $44, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Opt("ExpandVarStrings", 1)
Opt("MustDeclareVars", 1)
Opt("TrayAutoPause", 0)
Global Const $48 = 60 * 5
Global $49 = 0
Global $4a = TimerInit()
Global $4b = $4a
Global $4c = $4a
Global $4d = $4a
Global Const $4e = "ShadowSpawn.exe"
Global Const $4f = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $4g = $4f & $4e
Global Const $4h = FileExists($4g)
Global Const $4i = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $4j = $4i & "KPSInfo.exe"
Global Const $4k = FileExists($4j)
Global Const $4l = "Powerkatalog-Schnittstelle.exe"
Global Const $4m = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $4n = $4m & $4l
Global Const $4o = FileExists($4n)
Global Const $4p = "SHDUpdater_min.exe"
Global Const $4q = @ProgramFilesDir & "\SHDUpdater\"
Global Const $4r = $4q & $4p
Global Const $4s = FileExists($4r)
Global Const $4t = "\\172.16.128.4\edv\Gerrit\"
Global Const $4u = $4t & ""
Global Const $4v = FileExists($4u)
Global Const $4w = $4t & "akk\"
Global Const $4x = $4w & ""
Global Const $4y = FileExists($4x)
Global Const $4z = @ScriptDir & "\"
Global Const $50 = $4z & "akk.exe"
Global Const $51 = FileExists($50)
Global Const $52 = $4t
Global Const $53 = $52 & "akk.exe"
Global Const $54 = FileExists($53)
Global Const $55 = "akkUpdater.exe"
Global Const $56 = $4z
Global Const $57 = $56 & $55
Global $58 = FileExists($57)
Global Const $59 = $55
Global Const $5a = $4t
Global Const $5b = $5a & $59
Global Const $5c = FileExists($5b)
Global Const $5d = $4z
Global Const $5e = $5d & "akk.ini"
Global Const $5f = FileExists($5e)
Global Const $5g = "akkGlobalConfig.ini"
Global Const $5h = $4z
Global Const $5i = $5h & $5g
Global $5j = FileExists($5i)
Global Const $5k = $5g
Global Const $5l = $4w
Global Const $5m = $5l & $5k
Global Const $5n = FileExists($5m)
Global Const $5o = "akkGlobalConfigExtended.ini"
Global Const $5p = $5h
Global Const $5q = $5p & $5o
Global $5r = FileExists($5q)
Global Const $5s = $5o
Global Const $5t = $4w
Global Const $5u = $5t & $5s
Global Const $5v = FileExists($5u)
Global $5w
Global $5x = ""
Global Const $5y = $4z & "log\"
Global $5z = $5y & $5x
Global $60 = FileExists($5z)
If Not $60 Then DirCreate($5y)
Global $61 = ""
Global Const $62 = $4w & "log\" & @ComputerName & "\"
Global $63 = $62 & $61
Global $64 = FileExists($63)
If Not $64 Then DirCreate($62)
Global $65 = "akkGlobal.log"
Global Const $66 = $4w & "log\"
Global $67 = $66 & $65
Global $68 = FileExists($67)
Global $69 = ""
Global Const $6a = $4w & "log\_archive\"
Global $6b = $6a & $69
Global $6c = FileExists($6b)
If Not $6c Then DirCreate($6a)
Global Const $6d = $4w & "log\"
Global Const $6e = $6d & "akkGlobal.ini"
Global Const $6f = FileExists($6e)
Global Const $6g = $62
Global Const $6h = $6g & "akkMacro.ini"
Global Const $6i = FileExists($6h)
Global Const $6j = @UserProfileDir & "\Downloads"
Global Const $6k = $6j & " alt"
Global $6l[1][2]
Global $6m[1][2]
Global $6n[1][2]
Global $6o = ""
Global Const $6p = @ComputerName
Global $6q
Global $6r[10][2]
Global Const $6s = "wmi_exporter.exe"
Global Const $6t = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $6u = $6t & $6s
Global $6v = FileExists($6u)
Global Const $6w = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $6x = $4w & "wmi_exporter\"
Global Const $6y = $6x & $6w
Global Const $6z = FileExists($6y)
Global Const $70 = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $71 = $4w & "wmi_exporter\"
Global Const $72 = $71 & $70
Global Const $73 = FileExists($72)
Global Const $74 = "cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $75 = $6t & "textfile_inputs\"
Global Const $76 = $75
Global Const $77 = $76 & "metadata.prom"
Global $78 = FileExists($77)
Global $79
Global $7a[2]
Global $7b
Global Const $7c = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $74 & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $75
_2g("akk")
Sleep(5e3)
_7o()
_7m()
_7k("akk.exe läuft")
_7k($4g)
_7k($4j)
_7k($6u)
_7k("werden überwacht")
_7l()
_7n()
_7r()
_82()
_7v()
_80()
Sleep(5e3)
While 42
Sleep(10)
If(Mod($49, 300) = 0) Then
If _7q($4b, 15e3) Then _7s()
If _7q($4c, 60e3 * 5) Then _7l()
If _7q($4d, 60e3 * 5) Then _7m()
EndIf
$49 += 1
WEnd
Func _7k($7d)
$7d = StringFormat("%10s", $49) & " : " & $7d
ConsoleWrite(@CRLF & $7d)
_1s($5z, $7d)
_1s($63, $7d)
_1s($67, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $7d)
EndFunc
Func _7l()
If $5n And Not $5j Then
$5j = FileCopy($5m, $5i, 1 + 8)
EndIf
If $5v And Not $5r Then
$5r = FileCopy($5u, $5q, 1 + 8)
EndIf
If $5c And Not $58 Then
$58 = FileCopy($5b, $57, 1 + 8)
EndIf
Local $7e = FileGetTime($5i, 0, 1)
Local $7f = FileGetTime($5m, 0, 1)
If $7e <> $7f Then
$5j = FileCopy($5m, $5i, 1 + 8)
_7k("Reload Config " & $5m)
_7n()
EndIf
Local $7g = FileGetTime($5q, 0, 1)
Local $7h = FileGetTime($5u, 0, 1)
If $7g <> $7h Then
$5r = FileCopy($5u, $5q, 1 + 8)
_7k("Reload Config Ex" & $5u)
_7n()
_83()
EndIf
Local $7i = FileGetTime($57, 0, 1)
Local $7j = FileGetTime($5b, 0, 1)
If $7i <> $7j And @Compiled Then
$58 = FileCopy($5b, $57, 1 + 8)
_7k("Reload Akk Updater " & $5b)
EndIf
Local $7k = FileGetTime($50, 0, 1)
Local $7l = FileGetTime($53, 0, 1)
If $7k <> $7l And @Compiled Then
_7t($55, $56, $57, $58)
_7k("Reload Akk " & $53)
EndIf
EndFunc
Func _7m()
$5x = StringFormat("%04s", $5w) & ".log"
$5z = $5y & $5x
$63 = $62 & $5x
If _1i($5z) > 1e3 Then
$5w += 1
IniWrite($5e, "LogFile", "ID", $5w)
EndIf
IniWrite($5e, "LogFile", "LogPath", $5z)
IniWrite($5e, "LogFile", "LogNetPath", $63)
If FileGetSize($67) / 1024 > 100 Then
Local $7m = $6a & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($67, $7m, 1 + 8)
EndIf
EndFunc
Func _7n()
If FileExists($5i) Then
$6q = IniRead($5i, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $w = 0 To 9 Step 1
$6r[$w][0] = IniRead($5i, "FreeSpaceCheck", "Mail" & $w & "Address", "")
$6r[$w][1] = IniRead($5i, "FreeSpaceCheck", "Mail" & $w & "Active", 0)
Next
$6o = IniRead($5i, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($5q) Then
$79 = IniRead($5q, "MetaData", @ComputerName, "NULL")
If $79 = "NULL" Then
IniWrite($5u, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _7o()
$5w = IniRead($5e, "LogFile", "ID", "NULL")
If $5w = "NULL" Then
IniWrite($5e, "LogFile", "ID", 0)
$5w = 0
EndIf
EndFunc
Func _7q(ByRef $7n, $7o)
Local $7p = TimerDiff($7n)
If $7p > $7o Then
$7n = TimerInit()
Return $7p
EndIf
Return 0
EndFunc
Func _7r()
Local Const $7q = "|"
IniWrite($6e, "IPAddress1", @ComputerName, @IPAddress1)
IniWrite($6e, "AkkVersion", @ComputerName, FileGetVersion(@ScriptFullPath))
_e($6l, "Compiled" & $7q & @Compiled, 0, $7q)
_e($6l, "ScriptName" & $7q & @ScriptName, 0, $7q)
_e($6l, "ScriptDir" & $7q & @ScriptDir, 0, $7q)
_e($6l, "ScriptFullPath" & $7q & @ScriptFullPath, 0, $7q)
_e($6l, "WorkingDir" & $7q & @WorkingDir, 0, $7q)
_e($6l, "AutoItExe" & $7q & @AutoItExe, 0, $7q)
_e($6l, "AutoItPID" & $7q & @AutoItPID, 0, $7q)
_e($6l, "AutoItVersion" & $7q & @AutoItVersion, 0, $7q)
_e($6l, "AutoItX64" & $7q & @AutoItX64, 0, $7q)
IniWriteSection($6h, "MacroAutoIt", $6l)
_e($6m, "AppDataCommonDir" & $7q & @AppDataCommonDir, 0, $7q)
_e($6m, "DesktopCommonDir" & $7q & @DesktopCommonDir, 0, $7q)
_e($6m, "DocumentsCommonDir" & $7q & @DocumentsCommonDir, 0, $7q)
_e($6m, "FavoritesCommonDir" & $7q & @FavoritesCommonDir, 0, $7q)
_e($6m, "ProgramsCommonDir" & $7q & @ProgramsCommonDir, 0, $7q)
_e($6m, "StartMenuCommonDir" & $7q & @StartMenuCommonDir, 0, $7q)
_e($6m, "StartupCommonDir" & $7q & @StartupCommonDir, 0, $7q)
_e($6m, "AppDataDir" & $7q & @AppDataDir, 0, $7q)
_e($6m, "LocalAppDataDir" & $7q & @LocalAppDataDir, 0, $7q)
_e($6m, "DesktopDir" & $7q & @DesktopDir, 0, $7q)
_e($6m, "MyDocumentsDir" & $7q & @MyDocumentsDir, 0, $7q)
_e($6m, "FavoritesDir" & $7q & @FavoritesDir, 0, $7q)
_e($6m, "ProgramsDir" & $7q & @ProgramsDir, 0, $7q)
_e($6m, "StartMenuDir" & $7q & @StartMenuDir, 0, $7q)
_e($6m, "StartupDir" & $7q & @StartupDir, 0, $7q)
_e($6m, "UserProfileDir" & $7q & @UserProfileDir, 0, $7q)
_e($6m, "HomeDrive" & $7q & @HomeDrive, 0, $7q)
_e($6m, "HomePath" & $7q & @HomePath, 0, $7q)
_e($6m, "HomeShare" & $7q & @HomeShare, 0, $7q)
_e($6m, "LogonDNSDomain" & $7q & @LogonDNSDomain, 0, $7q)
_e($6m, "LogonDomain" & $7q & @LogonDomain, 0, $7q)
_e($6m, "LogonServer" & $7q & @LogonServer, 0, $7q)
_e($6m, "ProgramFilesDir" & $7q & @ProgramFilesDir, 0, $7q)
_e($6m, "CommonFilesDir" & $7q & @CommonFilesDir, 0, $7q)
_e($6m, "WindowsDir" & $7q & @WindowsDir, 0, $7q)
_e($6m, "SystemDir" & $7q & @SystemDir, 0, $7q)
_e($6m, "TempDir" & $7q & @TempDir, 0, $7q)
_e($6m, "ComSpec" & $7q & @ComSpec, 0, $7q)
IniWriteSection($6h, "MacroDirectory", $6m)
_e($6n, "CPUArch" & $7q & @CPUArch, 0, $7q)
_e($6n, "KBLayout" & $7q & @KBLayout, 0, $7q)
_e($6n, "MUILang" & $7q & @MUILang, 0, $7q)
_e($6n, "OSArch" & $7q & @OSArch, 0, $7q)
_e($6n, "OSLang" & $7q & @OSLang, 0, $7q)
_e($6n, "OSType" & $7q & @OSType, 0, $7q)
_e($6n, "OSVersion" & $7q & @OSVersion, 0, $7q)
_e($6n, "OSBuild" & $7q & @OSBuild, 0, $7q)
_e($6n, "OSServicePack" & $7q & @OSServicePack, 0, $7q)
_e($6n, "ComputerName" & $7q & @ComputerName, 0, $7q)
_e($6n, "UserName" & $7q & @UserName, 0, $7q)
_e($6n, "IPAddress1" & $7q & @IPAddress1, 0, $7q)
_e($6n, "IPAddress2" & $7q & @IPAddress2, 0, $7q)
_e($6n, "IPAddress3" & $7q & @IPAddress3, 0, $7q)
_e($6n, "IPAddress4" & $7q & @IPAddress4, 0, $7q)
_e($6n, "DesktopHeight" & $7q & @DesktopHeight, 0, $7q)
_e($6n, "DesktopWidth" & $7q & @DesktopWidth, 0, $7q)
_e($6n, "DesktopDepth" & $7q & @DesktopDepth, 0, $7q)
_e($6n, "DesktopRefresh" & $7q & @DesktopRefresh, 0, $7q)
IniWriteSection($6h, "MacroSystemInfo", $6n)
EndFunc
Func _7s()
_7t($4e, $4f, $4g, $4h)
_7t("KPSInfo.exe", $4i, $4j, $4k)
_7t($6s, $6t, $6u & $7c, $6v)
EndFunc
Func _7t($7r, $7s, $7t, $7u, $7v = @SW_HIDE)
If $7u And Not ProcessExists($7r) Then
_7k($7r & " wird gestartet")
Return Run($7t, $7s, $7v)
EndIf
Return 0
EndFunc
Func _7v()
If _7w() Then
DirRemove($6k, 1)
_7x($6j, $6k)
FileDelete($6k & "\Downloads alt.lnk")
FileCreateShortcut($6k, $6j & "\Downloads alt")
IniWrite($5e, "Downloads", "LastCleaningDate", _5t(@YEAR, @MON, @MDAY))
Local Const $7w = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $7w, $48) = 6 Then
ShellExecute($6k)
EndIf
EndIf
EndFunc
Func _7w()
Return(_5t(@YEAR, @MON, @MDAY) - _7y()) >= 14
EndFunc
Func _7x($7x, $7y)
If FileExists($7x) Then
If Not FileExists($7y) Then DirCreate($7y)
FileMove($7x & "\*.*", $7y, 1 + 8)
Local Const $7z = _1k($7x, Default, 2, True)
If Not @error Then
For $80 In $7z
DirMove($80, $7y, 1)
Next
EndIf
EndIf
EndFunc
Func _7y()
Return IniRead($5e, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _80()
Local Const $81 = DriveGetLabel(@HomeDrive & "\")
Local Const $82 = DriveSpaceFree(@HomeDrive & "\")
Local Const $83 = DriveSpaceTotal(@HomeDrive & "\")
Local Const $84 =($82 / $83) * 100
If $84 < $6q Then
If(_5t(@YEAR, @MON, @MDAY) - IniRead($5e, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($5e, "FreeSpaceCheck", "LastMailSendDate", _5t(@YEAR, @MON, @MDAY))
For $w = 0 To 9 Step 1
If $6r[$w][0] <> "" And $6r[$w][1] = 1 Then
_7k("Sending Mail to " & $6r[$w][0])
_81($6r[$w][0], Round($84, 2), $81, $82, $83)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _81($3l, $84, $81, $82, $83)
Local $3j = "akk.exe (Gerrit)"
Local $3k = "akk@kuechen-brauckhoff.de"
Local $3m = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $84 & "% !"
Local $85[0]
_e($85, "Akk Warnung wenig Speicherplatz auf:")
_e($85, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _e($85, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _e($85, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _e($85, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _e($85, @IPAddress4)
_e($85, $81 & " (" & @HomeDrive & ")")
_e($85, Round($82 / 1024, 2) & " GB frei von " & Round($83 / 1024, 2) & " GB")
_e($85, $84 & "% frei")
Local $86 = _7f($6o, $3j, $3k, $3l, $3m, $85, $6p, -1, 0)
Local $87 = @error
If $86 = 0 Then
Local Const $7w = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _15($85, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $87 & @CRLF
MsgBox(48 + 4096, "Warnung!", $7w)
EndIf
EndFunc
Func _82()
ProcessClose($6s)
If Not $6v Then
Local $88 =(@OSArch = "X64") ? $72 : $6y
If FileCopy($88, $6u, 1 + 8) Then
$6v = FileExists($6u)
EndIf
EndIf
If Not FileExists($75) Then DirCreate($75)
_83()
EndFunc
Func _83()
Local $89 = 'metadata{computername="' & @ComputerName & '"' & ',username="' & @UserName & '"'
If $79 <> "NULL" And StringLen($79) And Not StringIsSpace($79) Then
$89 &= "," & $79
EndIf
$89 &= '} 1'
$7a[1] = $89
$7a[0] = UBound($7a) - 1
_1q($77, $7b)
If Not $78 Or Not _84($7a, $7b, 3) Then
_1r($77, $7a, 1)
_7k("_FileWriteFromArray" & $77)
$78 = FileExists($77)
EndIf
EndFunc
Func _84(Const ByRef $8a, Const ByRef $8b, $8c = 0)
If Not(IsArray($8a)) Or Not(IsArray($8b)) Then
Return SetError(1, 0, 0)
EndIf
Local $1y = UBound($8a, 0)
If $1y <> UBound($8b, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $8d = UBound($8a, 1)
Local $8e = UBound($8a, 2)
If $8d <> UBound($8b, 1) Or $8e <> UBound($8b, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $8f, $8g
Switch $8c
Case 0
For $w = 0 To $8d - 1
For $13 = 0 To $8e - 1
If $8a[$w][$13] <> $8a[$w][$13] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case 1
For $w = 0 To $8d - 1
For $13 = 0 To $8e - 1
$8f &= $8a[$w][$13]
$8g &= $8b[$w][$13]
Next
If $8f <> $8g Then
Return SetError(4, 0, 0)
EndIf
Next
Case 2
For $13 = 0 To $8e - 1
For $w = 0 To $8d - 1
$8f &= $8a[$w][$13]
$8g &= $8b[$w][$13]
Next
If $8f <> $8g Then
Return SetError(4, 0, 0)
EndIf
Next
Case 3
If _15($8a) <> _15($8b) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
