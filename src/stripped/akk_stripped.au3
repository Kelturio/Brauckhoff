Global Const $0 = '{66087055-AD66-4C7C-9A18-38A2310B8337}'
Global Const $1 = '{E09D739D-CCD4-44EE-8EBA-3FBF8BE4FC58}'
Global Const $2 = '{1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}'
Global Const $3 = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $4 = "struct;word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds;endstruct"
Global Const $5 = "struct;long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias;endstruct"
Global Const $6 = "struct;byte GUID[16];ulong NumberOfValues;ulong Type;ptr Values;endstruct"
Global Const $7 = "uint Count;" & $6
Global Const $8 = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $9 = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & "ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $a = "struct;ulong Data1;ushort Data2;ushort Data3;byte Data4[8];endstruct"
Global Const $b = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $c = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $d = "dword Size;dword Flags;handle hCursor;" & "struct;long X;long Y;endstruct"
Global Const $e = _l()
Func _2()
Local $f = DllStructCreate($d)
Local $g = DllStructGetSize($f)
DllStructSetData($f, "Size", $g)
Local $h = DllCall("user32.dll", "bool", "GetCursorInfo", "struct*", $f)
If @error Or Not $h[0] Then Return SetError(@error + 10, @extended, 0)
Local $i[5]
$i[0] = True
$i[1] = DllStructGetData($f, "Flags") <> 0
$i[2] = DllStructGetData($f, "hCursor")
$i[3] = DllStructGetData($f, "X")
$i[4] = DllStructGetData($f, "Y")
Return $i
EndFunc
Func _l()
Local $j = DllStructCreate($c)
DllStructSetData($j, 1, DllStructGetSize($j))
Local $h = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $j)
If @error Or Not $h[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($j, 2), -8), DllStructGetData($j, 3))
EndFunc
Func _14($k)
Local $l = DllStructCreate($a)
_15($k, $l)
If @error Then Return SetError(@error + 10, @extended, 0)
Return $l
EndFunc
Func _15($k, $l)
Local $m = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $k, "struct*", $l)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _1x($l)
Local $m = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $l, "wstr", "", "int", 40)
If @error Or Not $m[0] Then Return SetError(@error, @extended, "")
Return SetExtended($m[0], $m[2])
EndFunc
Func _22($n, $o = 0, $p = True, $q = False)
Local $r = "wstr"
If Not IsString($n) Then $r = "struct*"
Local $m = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $o, "dword", 0, $r, $n, "int", -1, "ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
If @error Or Not $m[0] Then Return SetError(@error + 20, @extended, "")
Local $s = DllStructCreate((($q) ?("byte") :("char")) & "[" & $m[0] & "]")
$m = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $o, "dword", 0, $r, $n, "int", -1, "struct*", $s, "int", $m[0], "ptr", 0, "ptr", 0)
If @error Or Not $m[0] Then Return SetError(@error + 10, @extended, "")
If $p Then Return DllStructGetData($s, 1)
Return $s
EndFunc
Func _2h($t)
Local $m = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $t)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _2r($u, $v)
Local $m = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $u, "handle", $v)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _3x($w, $x, $y, $0z, $10, $11, $12, $13, $14)
Local $m = DllCall("gdi32.dll", "bool", "BitBlt", "handle", $w, "int", $x, "int", $y, "int", $0z, "int", $10, "handle", $11, "int", $12, "int", $13, "dword", $14)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _43($u, $0z, $10)
Local $m = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $u, "int", $0z, "int", $10)
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _4p($u)
Local $m = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $u)
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _4q($u)
Local $m = DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $u)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _4t($u, $15, $16, $17)
Local $m = DllCall("user32.dll", "bool", "DrawIcon", "handle", $u, "int", $15, "int", $16, "handle", $17)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _50($18)
Local $m = DllCall("user32.dll", "handle", "GetDC", "hwnd", $18)
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _56($18, $u)
Local $m = DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $18, "handle", $u)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Global Const $19 = "bool Icon;dword XHotSpot;dword YHotSpot;handle hMask;handle hColor"
Func _5f($17)
Local $m = DllCall("user32.dll", "handle", "CopyIcon", "handle", $17)
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _5l($17)
Local $m = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $17)
If @error Then Return SetError(@error, @extended, False)
Return $m[0]
EndFunc
Func _5q($17)
Local $1a = DllStructCreate($19)
Local $h = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $17, "struct*", $1a)
If @error Or Not $h[0] Then Return SetError(@error + 10, @extended, 0)
Local $1b[6]
$1b[0] = True
$1b[1] = DllStructGetData($1a, "Icon") <> 0
$1b[2] = DllStructGetData($1a, "XHotSpot")
$1b[3] = DllStructGetData($1a, "YHotSpot")
$1b[4] = DllStructGetData($1a, "hMask")
$1b[5] = DllStructGetData($1a, "hColor")
Return $1b
EndFunc
Global $1c = 0
Global $1d = 0
Global $1e = 0
Global $1f = True
Func _ce($1g, $1h, $1i, $1j, $1k, $1l = 0x00021808)
Local $m = DllCall($1c, "int", "GdipCloneBitmapArea", "float", $1h, "float", $1i, "float", $1j, "float", $1k, "int", $1l, "handle", $1g, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $m[0] Then Return SetError(10, $m[0], 0)
Return $m[7]
EndFunc
Func _ci($1g, $1m = 0)
Local $m = DllCall($1c, "int", "GdipCreateBitmapFromHBITMAP", "handle", $1g, "handle", $1m, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $m[0] Then Return SetError(10, $m[0], 0)
Return $m[3]
EndFunc
Func _dh()
Local $1n = _dj()
Local $1o = _dm()
Local $1p = DllStructCreate("byte[" & $1o & "]")
Local $m = DllCall($1c, "int", "GdipGetImageEncoders", "uint", $1n, "uint", $1o, "struct*", $1p)
If @error Then Return SetError(@error, @extended, 0)
If $m[0] Then Return SetError(10, $m[0], 0)
Local $1q = DllStructGetPtr($1p)
Local $1r, $1s[$1n + 1][14]
$1s[0][0] = $1n
For $1t = 1 To $1n
$1r = DllStructCreate($9, $1q)
$1s[$1t][1] = _1x(DllStructGetPtr($1r, "CLSID"))
$1s[$1t][2] = _1x(DllStructGetPtr($1r, "FormatID"))
$1s[$1t][3] = _22(DllStructGetData($1r, "CodecName"))
$1s[$1t][4] = _22(DllStructGetData($1r, "DllName"))
$1s[$1t][5] = _22(DllStructGetData($1r, "FormatDesc"))
$1s[$1t][6] = _22(DllStructGetData($1r, "FileExt"))
$1s[$1t][7] = _22(DllStructGetData($1r, "MimeType"))
$1s[$1t][8] = DllStructGetData($1r, "Flags")
$1s[$1t][9] = DllStructGetData($1r, "Version")
$1s[$1t][10] = DllStructGetData($1r, "SigCount")
$1s[$1t][11] = DllStructGetData($1r, "SigSize")
$1s[$1t][12] = DllStructGetData($1r, "SigPattern")
$1s[$1t][13] = DllStructGetData($1r, "SigMask")
$1q += DllStructGetSize($1r)
Next
Return $1s
EndFunc
Func _di($1u)
Local $1v = _dh()
If @error Then Return SetError(@error, 0, "")
For $1t = 1 To $1v[0][0]
If StringInStr($1v[$1t][6], "*." & $1u) > 0 Then Return $1v[$1t][1]
Next
Return SetError(-1, -1, "")
EndFunc
Func _dj()
Local $m = DllCall($1c, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $m[0] Then Return SetError(10, $m[0], -1)
Return $m[1]
EndFunc
Func _dm()
Local $m = DllCall($1c, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $m[0] Then Return SetError(10, $m[0], -1)
Return $m[2]
EndFunc
Func _fv($1w)
Local $m = DllCall($1c, "int", "GdipDisposeImage", "handle", $1w)
If @error Then Return SetError(@error, @extended, False)
If $m[0] Then Return SetError(10, $m[0], False)
Return True
EndFunc
Func _g0($1w)
Local $m = DllCall($1c, "int", "GdipGetImageHeight", "handle", $1w, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $m[0] Then Return SetError(10, $m[0], -1)
Return $m[2]
EndFunc
Func _gb($1w)
Local $m = DllCall($1c, "int", "GdipGetImageWidth", "handle", $1w, "uint*", -1)
If @error Then Return SetError(@error, @extended, -1)
If $m[0] Then Return SetError(10, $m[0], -1)
Return $m[2]
EndFunc
Func _gi($1w, $1x, $1y, $1z = 0)
Local $l = _14($1y)
Local $m = DllCall($1c, "int", "GdipSaveImageToFile", "handle", $1w, "wstr", $1x, "struct*", $l, "struct*", $1z)
If @error Then Return SetError(@error, @extended, False)
If $m[0] Then Return SetError(10, $m[0], False)
Return True
EndFunc
Func _he(ByRef $1z, $k, $20, $21, $22)
Local $1n = DllStructGetData($1z, "Count")
Local $23 = DllStructGetPtr($1z, "GUID") +($1n * _hg())
Local $24 = DllStructCreate($6, $23)
_15($k, $23)
DllStructSetData($24, "Type", $21)
DllStructSetData($24, "NumberOfValues", $20)
DllStructSetData($24, "Values", $22)
DllStructSetData($1z, "Count", $1n + 1)
EndFunc
Func _hf($1n)
Local $25 = $7
For $26 = 2 To $1n
$25 &= ";struct;byte[16];ulong;ulong;ptr;endstruct"
Next
Return DllStructCreate($25)
EndFunc
Func _hg()
Local $24 = DllStructCreate($6)
Return DllStructGetSize($24)
EndFunc
Func _kg()
If $1c = 0 Then Return SetError(-1, -1, False)
$1d -= 1
If $1d = 0 Then
DllCall($1c, "none", "GdiplusShutdown", "ulong_ptr", $1e)
DllClose($1c)
$1c = 0
EndIf
Return True
EndFunc
Func _kh($27 = Default, $28 = False)
$1d += 1
If $1d > 1 Then Return True
If $27 = Default Then $27 = "gdiplus.dll"
$1c = DllOpen($27)
If $1c = -1 Then
$1d = 0
Return SetError(1, 2, False)
EndIf
Local $29 = FileGetVersion($27)
$29 = StringSplit($29, ".")
If $29[1] > 5 Then $1f = False
Local $2a = DllStructCreate($8)
Local $2b = DllStructCreate("ulong_ptr Data")
DllStructSetData($2a, "Version", 1)
Local $m = DllCall($1c, "int", "GdiplusStartup", "struct*", $2b, "struct*", $2a, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $m[0] Then Return SetError(10, $m[0], False)
$1e = DllStructGetData($2b, "Data")
If $28 Then Return $1c
Return SetExtended($29[1], True)
EndFunc
Func _kt($1x, $2c = True)
Local $2d = _ku(".\:", $1x)
If($2d > 0) And(StringMid($1x, $2d, 1) = '.') Then
If $2c Then
Return StringMid($1x, $2d + 1)
Else
Return StringMid($1x, $2d)
EndIf
Else
Return ""
EndIf
EndFunc
Func _ku($2e, $2f)
Local $2g, $2h
For $1t = 1 To StringLen($2e)
$2g = StringMid($2e, $1t, 1)
$2h = StringInStr($2f, $2g, 2, -1)
If $2h > 0 Then Return $2h
Next
EndFunc
Func _ls()
Local $m = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _m2($2d)
Local $m = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $2d)
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _m6($18)
Local $2i = DllStructCreate($3)
Local $h = DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $18, "struct*", $2i)
If @error Or Not $h[0] Then Return SetError(@error + 10, @extended, 0)
Return $2i
EndFunc
Global $2j = 0x00021808
Global $2k = 100
Global $2l = 24
Global $2m = 2
Global Const $2n = 0x00CC0020
Func _mq($1x = "", $2o = 0, $2p = 0, $2q = -1, $2r = -1, $2s = True)
Local $2t = False
If $2q = -1 Then $2q = _m2(0) - 1
If $2r = -1 Then $2r = _m2(1) - 1
If $2q < $2o Then Return SetError(-1, 0, $2t)
If $2r < $2p Then Return SetError(-2, 0, $2t)
Local $2u =($2q - $2o) + 1
Local $2v =($2r - $2p) + 1
Local $18 = _ls()
Local $2w = _50($18)
Local $2x = _4p($2w)
Local $2y = _43($2w, $2u, $2v)
_2r($2x, $2y)
_3x($2x, 0, 0, $2u, $2v, $2w, $2o, $2p, $2n)
If $2s Then
Local $i = _2()
If Not @error And $i[1] Then
$2s = True
Local $17 = _5f($i[2])
Local $1b = _5q($17)
If Not @error Then
_2h($1b[4])
If $1b[5] <> 0 Then _2h($1b[5])
_4t($2x, $i[3] - $1b[2] - $2o, $i[4] - $1b[3] - $2p, $17)
EndIf
_5l($17)
EndIf
EndIf
_56($18, $2w)
_4q($2x)
If $1x = "" Then Return $2y
$2t = _ms($1x, $2y, True)
Return SetError(@error, @extended, $2t)
EndFunc
Func _mr($1x, $18, $2o = 0, $2p = 0, $2q = -1, $2r = -1, $2s = True)
If Not IsHWnd($18) Then $18 = WinGetHandle($18)
Local $2i = DllStructCreate($3)
Local Const $2z = 9
Local $2t = DllCall("dwmapi.dll", "long", "DwmGetWindowAttribute", "hwnd", $18, "dword", $2z, "struct*", $2i, "dword", DllStructGetSize($2i))
If(@error Or $2t[0] Or(Abs(DllStructGetData($2i, "Left")) + Abs(DllStructGetData($2i, "Top")) + Abs(DllStructGetData($2i, "Right")) + Abs(DllStructGetData($2i, "Bottom"))) = 0) Then
$2i = _m6($18)
If @error Then Return SetError(@error + 10, @extended, False)
EndIf
$2o += DllStructGetData($2i, "Left")
$2p += DllStructGetData($2i, "Top")
If $2q = -1 Then $2q = DllStructGetData($2i, "Right") - DllStructGetData($2i, "Left") - 1
If $2r = -1 Then $2r = DllStructGetData($2i, "Bottom") - DllStructGetData($2i, "Top") - 1
$2q += DllStructGetData($2i, "Left")
$2r += DllStructGetData($2i, "Top")
If $2o > DllStructGetData($2i, "Right") Then $2o = DllStructGetData($2i, "Left")
If $2p > DllStructGetData($2i, "Bottom") Then $2p = DllStructGetData($2i, "Top")
If $2q > DllStructGetData($2i, "Right") Then $2q = DllStructGetData($2i, "Right") - 1
If $2r > DllStructGetData($2i, "Bottom") Then $2r = DllStructGetData($2i, "Bottom") - 1
$2t = _mq($1x, $2o, $2p, $2q, $2r, $2s)
Return SetError(@error, @extended, $2t)
EndFunc
Func _ms($1x, $1g, $30 = True)
_kh()
If @error Then Return SetError(-1, -1, False)
Local $31 = StringUpper(_kt($1x))
Local $32 = _di($31)
If $32 = "" Then Return SetError(-2, -2, False)
Local $1w = _ci($1g)
If @error Then Return SetError(-3, -3, False)
Local $33, $1z
Switch $31
Case "BMP"
Local $15 = _gb($1w)
Local $16 = _g0($1w)
Local $34 = _ce($1w, 0, 0, $15, $16, $2j)
_fv($1w)
$1w = $34
Case "JPG", "JPEG"
$1z = _hf(1)
$33 = DllStructCreate("int Quality")
DllStructSetData($33, "Quality", $2k)
_he($1z, $2, 1, 4, DllStructGetPtr($33))
Case "TIF", "TIFF"
$1z = _hf(2)
$33 = DllStructCreate("int ColorDepth;int Compression")
DllStructSetData($33, "ColorDepth", $2l)
DllStructSetData($33, "Compression", $2m)
_he($1z, $0, 1, 4, DllStructGetPtr($33, "ColorDepth"))
_he($1z, $1, 1, 4, DllStructGetPtr($33, "Compression"))
EndSwitch
Local $35 = 0
If IsDllStruct($1z) Then $35 = $1z
Local $2t = _gi($1w, $1x, $32, $35)
_fv($1w)
If $30 Then _2h($1g)
_kg()
Return SetError($2t = False, 0, $2t)
EndFunc
Global Enum $36, $37, $38, $39, $3a, $3b, $3c
Global Const $3d = 0x007F
Func _o0($3e = 0, $3f = 0, $3g = 0, $3h = '')
If Not $3e Then $3e = 0x0400
Local $3i = 'wstr'
If Not StringStripWS($3h, 1 + 2) Then
$3i = 'ptr'
$3h = 0
EndIf
Local $h = DllCall('kernel32.dll', 'int', 'GetDateFormatW', 'dword', $3e, 'dword', $3g, 'struct*', $3f, $3i, $3h, 'wstr', '', 'int', 2048)
If @error Or Not $h[0] Then Return SetError(@error, @extended, '')
Return $h[5]
EndFunc
Func _oo($3j, $1l = Default)
Local Const $3k = 128
If $1l = Default Then $1l = 0
$3j = Int($3j)
If $3j < 1 Or $3j > 7 Then Return SetError(1, 0, "")
Local $3f = DllStructCreate($4)
DllStructSetData($3f, "Year", BitAND($1l, $3k) ? 2007 : 2006)
DllStructSetData($3f, "Month", 1)
DllStructSetData($3f, "Day", $3j)
Return _o0(BitAND($1l, 2) ? 0x0400 : $3d, $3f, 0, BitAND($1l, 1) ? "ddd" : "dddd")
EndFunc
Func _or($3l)
If StringIsInt($3l) Then
Select
Case Mod($3l, 4) = 0 And Mod($3l, 100) <> 0
Return 1
Case Mod($3l, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1, 0, 0)
EndFunc
Func _os($3m)
$3m = Int($3m)
Return $3m >= 1 And $3m <= 12
EndFunc
Func _ot($3n)
Local $3o[4], $3p[4]
_p2($3n, $3o, $3p)
If Not StringIsInt($3o[1]) Then Return 0
If Not StringIsInt($3o[2]) Then Return 0
If Not StringIsInt($3o[3]) Then Return 0
$3o[1] = Int($3o[1])
$3o[2] = Int($3o[2])
$3o[3] = Int($3o[3])
Local $3q = _pl($3o[1])
If $3o[1] < 1000 Or $3o[1] > 2999 Then Return 0
If $3o[2] < 1 Or $3o[2] > 12 Then Return 0
If $3o[3] < 1 Or $3o[3] > $3q[$3o[2]] Then Return 0
If $3p[0] < 1 Then Return 1
If $3p[0] < 2 Then Return 0
If $3p[0] = 2 Then $3p[3] = "00"
If Not StringIsInt($3p[1]) Then Return 0
If Not StringIsInt($3p[2]) Then Return 0
If Not StringIsInt($3p[3]) Then Return 0
$3p[1] = Int($3p[1])
$3p[2] = Int($3p[2])
$3p[3] = Int($3p[3])
If $3p[1] < 0 Or $3p[1] > 23 Then Return 0
If $3p[2] < 0 Or $3p[2] > 59 Then Return 0
If $3p[3] < 0 Or $3p[3] > 59 Then Return 0
Return 1
EndFunc
Func _p2($3n, ByRef $3r, ByRef $3s)
Local $3t = StringSplit($3n, " T")
If $3t[0] > 0 Then $3r = StringSplit($3t[1], "/-.")
If $3t[0] > 1 Then
$3s = StringSplit($3t[2], ":")
If UBound($3s) < 4 Then ReDim $3s[4]
Else
Dim $3s[4]
EndIf
If UBound($3r) < 4 Then ReDim $3r[4]
For $3u = 1 To 3
If StringIsInt($3r[$3u]) Then
$3r[$3u] = Int($3r[$3u])
Else
$3r[$3u] = -1
EndIf
If StringIsInt($3s[$3u]) Then
$3s[$3u] = Int($3s[$3u])
Else
$3s[$3u] = 0
EndIf
Next
Return 1
EndFunc
Func _p5($3l, $3v, $3w)
If Not _ot(StringFormat("%04d/%02d/%02d", $3l, $3v, $3w)) Then
Return SetError(1, 0, "")
EndIf
If $3v < 3 Then
$3v = $3v + 12
$3l = $3l - 1
EndIf
Local $3x = Int($3l / 100)
Local $3y = Int($3x / 4)
Local $3z = 2 - $3x + $3y
Local $40 = Int(1461 *($3l + 4716) / 4)
Local $41 = Int(153 *($3v + 1) / 5)
Local $42 = $3z + $3w + $40 + $41 - 1524.5
Return $42
EndFunc
Func _p6($43, $1l = Default)
If $1l = Default Then $1l = 0
$43 = Int($43)
If Not _os($43) Then Return SetError(1, 0, "")
Local $3f = DllStructCreate($4)
DllStructSetData($3f, "Year", @YEAR)
DllStructSetData($3f, "Month", $43)
DllStructSetData($3f, "Day", 1)
Return _o0(BitAND($1l, 2) ? 0x0400 : $3d, $3f, 0, BitAND($1l, 1) ? "MMM" : "MMMM")
EndFunc
Func _pl($3l)
Local $44 = [12, 31,(_or($3l) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Return $44
EndFunc
Func _pm($45)
Local $46 = DllStructCreate($4, $45)
Local $47 = DllStructCreate($4)
DllStructSetData($47, "Month", DllStructGetData($46, "Month"))
DllStructSetData($47, "Day", DllStructGetData($46, "Day"))
DllStructSetData($47, "Year", DllStructGetData($46, "Year"))
DllStructSetData($47, "Hour", DllStructGetData($46, "Hour"))
DllStructSetData($47, "Minute", DllStructGetData($46, "Minute"))
DllStructSetData($47, "Second", DllStructGetData($46, "Second"))
DllStructSetData($47, "MSeconds", DllStructGetData($46, "MSeconds"))
DllStructSetData($47, "DOW", DllStructGetData($46, "DOW"))
Return $47
EndFunc
Func _q9()
Local $48 = DllStructCreate($5)
Local $m = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "struct*", $48)
If @error Or $m[0] = -1 Then Return SetError(@error, @extended, 0)
Local $1s[8]
$1s[0] = $m[0]
$1s[1] = DllStructGetData($48, "Bias")
$1s[2] = DllStructGetData($48, "StdName")
$1s[3] = _pm(DllStructGetPtr($48, "StdDate"))
$1s[4] = DllStructGetData($48, "StdBias")
$1s[5] = DllStructGetData($48, "DayName")
$1s[6] = _pm(DllStructGetPtr($48, "DayDate"))
$1s[7] = DllStructGetData($48, "DayBias")
Return $1s
EndFunc
Global $49
Func _wn($4a)
Local $m = DllCall("advapi32.dll", "bool", "CloseEventLog", "handle", $4a)
If @error Then Return SetError(@error, @extended, False)
Return $m[0] <> 0
EndFunc
Func _wo($4a)
Local $m = DllCall("advapi32.dll", "bool", "GetNumberOfEventLogRecords", "handle", $4a, "dword*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $m[0] = 0 Then Return -1
Return $m[2]
EndFunc
Func _x1($4a)
Local $m = DllCall("advapi32.dll", "bool", "GetEventLogInformation", "handle", $4a, "dword", 0, "dword*", 0, "dword", 4, "dword*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $m[3] <> 0
EndFunc
Func _x3($4a)
Local $m = DllCall("advapi32.dll", "bool", "GetOldestEventLogRecord", "handle", $4a, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return $m[2]
EndFunc
Func _x4($4b, $4c)
$49 = $4c
Local $m = DllCall("advapi32.dll", "handle", "OpenEventLogW", "wstr", $4b, "wstr", $4c)
If @error Then Return SetError(@error, @extended, 0)
Return $m[0]
EndFunc
Func _xa()
Local $4d = DllStructCreate("uint;dword")
DllStructSetData($4d, 1, DllStructGetSize($4d))
Local $m = DllCall("user32.dll", "bool", "GetLastInputInfo", "struct*", $4d)
If @error Or $m[0] = 0 Then Return SetError(@error, @extended, 0)
Local $4e = DllCall("kernel32.dll", "dword", "GetTickCount")
If @error Or Not $m[0] Then Return SetError(@error, @extended, 0)
Local $4f = $4e[0] - DllStructGetData($4d, 2)
If $4f < 0 Then Return SetExtended(1, $4e[0])
Return $4f
EndFunc
Global $4g[11]
Global Const $4h = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($4i, $4j, $18)
If $4g[3] = $4g[4] Then
If Not $4g[7] Then
$4g[5] *= -1
$4g[7] = 1
EndIf
Else
$4g[7] = 1
EndIf
$4g[6] = $4g[3]
Local $4k = _xs($18, $4i, $4g[3])
Local $4l = _xs($18, $4j, $4g[3])
If $4g[8] = 1 Then
If(StringIsFloat($4k) Or StringIsInt($4k)) Then $4k = Number($4k)
If(StringIsFloat($4l) Or StringIsInt($4l)) Then $4l = Number($4l)
EndIf
Local $4m
If $4g[8] < 2 Then
$4m = 0
If $4k < $4l Then
$4m = -1
ElseIf $4k > $4l Then
$4m = 1
EndIf
Else
$4m = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $4k, 'wstr', $4l)[0]
EndIf
$4m = $4m * $4g[5]
Return $4m
EndFunc
Func _xs($18, $2d, $4n = 0)
Local $1p = DllStructCreate("wchar Text[4096]")
Local $1q = DllStructGetPtr($1p)
Local $4o = DllStructCreate($4h)
DllStructSetData($4o, "SubItem", $4n)
DllStructSetData($4o, "TextMax", 4096)
DllStructSetData($4o, "Text", $1q)
If IsHWnd($18) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $18, "uint", 0x1073, "wparam", $2d, "struct*", $4o)
Else
Local $4p = DllStructGetPtr($4o)
GUICtrlSendMsg($18, 0x1073, $2d, $4p)
EndIf
Return DllStructGetData($1p, "Text")
EndFunc
Global Enum $4q, $4r, $4s, $4t, $4u, $4v, $4w, $4x
Func _yf(ByRef $4y, $4z, $50 = 0, $51 = "|", $52 = @CRLF, $53 = $4q)
If $50 = Default Then $50 = 0
If $51 = Default Then $51 = "|"
If $52 = Default Then $52 = @CRLF
If $53 = Default Then $53 = $4q
If Not IsArray($4y) Then Return SetError(1, 0, -1)
Local $54 = UBound($4y, 1)
Local $55 = 0
Switch $53
Case $4s
$55 = Int
Case $4t
$55 = Number
Case $4u
$55 = Ptr
Case $4v
$55 = Hwnd
Case $4w
$55 = String
Case $4x
$55 = "Boolean"
EndSwitch
Switch UBound($4y, 0)
Case 1
If $53 = $4r Then
ReDim $4y[$54 + 1]
$4y[$54] = $4z
Return $54
EndIf
If IsArray($4z) Then
If UBound($4z, 0) <> 1 Then Return SetError(5, 0, -1)
$55 = 0
Else
Local $56 = StringSplit($4z, $51, 2 + 1)
If UBound($56, 1) = 1 Then
$56[0] = $4z
EndIf
$4z = $56
EndIf
Local $57 = UBound($4z, 1)
ReDim $4y[$54 + $57]
For $26 = 0 To $57 - 1
If String($55) = "Boolean" Then
Switch $4z[$26]
Case "True", "1"
$4y[$54 + $26] = True
Case "False", "0", ""
$4y[$54 + $26] = False
EndSwitch
ElseIf IsFunc($55) Then
$4y[$54 + $26] = $55($4z[$26])
Else
$4y[$54 + $26] = $4z[$26]
EndIf
Next
Return $54 + $57 - 1
Case 2
Local $58 = UBound($4y, 2)
If $50 < 0 Or $50 > $58 - 1 Then Return SetError(4, 0, -1)
Local $59, $5a = 0, $5b
If IsArray($4z) Then
If UBound($4z, 0) <> 2 Then Return SetError(5, 0, -1)
$59 = UBound($4z, 1)
$5a = UBound($4z, 2)
$55 = 0
Else
Local $5c = StringSplit($4z, $52, 2 + 1)
$59 = UBound($5c, 1)
Local $56[$59][0], $5d
For $26 = 0 To $59 - 1
$5d = StringSplit($5c[$26], $51, 2 + 1)
$5b = UBound($5d)
If $5b > $5a Then
$5a = $5b
ReDim $56[$59][$5a]
EndIf
For $5e = 0 To $5b - 1
$56[$26][$5e] = $5d[$5e]
Next
Next
$4z = $56
EndIf
If UBound($4z, 2) + $50 > UBound($4y, 2) Then Return SetError(3, 0, -1)
ReDim $4y[$54 + $59][$58]
For $5f = 0 To $59 - 1
For $5e = 0 To $58 - 1
If $5e < $50 Then
$4y[$5f + $54][$5e] = ""
ElseIf $5e - $50 > $5a - 1 Then
$4y[$5f + $54][$5e] = ""
Else
If String($55) = "Boolean" Then
Switch $4z[$5f][$5e - $50]
Case "True", "1"
$4y[$5f + $54][$5e] = True
Case "False", "0", ""
$4y[$5f + $54][$5e] = False
EndSwitch
ElseIf IsFunc($55) Then
$4y[$5f + $54][$5e] = $55($4z[$5f][$5e - $50])
Else
$4y[$5f + $54][$5e] = $4z[$5f][$5e - $50]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($4y, 1) - 1
EndFunc
Func _z6(Const ByRef $4y, $5g = "|", $5h = -1, $5i = -1, $52 = @CRLF, $5j = -1, $5k = -1)
If $5g = Default Then $5g = "|"
If $52 = Default Then $52 = @CRLF
If $5h = Default Then $5h = -1
If $5i = Default Then $5i = -1
If $5j = Default Then $5j = -1
If $5k = Default Then $5k = -1
If Not IsArray($4y) Then Return SetError(1, 0, -1)
Local $54 = UBound($4y, 1) - 1
If $5h = -1 Then $5h = 0
If $5i = -1 Then $5i = $54
If $5h < -1 Or $5i < -1 Then Return SetError(3, 0, -1)
If $5h > $54 Or $5i > $54 Then Return SetError(3, 0, "")
If $5h > $5i Then Return SetError(4, 0, -1)
Local $5l = ""
Switch UBound($4y, 0)
Case 1
For $26 = $5h To $5i
$5l &= $4y[$26] & $5g
Next
Return StringTrimRight($5l, StringLen($5g))
Case 2
Local $58 = UBound($4y, 2) - 1
If $5j = -1 Then $5j = 0
If $5k = -1 Then $5k = $58
If $5j < -1 Or $5k < -1 Then Return SetError(5, 0, -1)
If $5j > $58 Or $5k > $58 Then Return SetError(5, 0, -1)
If $5j > $5k Then Return SetError(6, 0, -1)
For $26 = $5h To $5i
For $5e = $5j To $5k
$5l &= $4y[$26][$5e] & $5g
Next
$5l = StringTrimRight($5l, StringLen($5g)) & $52
Next
Return StringTrimRight($5l, StringLen($52))
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _zj($5m)
FileReadToArray($5m)
If @error Then Return SetError(@error, @extended, 0)
Return @extended
EndFunc
Func _zl($5m, $5n = "*", $5o = 0, $5p = False)
Local $2g = "|", $5q = "", $1x = "", $5r = ""
$5m = StringRegExpReplace($5m, "[\\/]+$", "") & "\"
If $5o = Default Then $5o = 0
If $5p Then $5r = $5m
If $5n = Default Then $5n = "*"
If Not FileExists($5m) Then Return SetError(1, 0, 0)
If StringRegExp($5n, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
If Not($5o = 0 Or $5o = 1 Or $5o = 2) Then Return SetError(3, 0, 0)
Local $5s = FileFindFirstFile($5m & $5n)
If @error Then Return SetError(4, 0, 0)
While 1
$1x = FileFindNextFile($5s)
If @error Then ExitLoop
If($5o + @extended = 2) Then ContinueLoop
$5q &= $2g & $5r & $1x
WEnd
FileClose($5s)
If $5q = "" Then Return SetError(4, 0, 0)
Return StringSplit(StringTrimLeft($5q, 1), $2g)
EndFunc
Func _zr($5m, ByRef $5t, $3g = 1, $2g = "")
$5t = 0
If $3g = Default Then $3g = 1
If $2g = Default Then $2g = ""
Local $5u = True
If BitAND($3g, 2) Then
$5u = False
$3g -= 2
EndIf
Local $5v = 0
If BitAND($3g, 4) Then
$5v = 1
$3g -= 4
EndIf
Local $5w = 0
If $3g <> 1 Then
$3g = 0
$5w = 2
EndIf
If $2g Then
Local $5x = FileReadToArray($5m)
If @error Then Return SetError(@error, 0, 0)
Local $54 = UBound($5x) + $3g
If $5u Then
Local $58 = UBound(StringSplit($5x[0], $2g, $5v + 2))
Local $5y[$54][$58]
Local $5z, $60
For $26 = 0 To $54 - $3g - 1
$60 = StringSplit($5x[$26], $2g, $5v + 2)
$5z = UBound($60)
If $5z <> $58 Then
Return SetError(3, 0, 0)
EndIf
For $5e = 0 To $5z - 1
$5y[$26 + $3g][$5e] = $60[$5e]
Next
Next
If $58 < 2 Then Return SetError(4, 0, 0)
If $3g Then
$5y[0][0] = $54 - $3g
$5y[0][1] = $58
EndIf
Else
Local $5y[$54]
For $26 = 0 To $54 - $3g - 1
$5y[$26 + $3g] = StringSplit($5x[$26], $2g, $5v + $5w)
Next
If $3g Then
$5y[0] = $54 - $3g
EndIf
EndIf
$5t = $5y
Else
If $3g Then
Local $61 = FileOpen($5m, 0)
If $61 = -1 Then Return SetError(1, 0, 0)
Local $62 = FileRead($61)
FileClose($61)
If StringLen($62) Then
$5t = StringRegExp(@LF & $62, "(?|(\N+)\z|(\N*)(?:\R))", 3)
$5t[0] = UBound($5t) - 1
Else
Return SetError(2, 0, 0)
EndIf
Else
$5t = FileReadToArray($5m)
If @error Then
$5t = 0
Return SetError(@error, 0, 0)
EndIf
EndIf
EndIf
Return 1
EndFunc
Func _zs($5m, Const ByRef $4y, $63 = Default, $64 = Default, $2g = "|")
Local $65 = 0
If Not IsArray($4y) Then Return SetError(2, 0, $65)
Local $66 = UBound($4y, 0)
If $66 > 2 Then Return SetError(4, 0, 0)
Local $67 = UBound($4y) - 1
If $64 = Default Or $64 > $67 Then $64 = $67
If $63 < 0 Or $63 = Default Then $63 = 0
If $63 > $64 Then Return SetError(5, 0, $65)
If $2g = Default Then $2g = "|"
Local $61 = $5m
If IsString($5m) Then
$61 = FileOpen($5m, 2)
If $61 = -1 Then Return SetError(1, 0, $65)
EndIf
Local $68 = 0
$65 = 1
Switch $66
Case 1
For $26 = $63 To $64
If Not FileWrite($61, $4y[$26] & @CRLF) Then
$68 = 3
$65 = 0
ExitLoop
EndIf
Next
Case 2
Local $69 = ""
For $26 = $63 To $64
$69 = $4y[$26][0]
For $5e = 1 To UBound($4y, 2) - 1
$69 &= $2g & $4y[$26][$5e]
Next
If Not FileWrite($61, $69 & @CRLF) Then
$68 = 3
$65 = 0
ExitLoop
EndIf
Next
EndSwitch
If IsString($5m) Then FileClose($61)
Return SetError($68, 0, $65)
EndFunc
Func _zt($6a, $6b, $5o = -1)
Local $6c = 1
Local $6d = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " : " & $6b
If $5o = Default Then $5o = -1
If $5o <> -1 Then
$6c = 2
$6d &= @CRLF & FileRead($6a)
EndIf
Local $61 = $6a
If IsString($6a) Then $61 = FileOpen($6a, $6c)
If $61 = -1 Then Return SetError(1, 0, 0)
Local $65 = FileWriteLine($61, $6d)
If IsString($6a) Then $65 = FileClose($61)
If $65 <= 0 Then Return SetError(2, $65, 0)
Return $65
EndFunc
Func _105($6e, $5o = 0)
Local Const $6f = 183
Local Const $6g = 1
Local $6h = 0
If BitAND($5o, 2) Then
Local $6i = DllStructCreate("byte;byte;word;ptr[4]")
Local $h = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $6i, "dword", $6g)
If @error Then Return SetError(@error, @extended, 0)
If $h[0] Then
$h = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $6i, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $h[0] Then
$6h = DllStructCreate($b)
DllStructSetData($6h, 1, DllStructGetSize($6h))
DllStructSetData($6h, 2, DllStructGetPtr($6i))
DllStructSetData($6h, 3, 0)
EndIf
EndIf
EndIf
Local $6j = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $6h, "bool", 1, "wstr", $6e)
If @error Then Return SetError(@error, @extended, 0)
Local $6k = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $6k[0] = $6f Then
If BitAND($5o, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $6j[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($6k[0], $6k[0], 0)
Else
Exit -1
EndIf
EndIf
Return $6j[0]
EndFunc
Func _10f($6l, $6m, $6n, $6o, $6p = "", $6q = "", $6r = "", $6s = "", $6t = 0)
If $6l = "" Or $6n = "" Or $6o = "" Or $6m = "" Or StringLen($6m) > 256 Then Return SetError(1, 0, 0)
If $6r = "" Then $6r = @ComputerName
If TCPStartup() = 0 Then Return SetError(2, 0, 0)
Local $6u, $6v
If StringRegExp($6l, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") Then
$6u = $6l
Else
$6u = TCPNameToIP($6l)
EndIf
If $6u = "" Then
TCPShutdown()
Return SetError(3, 0, 0)
EndIf
Local $6w = TCPConnect($6u, 25)
If $6w = -1 Then
TCPShutdown()
Return SetError(4, 0, 0)
EndIf
Local $6x[6], $6y[6]
$6x[0] = "HELO " & $6r & @CRLF
If StringLeft($6r, 5) = "EHLO " Then $6x[0] = $6r & @CRLF
$6y[0] = "250"
$6x[1] = "MAIL FROM: <" & $6n & ">" & @CRLF
$6y[1] = "250"
$6x[2] = "RCPT TO: <" & $6o & ">" & @CRLF
$6y[2] = "250"
$6x[3] = "DATA" & @CRLF
$6y[3] = "354"
Local $m = _q9()
Local $6z = -$m[1] / 60
Local $70 = Int($6z)
Local $71 = 0
If $70 <> $6z Then $71 = Abs($6z - $70) * 60
$6z = StringFormat(" (%+.2d%.2d)", $70, $71)
$6x[4] = "From:" & $6m & "<" & $6n & ">" & @CRLF & "To:" & "<" & $6o & ">" & @CRLF & "Subject:" & $6p & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _oo(@WDAY, 1) & ", " & @MDAY & " " & _p6(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $6z & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$6y[4] = ""
$6x[5] = @CRLF & "." & @CRLF
$6y[5] = "250"
If _10h($6w, $6x[0], $6y[0], $6t, "220", $6s) Then Return SetError(50, 0, 0)
For $6v = 1 To UBound($6x) - 2
If _10h($6w, $6x[$6v], $6y[$6v], $6t) Then Return SetError(50 + $6v, 0, 0)
Next
For $6v = 0 To UBound($6q) - 1
If StringLeft($6q[$6v], 1) = "." Then $6q[$6v] = "." & $6q[$6v]
If _10h($6w, $6q[$6v] & @CRLF, "", $6t) Then Return SetError(500 + $6v, 0, 0)
Next
$6v = UBound($6x) - 1
If _10h($6w, $6x[$6v], $6y[$6v], $6t) Then Return SetError(5000, 0, 0)
TCPCloseSocket($6w)
TCPShutdown()
Return 1
EndFunc
Func _10g($72, $73 = 0)
Local $74 = "SMTP trace"
Local $75 = ControlGetText($74, "", "Static1")
$72 = StringLeft(StringReplace($72, @CRLF, ""), 70)
$75 &= @HOUR & ":" & @MIN & ":" & @SEC & " " & $72 & @LF
If WinExists($74) Then
ControlSetText($74, "", "Static1", $75)
Else
SplashTextOn($74, $75, 400, 500, 500, 100, 4 + 16, "", 8)
EndIf
If $73 Then Sleep($73 * 1000)
EndFunc
Func _10h($6w, $76, $77, $6t, $78 = "", $6s = "")
Local $79, $26, $7a
If $6t Then _10g($76)
If $78 <> "" Then
If $6s <> -1 Then
If TCPSend($6w, $6s) = 0 Then
TCPCloseSocket($6w)
TCPShutdown()
Return 1
EndIf
EndIf
$79 = ""
$7a = TimerInit()
While StringLeft($79, StringLen($78)) <> $78 And TimerDiff($7a) < 45000
$79 = TCPRecv($6w, 1000)
If $6t And $79 <> "" Then _10g("intermediate->" & $79)
WEnd
EndIf
If TCPSend($6w, $76) = 0 Then
TCPCloseSocket($6w)
TCPShutdown()
Return 1
EndIf
$7a = TimerInit()
$79 = ""
While $79 = "" And TimerDiff($7a) < 45000
$26 += 1
$79 = TCPRecv($6w, 1000)
If $77 = "" Then ExitLoop
WEnd
If $77 <> "" Then
If $6t Then _10g($26 & " <- " & $79)
If StringLeft($79, StringLen($77)) <> $77 Then
TCPCloseSocket($6w)
TCPShutdown()
If $6t Then _10g("<-> " & $77, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Opt('ExpandVarStrings', 1)
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 0)
ConsoleWrite(@CRLF)
Global Const $7b = 60 * 5
Global $7c = 0
Global $7d = TimerInit()
Global $7e = $7d
Global $7f = $7d
Global $7g = $7d
Global $7h = $7d
Global $7i = $7d
Global $7j = $7d
Global $7k = $7d
Global Const $7l = StringReplace(StringFormat("%-16s", @ComputerName), " ", ".")
Global Const $7m = FileGetVersion(@ScriptFullPath)
Global $7n = ""
Global Const $7o = "ShadowSpawn.exe"
Global Const $7p = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $7q = $7p & $7o
Global Const $7r = FileExists($7q)
Global Const $7s = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $7t = $7s & "KPSInfo.exe"
Global Const $7u = FileExists($7t)
Global Const $7v = "Powerkatalog-Schnittstelle.exe"
Global Const $7w = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $7x = $7w & $7v
Global Const $7y = FileExists($7x)
Global Const $7z = "SHDUpdater_min.exe"
Global Const $80 = @ProgramFilesDir & "\SHDUpdater\"
Global Const $81 = $80 & $7z
Global Const $82 = FileExists($81)
Global Const $83 = "NetPhone Client.exe"
Global Const $84 = @ProgramFilesDir & "\NetPhone Client\"
Global Const $85 = $84 & $83
Global Const $86 = FileExists($85)
Global Const $87 = "\\172.16.128.4\edv\Gerrit\"
Global Const $88 = $87 & ""
Global Const $89 = FileExists($88)
Global Const $8a = $87 & "akk\"
Global Const $8b = $8a & ""
Global Const $8c = FileExists($8b)
Global Const $8d = @ScriptDir & "\"
Global Const $8e = $8d & "akk.exe"
Global Const $8f = FileExists($8e)
Global Const $8g = $87
Global Const $8h = $8g & "akk.exe"
Global Const $8i = FileExists($8h)
Global Const $8j = "akkUpdater.exe"
Global Const $8k = $8d
Global Const $8l = $8k & $8j
Global $8m = FileExists($8l)
Global Const $8n = $8j
Global Const $8o = $87
Global Const $8p = $8o & $8n
Global Const $8q = FileExists($8p)
Global Const $8r = $8d
Global Const $8s = $8r & "akk.ini"
Global Const $8t = FileExists($8s)
Global Const $8u = "akkGlobalConfig.ini"
Global Const $8v = $8d
Global Const $8w = $8v & $8u
Global $8x = FileExists($8w)
Global Const $8y = $8u
Global Const $8z = $8a
Global Const $90 = $8z & $8y
Global Const $91 = FileExists($90)
Global Const $92 = "akkGlobalConfigExtended.ini"
Global Const $93 = $8v
Global Const $94 = $93 & $92
Global $95 = FileExists($94)
Global Const $96 = $92
Global Const $97 = $8a
Global Const $98 = $97 & $96
Global Const $99 = FileExists($98)
Global $9a
Global $9b = ""
Global Const $9c = $8d & "log\"
Global $9d = $9c & $9b
Global $9e = FileExists($9d)
If Not $9e Then DirCreate($9c)
Global $9f = ""
Global Const $9g = $8a & "log\" & @ComputerName & "\"
Global $9h = $9g & $9f
Global $9i = FileExists($9h)
If Not $9i Then DirCreate($9g)
Global $9j = "akkGlobal.log"
Global Const $9k = $8a & "log\"
Global $9l = $9k & $9j
Global $9m = FileExists($9l)
Global $9n = ""
Global Const $9o = $8a & "log\_archive\"
Global $9p = $9o & $9n
Global $9q = FileExists($9p)
If Not $9q Then DirCreate($9o)
Global Const $9r = $8a & "log\"
Global Const $9s = $9r & "akkGlobal.ini"
Global Const $9t = FileExists($9s)
Global Const $9u = "akkGlobalSpawnStats.ini"
Global Const $9v = $8a & "log\"
Global Const $9w = $9v & $9u
Global Const $9x = FileExists($9w)
Global Const $9y = $9g
Global Const $9z = $9y & "akkMacro.ini"
Global Const $a0 = FileExists($9z)
Global Const $a1 = $8d & "log\"
Global Const $a2 = $a1 & "scrape.prom"
Global Const $a3 = FileExists($a2)
Global Const $a4 = $9g
Global Const $a5 = $a4 & "scrape.prom"
Global Const $a6 = FileExists($a5)
Global Const $a7 = $8d & "log\sc\"
Global Const $a8 = $a7 & ""
Global Const $a9 = FileExists($a8)
If Not $a9 Then DirCreate($a7)
Global Const $aa = $8a & "log\_sc\NetPhoneUser\"
Global Const $ab = $aa & ""
Global Const $ac = FileExists($ab)
If Not $ac Then DirCreate($aa)
Global Const $ad = @UserProfileDir & "\Downloads"
Global Const $ae = $ad & " alt"
Global $af = ""
Global Const $ag = @ComputerName
Global $ah
Global $ai[10][2]
Global $aj = 0
Global $ak = 1
Global $al
Global $am = 0
Global $an
Global $ao
Global $ap
Global Const $aq = @HomeDrive & "\Brauckhoff\akk\"
Global Const $ar = $aq & "exf.exe"
Global $as = FileExists($ar)
Global Const $at = $8a
Global Const $au = $at & "exf.exe"
Global Const $av = FileExists($au)
Global Const $aw = "wmi_exporter.exe"
Global Const $ax = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $ay = $ax & $aw
Global $az = FileExists($ay)
Global Const $b0 = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $b1 = $8a & "wmi_exporter\"
Global Const $b2 = $b1 & $b0
Global Const $b3 = FileExists($b2)
Global Const $b4 = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $b5 = $8a & "wmi_exporter\"
Global Const $b6 = $b5 & $b4
Global Const $b7 = FileExists($b6)
Global Const $b8 = "cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $b9 = $ax & "textfile_inputs\"
Global Const $ba = $b9
Global Const $bb = $ba & "metadata.prom"
Global $bc = FileExists($bb)
Global $bd
Global $be[13]
Global $bf
Global Const $bg = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $b8 & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $b9
_105("akk")
If @Compiled Then Sleep(5e3)
_10q()
_10o()
_10k("akk.exe läuft Spawn, KPSInfo & WMI Exporter werden überwacht")
If Not @Compiled Then _10k("$WmiExporterParams: " & $bg)
_10m()
_10p()
_10l()
_11a()
_119()
_110()
_115()
_10r()
_10v()
If @Compiled Then Sleep(5e3)
While 42
Sleep(10)
If(Mod($7c, 300) = 0) Then
If _10u($7e, 15e3 * 1) Then _10x()
If _10u($7f, 60e3 * 5) Then _10m()
If _10u($7g, 60e3 * 5) Then _10o()
If _10u($7h, 60e3 * 10) Then _117()
If _10u($7i, 30e3 * 1) Then _10l()
If _10u($7j, 30e3 * 1) Then _11b()
If $am > 60e3 * 2 And _10u($7k, 60e3 * 15) Then _10r()
EndIf
If(Mod($7c, 500) = 0) Then _118()
$7c += 1
WEnd
Func _10k($bh)
$bh = StringFormat("%10s", $7c) & " : " & $bh
ConsoleWrite($bh & @CRLF)
_zt($9d, $bh)
_zt($9h, $bh)
_zt($9l, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $bh)
EndFunc
Func _10l()
Local $4a = _x4("", "Application")
$an = _x1($4a)
$ao = _wo($4a)
$ap = _x3($4a)
_wn($4a)
EndFunc
Func _10m()
If $91 And Not $8x Then
$8x = FileCopy($90, $8w, 1 + 8)
EndIf
If $99 And Not $95 Then
$95 = FileCopy($98, $94, 1 + 8)
EndIf
If $8q And Not $8m Then
$8m = FileCopy($8p, $8l, 1 + 8)
EndIf
Local $bi = FileGetTime($8w, 0, 1)
Local $bj = FileGetTime($90, 0, 1)
If $bi <> $bj Then
$8x = FileCopy($90, $8w, 1 + 8)
_10k("Reload Config " & $90)
_10p()
EndIf
Local $bk = FileGetTime($94, 0, 1)
Local $bl = FileGetTime($98, 0, 1)
If $bk <> $bl Then
$95 = FileCopy($98, $94, 1 + 8)
_10k("Reload Config Ex" & $98)
_10p()
_11b()
EndIf
Local $bm = FileGetTime($8l, 0, 1)
Local $bn = FileGetTime($8p, 0, 1)
If $bm <> $bn And @Compiled Then
$8m = FileCopy($8p, $8l, 1 + 8)
_10k("Reload Akk Updater " & $8p)
EndIf
Local $bo = FileGetTime($8e, 0, 1)
Local $bp = FileGetTime($8h, 0, 1)
If $bo <> $bp And @Compiled Then
_10y($8j, $8k, $8l, $8m)
_10k("Reload Akk " & $8h)
EndIf
EndFunc
Func _10n()
Local $bq = WinList()
Local $br[1][8]
$br[0][1] = "hWnd"
$br[0][2] = "$WIN_STATE_EXISTS"
$br[0][3] = "$WIN_STATE_VISIBLE"
$br[0][4] = "$WIN_STATE_ENABLED"
$br[0][5] = "$WIN_STATE_ACTIVE"
$br[0][6] = "$WIN_STATE_MINIMIZED"
$br[0][7] = "$WIN_STATE_MAXIMIZED"
Local $bs
For $26 = 1 To $bq[0][0]
$bs = WinGetState($bq[$26][1])
_yf($br, $bq[$26][0] & "|" & String($bq[$26][1]) & "|" & BitAND($bs, 1) & "|" & BitAND($bs, 2) & "|" & BitAND($bs, 4) & "|" & BitAND($bs, 8) & "|" & BitAND($bs, 16) & "|" & BitAND($bs, 32), 0, "|")
Next
$br[0][0] = UBound($br) - 1
Local $bt[1][5] = [["", "hWnd", "$WIN_STATE_ACTIVE", "$WIN_STATE_MINIMIZED", "$WIN_STATE_MAXIMIZED"]]
For $26 = 1 To $br[0][0]
If $br[$26][0] <> "" And $br[$26][3] = 2 Then
_yf($bt, $br[$26][0] & "|" & $br[$26][1] & "|" & $br[$26][5] & "|" & $br[$26][6] & "|" & $br[$26][7], 0, "|")
EndIf
Next
$bt[0][0] = UBound($bt) - 1
Return $bt
EndFunc
Func _10o()
$9b = StringFormat("%04s", $9a) & ".log"
$9d = $9c & $9b
$9h = $9g & $9b
If _zj($9d) > 1e3 Then
$9a += 1
IniWrite($8s, "LogFile", "ID", $9a)
EndIf
IniWrite($8s, "LogFile", "LogPath", $9d)
IniWrite($8s, "LogFile", "LogNetPath", $9h)
If FileGetSize($9l) / 1024 > 100 Then
Local $bu = $9o & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($9l, $bu, 1 + 8)
EndIf
EndFunc
Func _10p()
If FileExists($8w) Then
$ah = IniRead($8w, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $26 = 0 To 9 Step 1
$ai[$26][0] = IniRead($8w, "FreeSpaceCheck", "Mail" & $26 & "Address", "")
$ai[$26][1] = IniRead($8w, "FreeSpaceCheck", "Mail" & $26 & "Active", 0)
Next
$af = IniRead($8w, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($94) Then
$bd = IniRead($94, "MetaData", @ComputerName, "NULL")
If $bd = "NULL" Then
IniWrite($98, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _10q()
$9a = IniRead($8s, "LogFile", "ID", "NULL")
If $9a = "NULL" Then
IniWrite($8s, "LogFile", "ID", 0)
$9a = 0
EndIf
EndFunc
Func _10r()
Local $bv = _10s()
Local $18 = WinGetHandle("NetPhone Client")
If @error Then
If ProcessExists($83) Then _10k("Error ScreenCaptureNetPhoneClient")
Else
Local $bs = WinGetState($18)
If WinActivate($18) Then
Sleep(250)
Local $bw = WinGetPos($18)
$bw[0] = $bw[0] + 57
$bw[1] = $bw[1] + $bw[3] - 54
$bw[2] = $bw[0] + 174
$bw[3] = $bw[1] + 15
_10w("", "NetPhoneUser", "$NetPhoneClientPos", 0, _z6($bw))
$7n = PixelChecksum($bw[0], $bw[1], $bw[2], $bw[3], 1, Default, 1)
If Not FileExists($aa & $7n & ".png") And Not FileExists($aa & "del\" & $7n & ".png") And Not FileExists($aa & "ini\" & $7n & ".png") Then
_mq($aa & $7n & ".png", $bw[0], $bw[1], $bw[2], $bw[3], 0)
EndIf
If BitAND($bs, 16) Then WinSetState($18, Default, @SW_MINIMIZE)
EndIf
EndIf
WinActivate($bv)
_10w("", "NetPhoneUser", "$NetPhoneUserChecksum", 0, $7n)
EndFunc
Func _10s()
Local $bx = _10n()
Local $18
Local $bv
For $26 = 1 To $bx[0][0]
If $bx[$26][0] <> "" Then
If $bx[$26][2] = 8 Then
$bv = $bx[$26][1]
EndIf
If False & StringStripWS($bx[$26][0], 1 + 2) = "NetPhone Client" Then
$18 = HWnd($bx[$26][1])
If WinActivate($18) Then
_mr($a7 & $26 & ".png", $18)
EndIf
If $bx[$26][3] = 16 Then
WinSetState($18, Default, @SW_MINIMIZE)
EndIf
If $bx[$26][4] = 32 Then
WinSetState($18, Default, @SW_MAXIMIZE)
EndIf
If @error Then _10k("Error ScreenCaptureWnd")
EndIf
EndIf
Next
$18 = HWnd($bv)
WinActivate($18)
Return $18
EndFunc
Func _10u(ByRef $by, $bz)
Local $c0 = TimerDiff($by)
If $c0 > $bz Then
$by = TimerInit()
Return $c0
EndIf
Return 0
EndFunc
Func _10v()
IniWrite($9r & "Global" & ".ini", "@ComputerName", StringReplace(StringFormat("%-16s", @IPAddress1), " ", "."), @ComputerName)
_10w("", "Global", "@IPAddress1", 0, @IPAddress1)
_10w("", "Global", "$AkkVersion", 0, $7m)
_10w("", "Global", "$SpawnExists", 0, $7r)
_10w("", "Global", "$KPSInfoExists", 0, $7u)
_10w("", "Global", "$PowerkatalogExists", 0, $7y)
_10w("", "Global", "$SHDUpdaterExists", 0, $82)
_10w("", "Global", "$NetPhoneClientExists", 0, $86)
_10w("", "EventLog", "$EventLogFull", 0, $an)
_10w("", "EventLog", "$EventLogCount", 0, $ao)
_10w("", "EventLog", "$EventLogOldest", 0, $ap)
_10w("", "SpawnStats", $7o & "TimeModified", 0, FileGetTime($7q, 0, 1))
_10w("", "AutoIt", "@Compiled", 0, @Compiled)
_10w("", "AutoIt", "@ScriptName", 0, @ScriptName)
_10w("", "AutoIt", "@ScriptDir", 0, @ScriptDir)
_10w("", "AutoIt", "@ScriptFullPath", 0, @ScriptFullPath)
_10w("", "AutoIt", "@WorkingDir", 0, @WorkingDir)
_10w("", "AutoIt", "@AutoItExe", 0, @AutoItExe)
_10w("", "AutoIt", "@AutoItPID", 0, @AutoItPID)
_10w("", "AutoIt", "@AutoItVersion", 0, @AutoItVersion)
_10w("", "AutoIt", "@AutoItX64", 0, @AutoItX64)
_10w("", "Directory", "@AppDataCommonDir", 0, @AppDataCommonDir)
_10w("", "Directory", "@DesktopCommonDir", 0, @DesktopCommonDir)
_10w("", "Directory", "@DocumentsCommonDir", 0, @DocumentsCommonDir)
_10w("", "Directory", "@FavoritesCommonDir", 0, @FavoritesCommonDir)
_10w("", "Directory", "@ProgramsCommonDir", 0, @ProgramsCommonDir)
_10w("", "Directory", "@StartMenuCommonDir", 0, @StartMenuCommonDir)
_10w("", "Directory", "@StartupCommonDir", 0, @StartupCommonDir)
_10w("", "Directory", "@AppDataDir", 0, @AppDataDir)
_10w("", "Directory", "@LocalAppDataDir", 0, @LocalAppDataDir)
_10w("", "Directory", "@DesktopDir", 0, @DesktopDir)
_10w("", "Directory", "@MyDocumentsDir", 0, @MyDocumentsDir)
_10w("", "Directory", "@FavoritesDir", 0, @FavoritesDir)
_10w("", "Directory", "@ProgramsDir", 0, @ProgramsDir)
_10w("", "Directory", "@StartMenuDir", 0, @StartMenuDir)
_10w("", "Directory", "@UserProfileDir", 0, @UserProfileDir)
_10w("", "Directory", "@HomeDrive", 0, @HomeDrive)
_10w("", "Directory", "@HomePath", 0, @HomePath)
_10w("", "Directory", "@HomeShare", 0, @HomeShare)
_10w("", "Directory", "@LogonDNSDomain", 0, @LogonDNSDomain)
_10w("", "Directory", "@LogonDomain", 0, @LogonDomain)
_10w("", "Directory", "@LogonServer", 0, @LogonServer)
_10w("", "Directory", "@ProgramFilesDir", 0, @ProgramFilesDir)
_10w("", "Directory", "@CommonFilesDir", 0, @CommonFilesDir)
_10w("", "Directory", "@WindowsDir", 0, @WindowsDir)
_10w("", "Directory", "@SystemDir", 0, @SystemDir)
_10w("", "Directory", "@TempDir", 0, @TempDir)
_10w("", "Directory", "@ComSpec", 0, @ComSpec)
_10w("", "SystemInfo", "@CPUArch", 0, @CPUArch)
_10w("", "SystemInfo", "@KBLayout", 0, @KBLayout)
_10w("", "SystemInfo", "@MUILang", 0, @MUILang)
_10w("", "SystemInfo", "@OSArch", 0, @OSArch)
_10w("", "SystemInfo", "@OSLang", 0, @OSLang)
_10w("", "SystemInfo", "@OSType", 0, @OSType)
_10w("", "SystemInfo", "@OSVersion", 0, @OSVersion)
_10w("", "SystemInfo", "@OSBuild", 0, @OSBuild)
_10w("", "SystemInfo", "@OSServicePack", 0, @OSServicePack)
_10w("", "SystemInfo", "@ComputerName", 0, @ComputerName)
_10w("", "SystemInfo", "@UserName", 0, @UserName)
_10w("", "SystemInfo", "@IPAddress1", 0, @IPAddress1)
_10w("", "SystemInfo", "@IPAddress2", 0, @IPAddress2)
_10w("", "SystemInfo", "@IPAddress3", 0, @IPAddress3)
_10w("", "SystemInfo", "@IPAddress4", 0, @IPAddress4)
_10w("", "SystemInfo", "@DesktopHeight", 0, @DesktopHeight)
_10w("", "SystemInfo", "@DesktopWidth", 0, @DesktopWidth)
_10w("", "SystemInfo", "@DesktopDepth", 0, @DesktopDepth)
_10w("", "SystemInfo", "@DesktopRefresh", 0, @DesktopRefresh)
EndFunc
Func _10w($c1, $c2, $c3, $c4, $c5)
If $c1 = "" Then
$c1 = $9r & $c2 & ".ini"
EndIf
IniWrite($c1,($c4 ? $c2 & $c3 : $c3), $7l, $c5)
IniWrite($9z, $c2, $c3, $c5)
EndFunc
Func _10x()
_10y($7o, $7p, $7q, $7r)
_10y("KPSInfo.exe", $7s, $7t, $7u)
$al = _10y($aw, $ax, $ay & $bg, $az)
EndFunc
Func _10y($c6, $c7, $c8, $c9, $ca = @SW_HIDE)
If $c9 And Not ProcessExists($c6) Then
_10k($c6 & " wird gestartet")
Return Run($c8, $c7, $ca)
EndIf
Return 0
EndFunc
Func _110()
If _111() Then
DirRemove($ae, 1)
_112($ad, $ae)
FileDelete($ae & "\Downloads alt.lnk")
FileCreateShortcut($ae, $ad & "\Downloads alt")
IniWrite($8s, "Downloads", "LastCleaningDate", _p5(@YEAR, @MON, @MDAY))
Local Const $cb = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $cb, $7b) = 6 Then
ShellExecute($ae)
EndIf
EndIf
EndFunc
Func _111()
Return(_p5(@YEAR, @MON, @MDAY) - _113()) >= 14
EndFunc
Func _112($cc, $cd)
If FileExists($cc) Then
If Not FileExists($cd) Then DirCreate($cd)
FileMove($cc & "\*.*", $cd, 1 + 8)
Local Const $ce = _zl($cc, Default, 2, True)
If Not @error Then
For $cf In $ce
DirMove($cf, $cd, 1)
Next
EndIf
EndIf
EndFunc
Func _113()
Return IniRead($8s, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _115()
Local Const $cg = DriveGetLabel(@HomeDrive & "\")
Local Const $ch = DriveSpaceFree(@HomeDrive & "\")
Local Const $ci = DriveSpaceTotal(@HomeDrive & "\")
Local Const $cj =($ch / $ci) * 100
If $cj < $ah Then
If(_p5(@YEAR, @MON, @MDAY) - IniRead($8s, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($8s, "FreeSpaceCheck", "LastMailSendDate", _p5(@YEAR, @MON, @MDAY))
For $26 = 0 To 9 Step 1
If $ai[$26][0] <> "" And $ai[$26][1] = 1 Then
_10k("Sending Mail to " & $ai[$26][0])
_116($ai[$26][0], Round($cj, 2), $cg, $ch, $ci)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _116($6o, $cj, $cg, $ch, $ci)
Local $6m = "akk.exe (Gerrit)"
Local $6n = "akk@kuechen-brauckhoff.de"
Local $6p = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $cj & "% !"
Local $ck[0]
_yf($ck, "Akk Warnung wenig Speicherplatz auf:")
_yf($ck, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _yf($ck, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _yf($ck, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _yf($ck, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _yf($ck, @IPAddress4)
_yf($ck, $cg & " (" & @HomeDrive & ")")
_yf($ck, Round($ch / 1024, 2) & " GB frei von " & Round($ci / 1024, 2) & " GB")
_yf($ck, $cj & "% frei")
Local $cl = _10f($af, $6m, $6n, $6o, $6p, $ck, $ag, -1, 0)
Local $cm = @error
If $cl = 0 Then
Local Const $cb = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _z6($ck, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $cm & @CRLF
MsgBox(48 + 4096, "Warnung!", $cb)
EndIf
EndFunc
Func _117()
If $ak And ProcessExists($aw) Then
$aj = InetGet("http://localhost:9182/metrics", $a2, 1, 1)
$ak = 0
EndIf
EndFunc
Func _118()
If Not $ak Then
If InetGetInfo($aj, 2) Then
If InetGetInfo($aj, 3) Then
If FileGetSize($a2) Then FileCopy($a2, $a5, 1 + 8)
Else
FileDelete($a2)
_10k("Error ScrapeDownload")
EndIf
InetClose($aj)
$aj = 0
$ak = 1
EndIf
EndIf
EndFunc
Func _119()
If Not $as Then
If FileCopy($au, $ar, 1 + 8) Then
$as = FileExists($ar)
EndIf
EndIf
EndFunc
Func _11a()
ProcessClose($aw)
If Not $az Then
Local $cn =(@OSArch = "X64") ? $b6 : $b2
If FileCopy($cn, $ay, 1 + 8) Then
$az = FileExists($ay)
EndIf
EndIf
If Not FileExists($b9) Then DirCreate($b9)
EndFunc
Func _11b()
Local $co = 'metadata{computername="@ComputerName@",username="@UserName@"'
If $bd <> "NULL" And StringLen($bd) And Not StringIsSpace($bd) Then
$co &= "," & $bd
EndIf
$co &= '} 1'
$am = _xa()
Local $cp = 'akk_idletime_sec{computername="@ComputerName@"} ' & $am / 1e3
Local $cq = MemGetStats()
Local $cr = 'akk_memstats_load{computername="@ComputerName@"} ' & $cq[$36]
Local $cs = 'akk_memstats_total_physram_gb{computername="@ComputerName@"} ' & Round($cq[$37] / 1024 / 1024, 2)
Local $ct = 'akk_memstats_avail_physram_gb{computername="@ComputerName@"} ' & Round($cq[$38] / 1024 / 1024, 2)
Local $cu = 'akk_memstats_total_pagefile_gb{computername="@ComputerName@"} ' & Round($cq[$39] / 1024 / 1024, 2)
Local $cv = 'akk_memstats_avail_pagefile_gb{computername="@ComputerName@"} ' & Round($cq[$3a] / 1024 / 1024, 2)
Local $cw = 'akk_memstats_total_virtual_gb{computername="@ComputerName@"} ' & Round($cq[$3b] / 1024 / 1024, 2)
Local $cx = 'akk_memstats_avail_virtual_gb{computername="@ComputerName@"} ' & Round($cq[$3c] / 1024 / 1024, 2)
Local $cy = 'akk_eventlog_full{computername="@ComputerName@"} ' &($an ? 1 : 0)
Local $cz = 'akk_eventlog_count{computername="@ComputerName@"} ' & $ao
Local $d0 = 'akk_eventlog_oldest{computername="@ComputerName@"} ' & $ap
$be[1] = $co
$be[2] = $cp
$be[3] = $cr
$be[4] = $cs
$be[5] = $ct
$be[6] = $cu
$be[7] = $cv
$be[8] = $cw
$be[9] = $cx
$be[10] = $cy
$be[11] = $cz
$be[12] = $d0
$be[0] = UBound($be) - 1
_zr($bb, $bf)
If Not _11c($be, $bf, 3) Then
_zs($bb, $be, 1)
EndIf
EndFunc
Func _11c(Const ByRef $d1, Const ByRef $d2, $d3 = 0)
If Not(IsArray($d1)) Or Not(IsArray($d2)) Then
Return SetError(1, 0, 0)
EndIf
Local $66 = UBound($d1, 0)
If $66 <> UBound($d2, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $d4 = UBound($d1, 1)
Local $d5 = UBound($d1, 2)
If $d4 <> UBound($d2, 1) Or $d5 <> UBound($d2, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $d6, $d7
Switch $d3
Case 0
For $26 = 0 To $d4 - 1
For $5e = 0 To $d5 - 1
If $d1[$26][$5e] <> $d1[$26][$5e] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case 1
For $26 = 0 To $d4 - 1
For $5e = 0 To $d5 - 1
$d6 &= $d1[$26][$5e]
$d7 &= $d2[$26][$5e]
Next
If $d6 <> $d7 Then
Return SetError(4, 0, 0)
EndIf
Next
Case 2
For $5e = 0 To $d5 - 1
For $26 = 0 To $d4 - 1
$d6 &= $d1[$26][$5e]
$d7 &= $d2[$26][$5e]
Next
If $d6 <> $d7 Then
Return SetError(4, 0, 0)
EndIf
Next
Case 3
If _z6($d1) <> _z6($d2) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
