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
Global $4e = $4a
Global $4f = 0
Global $4g = 1
Global Const $4h = "ShadowSpawn.exe"
Global Const $4i = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $4j = $4i & $4h
Global Const $4k = FileExists($4j)
Global Const $4l = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $4m = $4l & "KPSInfo.exe"
Global Const $4n = FileExists($4m)
Global Const $4o = "Powerkatalog-Schnittstelle.exe"
Global Const $4p = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $4q = $4p & $4o
Global Const $4r = FileExists($4q)
Global Const $4s = "SHDUpdater_min.exe"
Global Const $4t = @ProgramFilesDir & "\SHDUpdater\"
Global Const $4u = $4t & $4s
Global Const $4v = FileExists($4u)
Global Const $4w = "\\172.16.128.4\edv\Gerrit\"
Global Const $4x = $4w & ""
Global Const $4y = FileExists($4x)
Global Const $4z = $4w & "akk\"
Global Const $50 = $4z & ""
Global Const $51 = FileExists($50)
Global Const $52 = @ScriptDir & "\"
Global Const $53 = $52 & "akk.exe"
Global Const $54 = FileExists($53)
Global Const $55 = $4w
Global Const $56 = $55 & "akk.exe"
Global Const $57 = FileExists($56)
Global Const $58 = "akkUpdater.exe"
Global Const $59 = $52
Global Const $5a = $59 & $58
Global $5b = FileExists($5a)
Global Const $5c = $58
Global Const $5d = $4w
Global Const $5e = $5d & $5c
Global Const $5f = FileExists($5e)
Global Const $5g = $52
Global Const $5h = $5g & "akk.ini"
Global Const $5i = FileExists($5h)
Global Const $5j = "akkGlobalConfig.ini"
Global Const $5k = $52
Global Const $5l = $5k & $5j
Global $5m = FileExists($5l)
Global Const $5n = $5j
Global Const $5o = $4z
Global Const $5p = $5o & $5n
Global Const $5q = FileExists($5p)
Global Const $5r = "akkGlobalConfigExtended.ini"
Global Const $5s = $5k
Global Const $5t = $5s & $5r
Global $5u = FileExists($5t)
Global Const $5v = $5r
Global Const $5w = $4z
Global Const $5x = $5w & $5v
Global Const $5y = FileExists($5x)
Global $5z
Global $60 = ""
Global Const $61 = $52 & "log\"
Global $62 = $61 & $60
Global $63 = FileExists($62)
If Not $63 Then DirCreate($61)
Global $64 = ""
Global Const $65 = $4z & "log\" & @ComputerName & "\"
Global $66 = $65 & $64
Global $67 = FileExists($66)
If Not $67 Then DirCreate($65)
Global $68 = "akkGlobal.log"
Global Const $69 = $4z & "log\"
Global $6a = $69 & $68
Global $6b = FileExists($6a)
Global $6c = ""
Global Const $6d = $4z & "log\_archive\"
Global $6e = $6d & $6c
Global $6f = FileExists($6e)
If Not $6f Then DirCreate($6d)
Global Const $6g = $4z & "log\"
Global Const $6h = $6g & "akkGlobal.ini"
Global Const $6i = FileExists($6h)
Global Const $6j = $65
Global Const $6k = $6j & "akkMacro.ini"
Global Const $6l = FileExists($6k)
Global Const $6m = $52 & "log\"
Global Const $6n = $6m & "scrape.prom"
Global Const $6o = FileExists($6n)
Global Const $6p = $65
Global Const $6q = $6p & "scrape.prom"
Global Const $6r = FileExists($6q)
Global Const $6s = @UserProfileDir & "\Downloads"
Global Const $6t = $6s & " alt"
Global $6u[1][2]
Global $6v[1][2]
Global $6w[1][2]
Global $6x = ""
Global Const $6y = @ComputerName
Global $6z
Global $70[10][2]
Global Const $71 = "wmi_exporter.exe"
Global Const $72 = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $73 = $72 & $71
Global $74 = FileExists($73)
Global Const $75 = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $76 = $4z & "wmi_exporter\"
Global Const $77 = $76 & $75
Global Const $78 = FileExists($77)
Global Const $79 = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $7a = $4z & "wmi_exporter\"
Global Const $7b = $7a & $79
Global Const $7c = FileExists($7b)
Global Const $7d = "cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $7e = $72 & "textfile_inputs\"
Global Const $7f = $7e
Global Const $7g = $7f & "metadata.prom"
Global $7h = FileExists($7g)
Global $7i
Global $7j[2]
Global $7k
Global Const $7l = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $7d & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $7e
_2g("akk")
Sleep(5e3)
_7o()
_7m()
_7k("akk.exe läuft")
_7k($4j)
_7k($4m)
_7k($73)
_7k("werden überwacht")
_7l()
_7n()
_7r()
_84()
_7v()
_80()
Sleep(5e3)
While 42
Sleep(10)
If(Mod($49, 300) = 0) Then
If _7q($4b, 15e3 * 1) Then _7s()
If _7q($4c, 60e3 * 5) Then _7l()
If _7q($4d, 60e3 * 5) Then _7m()
If _7q($4e, 60e3 * 5) Then _82()
EndIf
If(Mod($49, 500) = 0) Then _83()
$49 += 1
WEnd
Func _7k($7m)
$7m = StringFormat("%10s", $49) & " : " & $7m
ConsoleWrite(@CRLF & $7m)
_1s($62, $7m)
_1s($66, $7m)
_1s($6a, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $7m)
EndFunc
Func _7l()
If $5q And Not $5m Then
$5m = FileCopy($5p, $5l, 1 + 8)
EndIf
If $5y And Not $5u Then
$5u = FileCopy($5x, $5t, 1 + 8)
EndIf
If $5f And Not $5b Then
$5b = FileCopy($5e, $5a, 1 + 8)
EndIf
Local $7n = FileGetTime($5l, 0, 1)
Local $7o = FileGetTime($5p, 0, 1)
If $7n <> $7o Then
$5m = FileCopy($5p, $5l, 1 + 8)
_7k("Reload Config " & $5p)
_7n()
EndIf
Local $7p = FileGetTime($5t, 0, 1)
Local $7q = FileGetTime($5x, 0, 1)
If $7p <> $7q Then
$5u = FileCopy($5x, $5t, 1 + 8)
_7k("Reload Config Ex" & $5x)
_7n()
_85()
EndIf
Local $7r = FileGetTime($5a, 0, 1)
Local $7s = FileGetTime($5e, 0, 1)
If $7r <> $7s And @Compiled Then
$5b = FileCopy($5e, $5a, 1 + 8)
_7k("Reload Akk Updater " & $5e)
EndIf
Local $7t = FileGetTime($53, 0, 1)
Local $7u = FileGetTime($56, 0, 1)
If $7t <> $7u And @Compiled Then
_7t($58, $59, $5a, $5b)
_7k("Reload Akk " & $56)
EndIf
EndFunc
Func _7m()
$60 = StringFormat("%04s", $5z) & ".log"
$62 = $61 & $60
$66 = $65 & $60
If _1i($62) > 1e3 Then
$5z += 1
IniWrite($5h, "LogFile", "ID", $5z)
EndIf
IniWrite($5h, "LogFile", "LogPath", $62)
IniWrite($5h, "LogFile", "LogNetPath", $66)
If FileGetSize($6a) / 1024 > 100 Then
Local $7v = $6d & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($6a, $7v, 1 + 8)
EndIf
EndFunc
Func _7n()
If FileExists($5l) Then
$6z = IniRead($5l, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $w = 0 To 9 Step 1
$70[$w][0] = IniRead($5l, "FreeSpaceCheck", "Mail" & $w & "Address", "")
$70[$w][1] = IniRead($5l, "FreeSpaceCheck", "Mail" & $w & "Active", 0)
Next
$6x = IniRead($5l, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($5t) Then
$7i = IniRead($5t, "MetaData", @ComputerName, "NULL")
If $7i = "NULL" Then
IniWrite($5x, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _7o()
$5z = IniRead($5h, "LogFile", "ID", "NULL")
If $5z = "NULL" Then
IniWrite($5h, "LogFile", "ID", 0)
$5z = 0
EndIf
EndFunc
Func _7q(ByRef $7w, $7x)
Local $7y = TimerDiff($7w)
If $7y > $7x Then
$7w = TimerInit()
Return $7y
EndIf
Return 0
EndFunc
Func _7r()
Local Const $7z = "|"
IniWrite($6h, "IPAddress1", @ComputerName, @IPAddress1)
IniWrite($6h, "AkkVersion", @ComputerName, FileGetVersion(@ScriptFullPath))
_e($6u, "Compiled" & $7z & @Compiled, 0, $7z)
_e($6u, "ScriptName" & $7z & @ScriptName, 0, $7z)
_e($6u, "ScriptDir" & $7z & @ScriptDir, 0, $7z)
_e($6u, "ScriptFullPath" & $7z & @ScriptFullPath, 0, $7z)
_e($6u, "WorkingDir" & $7z & @WorkingDir, 0, $7z)
_e($6u, "AutoItExe" & $7z & @AutoItExe, 0, $7z)
_e($6u, "AutoItPID" & $7z & @AutoItPID, 0, $7z)
_e($6u, "AutoItVersion" & $7z & @AutoItVersion, 0, $7z)
_e($6u, "AutoItX64" & $7z & @AutoItX64, 0, $7z)
IniWriteSection($6k, "MacroAutoIt", $6u)
_e($6v, "AppDataCommonDir" & $7z & @AppDataCommonDir, 0, $7z)
_e($6v, "DesktopCommonDir" & $7z & @DesktopCommonDir, 0, $7z)
_e($6v, "DocumentsCommonDir" & $7z & @DocumentsCommonDir, 0, $7z)
_e($6v, "FavoritesCommonDir" & $7z & @FavoritesCommonDir, 0, $7z)
_e($6v, "ProgramsCommonDir" & $7z & @ProgramsCommonDir, 0, $7z)
_e($6v, "StartMenuCommonDir" & $7z & @StartMenuCommonDir, 0, $7z)
_e($6v, "StartupCommonDir" & $7z & @StartupCommonDir, 0, $7z)
_e($6v, "AppDataDir" & $7z & @AppDataDir, 0, $7z)
_e($6v, "LocalAppDataDir" & $7z & @LocalAppDataDir, 0, $7z)
_e($6v, "DesktopDir" & $7z & @DesktopDir, 0, $7z)
_e($6v, "MyDocumentsDir" & $7z & @MyDocumentsDir, 0, $7z)
_e($6v, "FavoritesDir" & $7z & @FavoritesDir, 0, $7z)
_e($6v, "ProgramsDir" & $7z & @ProgramsDir, 0, $7z)
_e($6v, "StartMenuDir" & $7z & @StartMenuDir, 0, $7z)
_e($6v, "StartupDir" & $7z & @StartupDir, 0, $7z)
_e($6v, "UserProfileDir" & $7z & @UserProfileDir, 0, $7z)
_e($6v, "HomeDrive" & $7z & @HomeDrive, 0, $7z)
_e($6v, "HomePath" & $7z & @HomePath, 0, $7z)
_e($6v, "HomeShare" & $7z & @HomeShare, 0, $7z)
_e($6v, "LogonDNSDomain" & $7z & @LogonDNSDomain, 0, $7z)
_e($6v, "LogonDomain" & $7z & @LogonDomain, 0, $7z)
_e($6v, "LogonServer" & $7z & @LogonServer, 0, $7z)
_e($6v, "ProgramFilesDir" & $7z & @ProgramFilesDir, 0, $7z)
_e($6v, "CommonFilesDir" & $7z & @CommonFilesDir, 0, $7z)
_e($6v, "WindowsDir" & $7z & @WindowsDir, 0, $7z)
_e($6v, "SystemDir" & $7z & @SystemDir, 0, $7z)
_e($6v, "TempDir" & $7z & @TempDir, 0, $7z)
_e($6v, "ComSpec" & $7z & @ComSpec, 0, $7z)
IniWriteSection($6k, "MacroDirectory", $6v)
_e($6w, "CPUArch" & $7z & @CPUArch, 0, $7z)
_e($6w, "KBLayout" & $7z & @KBLayout, 0, $7z)
_e($6w, "MUILang" & $7z & @MUILang, 0, $7z)
_e($6w, "OSArch" & $7z & @OSArch, 0, $7z)
_e($6w, "OSLang" & $7z & @OSLang, 0, $7z)
_e($6w, "OSType" & $7z & @OSType, 0, $7z)
_e($6w, "OSVersion" & $7z & @OSVersion, 0, $7z)
_e($6w, "OSBuild" & $7z & @OSBuild, 0, $7z)
_e($6w, "OSServicePack" & $7z & @OSServicePack, 0, $7z)
_e($6w, "ComputerName" & $7z & @ComputerName, 0, $7z)
_e($6w, "UserName" & $7z & @UserName, 0, $7z)
_e($6w, "IPAddress1" & $7z & @IPAddress1, 0, $7z)
_e($6w, "IPAddress2" & $7z & @IPAddress2, 0, $7z)
_e($6w, "IPAddress3" & $7z & @IPAddress3, 0, $7z)
_e($6w, "IPAddress4" & $7z & @IPAddress4, 0, $7z)
_e($6w, "DesktopHeight" & $7z & @DesktopHeight, 0, $7z)
_e($6w, "DesktopWidth" & $7z & @DesktopWidth, 0, $7z)
_e($6w, "DesktopDepth" & $7z & @DesktopDepth, 0, $7z)
_e($6w, "DesktopRefresh" & $7z & @DesktopRefresh, 0, $7z)
IniWriteSection($6k, "MacroSystemInfo", $6w)
EndFunc
Func _7s()
_7t($4h, $4i, $4j, $4k)
_7t("KPSInfo.exe", $4l, $4m, $4n)
_7t($71, $72, $73 & $7l, $74)
EndFunc
Func _7t($80, $81, $82, $83, $84 = @SW_HIDE)
If $83 And Not ProcessExists($80) Then
_7k($80 & " wird gestartet")
Return Run($82, $81, $84)
EndIf
Return 0
EndFunc
Func _7v()
If _7w() Then
DirRemove($6t, 1)
_7x($6s, $6t)
FileDelete($6t & "\Downloads alt.lnk")
FileCreateShortcut($6t, $6s & "\Downloads alt")
IniWrite($5h, "Downloads", "LastCleaningDate", _5t(@YEAR, @MON, @MDAY))
Local Const $85 = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $85, $48) = 6 Then
ShellExecute($6t)
EndIf
EndIf
EndFunc
Func _7w()
Return(_5t(@YEAR, @MON, @MDAY) - _7y()) >= 14
EndFunc
Func _7x($86, $87)
If FileExists($86) Then
If Not FileExists($87) Then DirCreate($87)
FileMove($86 & "\*.*", $87, 1 + 8)
Local Const $88 = _1k($86, Default, 2, True)
If Not @error Then
For $89 In $88
DirMove($89, $87, 1)
Next
EndIf
EndIf
EndFunc
Func _7y()
Return IniRead($5h, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _80()
Local Const $8a = DriveGetLabel(@HomeDrive & "\")
Local Const $8b = DriveSpaceFree(@HomeDrive & "\")
Local Const $8c = DriveSpaceTotal(@HomeDrive & "\")
Local Const $8d =($8b / $8c) * 100
If $8d < $6z Then
If(_5t(@YEAR, @MON, @MDAY) - IniRead($5h, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($5h, "FreeSpaceCheck", "LastMailSendDate", _5t(@YEAR, @MON, @MDAY))
For $w = 0 To 9 Step 1
If $70[$w][0] <> "" And $70[$w][1] = 1 Then
_7k("Sending Mail to " & $70[$w][0])
_81($70[$w][0], Round($8d, 2), $8a, $8b, $8c)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _81($3l, $8d, $8a, $8b, $8c)
Local $3j = "akk.exe (Gerrit)"
Local $3k = "akk@kuechen-brauckhoff.de"
Local $3m = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $8d & "% !"
Local $8e[0]
_e($8e, "Akk Warnung wenig Speicherplatz auf:")
_e($8e, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _e($8e, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _e($8e, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _e($8e, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _e($8e, @IPAddress4)
_e($8e, $8a & " (" & @HomeDrive & ")")
_e($8e, Round($8b / 1024, 2) & " GB frei von " & Round($8c / 1024, 2) & " GB")
_e($8e, $8d & "% frei")
Local $8f = _7f($6x, $3j, $3k, $3l, $3m, $8e, $6y, -1, 0)
Local $8g = @error
If $8f = 0 Then
Local Const $85 = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _15($8e, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $8g & @CRLF
MsgBox(48 + 4096, "Warnung!", $85)
EndIf
EndFunc
Func _82()
If $4g And ProcessExists($71) Then
$4f = InetGet("http://localhost:9182/metrics", $6n, 1, 1)
$4g = 0
EndIf
EndFunc
Func _83()
If Not $4g Then
If InetGetInfo($4f, 2) Then
Local $8h = InetGetInfo($4f)
If Not @error And $8h[3] Then
If FileGetSize($6n) Then FileCopy($6n, $6q, 1 + 8)
Else
FileDelete($6n)
_7k("Error ScrapeDownload")
EndIf
InetClose($4f)
$4f = 0
$4g = 1
EndIf
EndIf
EndFunc
Func _84()
ProcessClose($71)
If Not $74 Then
Local $8i =(@OSArch = "X64") ? $7b : $77
If FileCopy($8i, $73, 1 + 8) Then
$74 = FileExists($73)
EndIf
EndIf
If Not FileExists($7e) Then DirCreate($7e)
_85()
EndFunc
Func _85()
Local $8j = 'metadata{computername="' & @ComputerName & '"' & ',username="' & @UserName & '"'
If $7i <> "NULL" And StringLen($7i) And Not StringIsSpace($7i) Then
$8j &= "," & $7i
EndIf
$8j &= '} 1'
$7j[1] = $8j
$7j[0] = UBound($7j) - 1
_1q($7g, $7k)
If Not $7h Or Not _86($7j, $7k, 3) Then
_1r($7g, $7j, 1)
_7k("_FileWriteFromArray" & $7g)
$7h = FileExists($7g)
EndIf
EndFunc
Func _86(Const ByRef $8k, Const ByRef $8l, $8m = 0)
If Not(IsArray($8k)) Or Not(IsArray($8l)) Then
Return SetError(1, 0, 0)
EndIf
Local $1y = UBound($8k, 0)
If $1y <> UBound($8l, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $8n = UBound($8k, 1)
Local $8o = UBound($8k, 2)
If $8n <> UBound($8l, 1) Or $8o <> UBound($8l, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $8p, $8q
Switch $8m
Case 0
For $w = 0 To $8n - 1
For $13 = 0 To $8o - 1
If $8k[$w][$13] <> $8k[$w][$13] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case 1
For $w = 0 To $8n - 1
For $13 = 0 To $8o - 1
$8p &= $8k[$w][$13]
$8q &= $8l[$w][$13]
Next
If $8p <> $8q Then
Return SetError(4, 0, 0)
EndIf
Next
Case 2
For $13 = 0 To $8o - 1
For $w = 0 To $8n - 1
$8p &= $8k[$w][$13]
$8q &= $8l[$w][$13]
Next
If $8p <> $8q Then
Return SetError(4, 0, 0)
EndIf
Next
Case 3
If _15($8k) <> _15($8l) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
