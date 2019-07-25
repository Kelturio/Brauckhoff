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
Func _zy($5m, ByRef $6e, ByRef $6f, ByRef $1x, ByRef $6g)
Local $4y = StringRegExp($5m, "^\h*((?:\\\\\?\\)*(\\\\[^\?\/\\]+|[A-Za-z]:)?(.*[\/\\]\h*)?((?:[^\.\/\\]|(?(?=\.[^\/\\]*\.)\.))*)?([^\/\\]*))$", 1)
If @error Then
ReDim $4y[5]
$4y[0] = $5m
EndIf
$6e = $4y[1]
If StringLeft($4y[2], 1) == "/" Then
$6f = StringRegExpReplace($4y[2], "\h*[\/\\]+\h*", "\/")
Else
$6f = StringRegExpReplace($4y[2], "\h*[\/\\]+\h*", "\\")
EndIf
$4y[2] = $6f
$1x = $4y[3]
$6g = $4y[4]
Return $4y
EndFunc
Func _105($6h, $5o = 0)
Local Const $6i = 183
Local Const $6j = 1
Local $6k = 0
If BitAND($5o, 2) Then
Local $6l = DllStructCreate("byte;byte;word;ptr[4]")
Local $h = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $6l, "dword", $6j)
If @error Then Return SetError(@error, @extended, 0)
If $h[0] Then
$h = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $6l, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $h[0] Then
$6k = DllStructCreate($b)
DllStructSetData($6k, 1, DllStructGetSize($6k))
DllStructSetData($6k, 2, DllStructGetPtr($6l))
DllStructSetData($6k, 3, 0)
EndIf
EndIf
EndIf
Local $6m = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $6k, "bool", 1, "wstr", $6h)
If @error Then Return SetError(@error, @extended, 0)
Local $6n = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $6n[0] = $6i Then
If BitAND($5o, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $6m[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($6n[0], $6n[0], 0)
Else
Exit -1
EndIf
EndIf
Return $6m[0]
EndFunc
Func _10f($6o, $6p, $6q, $6r, $6s = "", $6t = "", $6u = "", $6v = "", $6w = 0)
If $6o = "" Or $6q = "" Or $6r = "" Or $6p = "" Or StringLen($6p) > 256 Then Return SetError(1, 0, 0)
If $6u = "" Then $6u = @ComputerName
If TCPStartup() = 0 Then Return SetError(2, 0, 0)
Local $6x, $6y
If StringRegExp($6o, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") Then
$6x = $6o
Else
$6x = TCPNameToIP($6o)
EndIf
If $6x = "" Then
TCPShutdown()
Return SetError(3, 0, 0)
EndIf
Local $6z = TCPConnect($6x, 25)
If $6z = -1 Then
TCPShutdown()
Return SetError(4, 0, 0)
EndIf
Local $70[6], $71[6]
$70[0] = "HELO " & $6u & @CRLF
If StringLeft($6u, 5) = "EHLO " Then $70[0] = $6u & @CRLF
$71[0] = "250"
$70[1] = "MAIL FROM: <" & $6q & ">" & @CRLF
$71[1] = "250"
$70[2] = "RCPT TO: <" & $6r & ">" & @CRLF
$71[2] = "250"
$70[3] = "DATA" & @CRLF
$71[3] = "354"
Local $m = _q9()
Local $72 = -$m[1] / 60
Local $73 = Int($72)
Local $74 = 0
If $73 <> $72 Then $74 = Abs($72 - $73) * 60
$72 = StringFormat(" (%+.2d%.2d)", $73, $74)
$70[4] = "From:" & $6p & "<" & $6q & ">" & @CRLF & "To:" & "<" & $6r & ">" & @CRLF & "Subject:" & $6s & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _oo(@WDAY, 1) & ", " & @MDAY & " " & _p6(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $72 & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$71[4] = ""
$70[5] = @CRLF & "." & @CRLF
$71[5] = "250"
If _10h($6z, $70[0], $71[0], $6w, "220", $6v) Then Return SetError(50, 0, 0)
For $6y = 1 To UBound($70) - 2
If _10h($6z, $70[$6y], $71[$6y], $6w) Then Return SetError(50 + $6y, 0, 0)
Next
For $6y = 0 To UBound($6t) - 1
If StringLeft($6t[$6y], 1) = "." Then $6t[$6y] = "." & $6t[$6y]
If _10h($6z, $6t[$6y] & @CRLF, "", $6w) Then Return SetError(500 + $6y, 0, 0)
Next
$6y = UBound($70) - 1
If _10h($6z, $70[$6y], $71[$6y], $6w) Then Return SetError(5000, 0, 0)
TCPCloseSocket($6z)
TCPShutdown()
Return 1
EndFunc
Func _10g($75, $76 = 0)
Local $77 = "SMTP trace"
Local $78 = ControlGetText($77, "", "Static1")
$75 = StringLeft(StringReplace($75, @CRLF, ""), 70)
$78 &= @HOUR & ":" & @MIN & ":" & @SEC & " " & $75 & @LF
If WinExists($77) Then
ControlSetText($77, "", "Static1", $78)
Else
SplashTextOn($77, $78, 400, 500, 500, 100, 4 + 16, "", 8)
EndIf
If $76 Then Sleep($76 * 1000)
EndFunc
Func _10h($6z, $79, $7a, $6w, $7b = "", $6v = "")
Local $7c, $26, $7d
If $6w Then _10g($79)
If $7b <> "" Then
If $6v <> -1 Then
If TCPSend($6z, $6v) = 0 Then
TCPCloseSocket($6z)
TCPShutdown()
Return 1
EndIf
EndIf
$7c = ""
$7d = TimerInit()
While StringLeft($7c, StringLen($7b)) <> $7b And TimerDiff($7d) < 45000
$7c = TCPRecv($6z, 1000)
If $6w And $7c <> "" Then _10g("intermediate->" & $7c)
WEnd
EndIf
If TCPSend($6z, $79) = 0 Then
TCPCloseSocket($6z)
TCPShutdown()
Return 1
EndIf
$7d = TimerInit()
$7c = ""
While $7c = "" And TimerDiff($7d) < 45000
$26 += 1
$7c = TCPRecv($6z, 1000)
If $7a = "" Then ExitLoop
WEnd
If $7a <> "" Then
If $6w Then _10g($26 & " <- " & $7c)
If StringLeft($7c, StringLen($7a)) <> $7a Then
TCPCloseSocket($6z)
TCPShutdown()
If $6w Then _10g("<-> " & $7a, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Opt('ExpandVarStrings', 1)
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 0)
ConsoleWrite(@CRLF)
Global Const $7e = 60 * 5
Global $7f = 0
Global $7g = TimerInit()
Global $7h = $7g
Global $7i = $7g
Global $7j = $7g
Global $7k = $7g
Global $7l = $7g
Global $7m = $7g
Global $7n = $7g
Global Const $7o = StringReplace(StringFormat("%-16s", @ComputerName), " ", ".")
Global Const $7p = FileGetVersion(@ScriptFullPath)
Global $7q = ""
Global $7r
Global $7s
Global $7t
Global Const $7u = "ShadowSpawn.exe"
Global Const $7v = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $7w = $7v & $7u
Global Const $7x = FileExists($7w)
Global Const $7y = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $7z = $7y & "KPSInfo.exe"
Global Const $80 = FileExists($7z)
Global Const $81 = "Powerkatalog-Schnittstelle.exe"
Global Const $82 = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $83 = $82 & $81
Global Const $84 = FileExists($83)
Global Const $85 = "SHDUpdater_min.exe"
Global Const $86 = @ProgramFilesDir & "\SHDUpdater\"
Global Const $87 = $86 & $85
Global Const $88 = FileExists($87)
Global Const $89 = "NetPhone Client.exe"
Global Const $8a = @ProgramFilesDir & "\NetPhone Client\"
Global Const $8b = $8a & $89
Global Const $8c = FileExists($8b)
Global Const $8d = "\\172.16.128.4\edv\Gerrit\"
Global Const $8e = $8d & ""
Global Const $8f = FileExists($8e)
Global Const $8g = $8d & "akk\"
Global Const $8h = $8g & ""
Global Const $8i = FileExists($8h)
Global Const $8j = @ScriptDir & "\"
Global Const $8k = $8j & "akk.exe"
Global Const $8l = FileExists($8k)
Global Const $8m = $8d
Global Const $8n = $8m & "akk.exe"
Global Const $8o = FileExists($8n)
Global Const $8p = "akkUpdater.exe"
Global Const $8q = $8j
Global Const $8r = $8q & $8p
Global $8s = FileExists($8r)
Global Const $8t = $8p
Global Const $8u = $8d
Global Const $8v = $8u & $8t
Global Const $8w = FileExists($8v)
Global Const $8x = $8j
Global Const $8y = $8x & "akk.ini"
Global Const $8z = FileExists($8y)
Global Const $90 = "akkGlobalConfig.ini"
Global Const $91 = $8j
Global Const $92 = $91 & $90
Global $93 = FileExists($92)
Global Const $94 = $90
Global Const $95 = $8g
Global Const $96 = $95 & $94
Global Const $97 = FileExists($96)
Global Const $98 = "akkGlobalConfigExtended.ini"
Global Const $99 = $91
Global Const $9a = $99 & $98
Global $9b = FileExists($9a)
Global Const $9c = $98
Global Const $9d = $8g
Global Const $9e = $9d & $9c
Global Const $9f = FileExists($9e)
Global $9g
Global $9h = ""
Global Const $9i = $8j & "log\"
Global $9j = $9i & $9h
Global $9k = FileExists($9j)
If Not $9k Then DirCreate($9i)
Global $9l = ""
Global Const $9m = $8g & "log\" & @ComputerName & "\"
Global $9n = $9m & $9l
Global $9o = FileExists($9n)
If Not $9o Then DirCreate($9m)
Global $9p = "akkGlobal.log"
Global Const $9q = $8g & "log\"
Global $9r = $9q & $9p
Global $9s = FileExists($9r)
Global $9t = ""
Global Const $9u = $8g & "log\_archive\"
Global $9v = $9u & $9t
Global $9w = FileExists($9v)
If Not $9w Then DirCreate($9u)
Global Const $9x = $8g & "log\"
Global Const $9y = $9x & "akkGlobal.ini"
Global Const $9z = FileExists($9y)
Global Const $a0 = "akkGlobalSpawnStats.ini"
Global Const $a1 = $8g & "log\"
Global Const $a2 = $a1 & $a0
Global Const $a3 = FileExists($a2)
Global Const $a4 = $9m
Global Const $a5 = $a4 & "akkMacro.ini"
Global Const $a6 = FileExists($a5)
Global Const $a7 = $8j & "log\"
Global Const $a8 = $a7 & "scrape.prom"
Global Const $a9 = FileExists($a8)
Global Const $aa = $9m
Global Const $ab = $aa & "scrape.prom"
Global Const $ac = FileExists($ab)
Global Const $ad = $8j & "log\sc\"
Global Const $ae = $ad & ""
Global Const $af = FileExists($ae)
If Not $af Then DirCreate($ad)
Global Const $ag = $8g & "log\_sc\NetPhoneUser\"
Global Const $ah = $ag & ""
Global Const $ai = FileExists($ah)
If Not $ai Then DirCreate($ag)
Global Const $aj = @UserProfileDir & "\Downloads"
Global Const $ak = $aj & " alt"
Global $al = ""
Global Const $am = @ComputerName
Global $an
Global $ao[10][2]
Global $ap = 0
Global $aq = 1
Global $ar
Global $as = 0
Global $at
Global $au
Global $av
Global Const $aw = @HomeDrive & "\Brauckhoff\akk\"
Global Const $ax = $aw & "exf.exe"
Global $ay = FileExists($ax)
Global Const $az = $8g
Global Const $b0 = $az & "exf.exe"
Global Const $b1 = FileExists($b0)
Global Const $b2 = "wmi_exporter.exe"
Global Const $b3 = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $b4 = $b3 & $b2
Global $b5 = FileExists($b4)
Global Const $b6 = "wmi_exporter-0.7.999-preview.2-386.exe"
Global Const $b7 = $8g & "wmi_exporter\"
Global Const $b8 = $b7 & $b6
Global Const $b9 = FileExists($b8)
Global Const $ba = "wmi_exporter-0.7.999-preview.2-amd64.exe"
Global Const $bb = $8g & "wmi_exporter\"
Global Const $bc = $bb & $ba
Global Const $bd = FileExists($bc)
Global Const $be = "cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $bf = $b3 & "textfile_inputs\"
Global Const $bg = $bf
Global Const $bh = $bg & "metadata.prom"
Global $bi = FileExists($bh)
Global $bj
Global $bk[16]
Global $bl
Global Const $bm = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $be & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $bf
_105("akk")
If @Compiled Then Sleep(5e3)
_10q()
_10o()
_10k("akk.exe läuft Spawn, KPSInfo & WMI Exporter werden überwacht")
If Not @Compiled Then _10k("$WmiExporterParams: " & $bm)
_10m()
_10p()
_10l()
_11b()
_11a()
_110()
_115()
_10r()
_11c()
_10v()
If @Compiled Then Sleep(5e3)
While 42
Sleep(10)
If(Mod($7f, 300) = 0) Then
If _10u($7h, 15e3 * 1) Then _10x()
If _10u($7i, 60e3 * 5) Then _10m()
If _10u($7j, 60e3 * 5) Then _10o()
If _10u($7k, 60e3 * 10) Then _118()
If _10u($7l, 30e3 * 1) Then _10l()
If _10u($7m, 30e3 * 1) Then _11c()
If $as > 60e3 * 2 And _10u($7n, 60e3 * 15) Then _10r()
EndIf
If(Mod($7f, 500) = 0) Then _119()
$7f += 1
WEnd
Func _10k($bn)
$bn = StringFormat("%10s", $7f) & " : " & $bn
ConsoleWrite($bn & @CRLF)
_zt($9j, $bn)
_zt($9n, $bn)
_zt($9r, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $bn)
EndFunc
Func _10l()
Local $4a = _x4("", "Application")
$at = _x1($4a)
$au = _wo($4a)
$av = _x3($4a)
_wn($4a)
EndFunc
Func _10m()
If $97 And Not $93 Then
$93 = FileCopy($96, $92, 1 + 8)
EndIf
If $9f And Not $9b Then
$9b = FileCopy($9e, $9a, 1 + 8)
EndIf
If $8w And Not $8s Then
$8s = FileCopy($8v, $8r, 1 + 8)
EndIf
Local $bo = FileGetTime($92, 0, 1)
Local $bp = FileGetTime($96, 0, 1)
If $bo <> $bp Then
$93 = FileCopy($96, $92, 1 + 8)
_10k("Reload Config " & $96)
_10p()
EndIf
Local $bq = FileGetTime($9a, 0, 1)
Local $br = FileGetTime($9e, 0, 1)
If $bq <> $br Then
$9b = FileCopy($9e, $9a, 1 + 8)
_10k("Reload Config Ex" & $9e)
_10p()
_11c()
EndIf
Local $bs = FileGetTime($8r, 0, 1)
Local $bt = FileGetTime($8v, 0, 1)
If $bs <> $bt And @Compiled Then
$8s = FileCopy($8v, $8r, 1 + 8)
_10k("Reload Akk Updater " & $8v)
EndIf
Local $bu = FileGetTime($8k, 0, 1)
Local $bv = FileGetTime($8n, 0, 1)
If $bu <> $bv And @Compiled Then
_10y($8p, $8q, $8r, $8s)
_10k("Reload Akk " & $8n)
EndIf
EndFunc
Func _10n()
Local $bw = WinList()
Local $bx[1][8]
$bx[0][1] = "hWnd"
$bx[0][2] = "$WIN_STATE_EXISTS"
$bx[0][3] = "$WIN_STATE_VISIBLE"
$bx[0][4] = "$WIN_STATE_ENABLED"
$bx[0][5] = "$WIN_STATE_ACTIVE"
$bx[0][6] = "$WIN_STATE_MINIMIZED"
$bx[0][7] = "$WIN_STATE_MAXIMIZED"
Local $by
For $26 = 1 To $bw[0][0]
$by = WinGetState($bw[$26][1])
_yf($bx, $bw[$26][0] & "|" & String($bw[$26][1]) & "|" & BitAND($by, 1) & "|" & BitAND($by, 2) & "|" & BitAND($by, 4) & "|" & BitAND($by, 8) & "|" & BitAND($by, 16) & "|" & BitAND($by, 32), 0, "|")
Next
$bx[0][0] = UBound($bx) - 1
Local $bz[1][5] = [["", "hWnd", "$WIN_STATE_ACTIVE", "$WIN_STATE_MINIMIZED", "$WIN_STATE_MAXIMIZED"]]
For $26 = 1 To $bx[0][0]
If $bx[$26][0] <> "" And $bx[$26][3] = 2 Then
_yf($bz, $bx[$26][0] & "|" & $bx[$26][1] & "|" & $bx[$26][5] & "|" & $bx[$26][6] & "|" & $bx[$26][7], 0, "|")
EndIf
Next
$bz[0][0] = UBound($bz) - 1
Return $bz
EndFunc
Func _10o()
$9h = StringFormat("%04s", $9g) & ".log"
$9j = $9i & $9h
$9n = $9m & $9h
If _zj($9j) > 1e3 Then
$9g += 1
IniWrite($8y, "LogFile", "ID", $9g)
EndIf
IniWrite($8y, "LogFile", "LogPath", $9j)
IniWrite($8y, "LogFile", "LogNetPath", $9n)
If FileGetSize($9r) / 1024 > 100 Then
Local $c0 = $9u & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($9r, $c0, 1 + 8)
EndIf
EndFunc
Func _10p()
If FileExists($92) Then
$an = IniRead($92, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $26 = 0 To 9 Step 1
$ao[$26][0] = IniRead($92, "FreeSpaceCheck", "Mail" & $26 & "Address", "")
$ao[$26][1] = IniRead($92, "FreeSpaceCheck", "Mail" & $26 & "Active", 0)
Next
$al = IniRead($92, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($9a) Then
$bj = IniRead($9a, "MetaData", @ComputerName, "NULL")
If $bj = "NULL" Then
IniWrite($9e, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _10q()
$9g = IniRead($8y, "LogFile", "ID", "NULL")
If $9g = "NULL" Then
IniWrite($8y, "LogFile", "ID", 0)
$9g = 0
EndIf
EndFunc
Func _10r()
Local $c1 = _10s()
Local $18 = WinGetHandle("NetPhone Client")
If @error Then
If ProcessExists($89) Then _10k("Error ScreenCaptureNetPhoneClient")
Else
Local $by = WinGetState($18)
If WinActivate($18) Then
Sleep(250)
Local $c2 = WinGetPos($18)
$c2[0] = $c2[0] + 57
$c2[1] = $c2[1] + $c2[3] - 54
$c2[2] = $c2[0] + 174
$c2[3] = $c2[1] + 15
_10w("", "NetPhoneUser", "$NetPhoneClientPos", 0, _z6($c2))
$7q = PixelChecksum($c2[0], $c2[1], $c2[2], $c2[3], 1, Default, 1)
If Not FileExists($ag & $7q & ".png") And Not FileExists($ag & "del\" & $7q & ".png") And Not FileExists($ag & "ini\" & $7q & ".png") Then
_mq($ag & $7q & ".png", $c2[0], $c2[1], $c2[2], $c2[3], 0)
EndIf
If BitAND($by, 16) Then WinSetState($18, Default, @SW_MINIMIZE)
EndIf
EndIf
WinActivate($c1)
$7r = IniRead($9a, "$NetPhoneUser", $7q, "NULL")
_10w("", "NetPhoneUser", "$NetPhoneUser", 0, $7r)
_10w("", "NetPhoneUser", "$NetPhoneUserChecksum", 0, $7q)
EndFunc
Func _10s()
Local $c3 = _10n()
Local $18
Local $c1
For $26 = 1 To $c3[0][0]
If $c3[$26][0] <> "" Then
If $c3[$26][2] = 8 Then
$7s = $c3[$26][0]
$c1 = $c3[$26][1]
EndIf
If False & StringStripWS($c3[$26][0], 1 + 2) = "NetPhone Client" Then
$18 = HWnd($c3[$26][1])
If WinActivate($18) Then
_mr($ad & $26 & ".png", $18)
EndIf
If $c3[$26][3] = 16 Then
WinSetState($18, Default, @SW_MINIMIZE)
EndIf
If $c3[$26][4] = 32 Then
WinSetState($18, Default, @SW_MAXIMIZE)
EndIf
If @error Then _10k("Error ScreenCaptureWnd")
EndIf
EndIf
Next
$18 = HWnd($c1)
$7t = WinGetProcess($18)
WinActivate($18)
Return $18
EndFunc
Func _10u(ByRef $c4, $c5)
Local $c6 = TimerDiff($c4)
If $c6 > $c5 Then
$c4 = TimerInit()
Return $c6
EndIf
Return 0
EndFunc
Func _10v()
IniWrite($9x & "Global" & ".ini", "@ComputerName", StringReplace(StringFormat("%-16s", @IPAddress1), " ", "."), @ComputerName)
_10w("", "Global", "@IPAddress1", 0, @IPAddress1)
_10w("", "Global", "$AkkVersion", 0, $7p)
_10w("", "Global", "$SpawnExists", 0, $7x)
_10w("", "Global", "$KPSInfoExists", 0, $80)
_10w("", "Global", "$PowerkatalogExists", 0, $84)
_10w("", "Global", "$SHDUpdaterExists", 0, $88)
_10w("", "Global", "$NetPhoneClientExists", 0, $8c)
_10w("", "Global", "$ActiveWinTitle", 0, $7s)
_10w("", "Global", "$hWndActivePid", 0, $7t)
_10w("", "EventLog", "$EventLogFull", 0, $at)
_10w("", "EventLog", "$EventLogCount", 0, $au)
_10w("", "EventLog", "$EventLogOldest", 0, $av)
_10w("", "SpawnStats", $7u & "TimeModified", 0, FileGetTime($7w, 0, 1))
Local $c7 = _11e()
_10w("", "Wmi", "$ComputerSystemProductName", 0, $c7[0])
_10w("", "Wmi", "$ComputerSystemProductIdentifyingNumber", 0, $c7[1])
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
Func _10w($c8, $c9, $ca, $cb, $cc)
If $c8 = "" Then
$c8 = $9x & $c9 & ".ini"
EndIf
IniWrite($c8,($cb ? $c9 & $ca : $ca), $7o, $cc)
IniWrite($a5, $c9, $ca, $cc)
EndFunc
Func _10x()
_10y($7u, $7v, $7w, $7x)
_10y("KPSInfo.exe", $7y, $7z, $80)
$ar = _10y($b2, $b3, $b4 & $bm, $b5)
EndFunc
Func _10y($cd, $ce, $cf, $cg, $ch = @SW_HIDE)
If $cg And Not ProcessExists($cd) Then
_10k($cd & " wird gestartet")
Return Run($cf, $ce, $ch)
EndIf
Return 0
EndFunc
Func _110()
If _111() Then
DirRemove($ak, 1)
_112($aj, $ak)
FileDelete($ak & "\Downloads alt.lnk")
FileCreateShortcut($ak, $aj & "\Downloads alt")
IniWrite($8y, "Downloads", "LastCleaningDate", _p5(@YEAR, @MON, @MDAY))
Local Const $ci = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $ci, $7e) = 6 Then
ShellExecute($ak)
EndIf
EndIf
EndFunc
Func _111()
Return(_p5(@YEAR, @MON, @MDAY) - _113()) >= 14
EndFunc
Func _112($cj, $ck)
If FileExists($cj) Then
If Not FileExists($ck) Then DirCreate($ck)
FileMove($cj & "\*.*", $ck, 1 + 8)
Local Const $cl = _zl($cj, Default, 2, True)
If Not @error Then
For $cm In $cl
DirMove($cm, $ck, 1)
Next
EndIf
EndIf
EndFunc
Func _113()
Return IniRead($8y, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _115()
Local Const $cn = DriveGetLabel(@HomeDrive & "\")
Local Const $co = DriveSpaceFree(@HomeDrive & "\")
Local Const $cp = DriveSpaceTotal(@HomeDrive & "\")
Local Const $cq =($co / $cp) * 100
If $cq < $an Then
If(_p5(@YEAR, @MON, @MDAY) - IniRead($8y, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($8y, "FreeSpaceCheck", "LastMailSendDate", _p5(@YEAR, @MON, @MDAY))
For $26 = 0 To 9 Step 1
If $ao[$26][0] <> "" And $ao[$26][1] = 1 Then
_10k("Sending Mail to " & $ao[$26][0])
_116($ao[$26][0], Round($cq, 2), $cn, $co, $cp)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _116($6r, $cq, $cn, $co, $cp)
Local $6p = "akk.exe (Gerrit)"
Local $6q = "akk@kuechen-brauckhoff.de"
Local $6s = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $cq & "% !"
Local $cr[0]
_yf($cr, "Akk Warnung wenig Speicherplatz auf:")
_yf($cr, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _yf($cr, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _yf($cr, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _yf($cr, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _yf($cr, @IPAddress4)
_yf($cr, $cn & " (" & @HomeDrive & ")")
_yf($cr, Round($co / 1024, 2) & " GB frei von " & Round($cp / 1024, 2) & " GB")
_yf($cr, $cq & "% frei")
Local $cs = _10f($al, $6p, $6q, $6r, $6s, $cr, $am, -1, 0)
Local $ct = @error
If $cs = 0 Then
Local Const $ci = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _z6($cr, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $ct & @CRLF
MsgBox(48 + 4096, "Warnung!", $ci)
EndIf
EndFunc
Func _117($cu)
Local $cv = ProcessList($cu)
Local $6e = "", $6f = "", $1x = "", $6g = ""
_zy($cu, $6e, $6f, $1x, $6g)
Local $cw = 'akk_process_count{computername="@ComputerName@",process="' & $1x & '"} ' & $cv[0][0]
Return $cw
EndFunc
Func _118()
If $aq And ProcessExists($b2) Then
$ap = InetGet("http://localhost:9182/metrics", $a8, 1, 1)
$aq = 0
EndIf
EndFunc
Func _119()
If Not $aq Then
If InetGetInfo($ap, 2) Then
If InetGetInfo($ap, 3) Then
If FileGetSize($a8) Then FileCopy($a8, $ab, 1 + 8)
Else
FileDelete($a8)
_10k("Error ScrapeDownload")
EndIf
InetClose($ap)
$ap = 0
$aq = 1
EndIf
EndIf
EndFunc
Func _11a()
If Not $ay Then
If FileCopy($b0, $ax, 1 + 8) Then
$ay = FileExists($ax)
EndIf
EndIf
EndFunc
Func _11b()
ProcessClose($b2)
If Not $b5 Then
Local $cx =(@OSArch = "X64") ? $bc : $b8
If FileCopy($cx, $b4, 1 + 8) Then
$b5 = FileExists($b4)
EndIf
EndIf
If Not FileExists($bf) Then DirCreate($bf)
EndFunc
Func _11c()
Local $cy = 'akk_metadata{computername="@ComputerName@",username="@UserName@"' & ',netphone_user="' &($7s = "LockScreen" ? "LockScreen" : $7r) & '"'
If $bj <> "NULL" And StringLen($bj) And Not StringIsSpace($bj) Then
$cy &= "," & $bj
EndIf
$cy &= '} 1'
$as = _xa()
Local $cz = 'akk_idletime_sec{computername="@ComputerName@"} ' & $as / 1e3
Local $d0 = MemGetStats()
Local $d1 = 'akk_memstats_load{computername="@ComputerName@"} ' & $d0[$36]
Local $d2 = 'akk_memstats_total_physram_gb{computername="@ComputerName@"} ' & Round($d0[$37] / 1024 / 1024, 2)
Local $d3 = 'akk_memstats_avail_physram_gb{computername="@ComputerName@"} ' & Round($d0[$38] / 1024 / 1024, 2)
Local $d4 = 'akk_memstats_total_pagefile_gb{computername="@ComputerName@"} ' & Round($d0[$39] / 1024 / 1024, 2)
Local $d5 = 'akk_memstats_avail_pagefile_gb{computername="@ComputerName@"} ' & Round($d0[$3a] / 1024 / 1024, 2)
Local $d6 = 'akk_memstats_total_virtual_gb{computername="@ComputerName@"} ' & Round($d0[$3b] / 1024 / 1024, 2)
Local $d7 = 'akk_memstats_avail_virtual_gb{computername="@ComputerName@"} ' & Round($d0[$3c] / 1024 / 1024, 2)
Local $d8 = 'akk_eventlog_full{computername="@ComputerName@"} ' &($at ? 1 : 0)
Local $d9 = 'akk_eventlog_count{computername="@ComputerName@"} ' & $au
Local $da = 'akk_eventlog_oldest{computername="@ComputerName@"} ' & $av
Local $db = _117("chrome.exe")
Local $dc = _117("javaw.exe")
Local $dd = _117("FusionFX.exe")
$bk[1] = $cy
$bk[2] = $cz
$bk[3] = $d1
$bk[4] = $d2
$bk[5] = $d3
$bk[6] = $d4
$bk[7] = $d5
$bk[8] = $d6
$bk[9] = $d7
$bk[10] = $d8
$bk[11] = $d9
$bk[12] = $da
$bk[13] = $db
$bk[14] = $dc
$bk[15] = $dd
$bk[0] = UBound($bk) - 1
_zr($bh, $bl)
If Not _11d($bk, $bl, 3) Then
_zs($bh, $bk, 1)
EndIf
EndFunc
Func _11d(Const ByRef $de, Const ByRef $df, $dg = 0)
If Not(IsArray($de)) Or Not(IsArray($df)) Then
Return SetError(1, 0, 0)
EndIf
Local $66 = UBound($de, 0)
If $66 <> UBound($df, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $dh = UBound($de, 1)
Local $di = UBound($de, 2)
If $dh <> UBound($df, 1) Or $di <> UBound($df, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $dj, $dk
Switch $dg
Case 0
For $26 = 0 To $dh - 1
For $5e = 0 To $di - 1
If $de[$26][$5e] <> $de[$26][$5e] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case 1
For $26 = 0 To $dh - 1
For $5e = 0 To $di - 1
$dj &= $de[$26][$5e]
$dk &= $df[$26][$5e]
Next
If $dj <> $dk Then
Return SetError(4, 0, 0)
EndIf
Next
Case 2
For $5e = 0 To $di - 1
For $26 = 0 To $dh - 1
$dj &= $de[$26][$5e]
$dk &= $df[$26][$5e]
Next
If $dj <> $dk Then
Return SetError(4, 0, 0)
EndIf
Next
Case 3
If _z6($de) <> _z6($df) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
Func _11e()
Local $dl[2] = ["(Unknown)", "(Unknown)"], $dm, $dn
$dn = ObjGet("winmgmts:\\.\root\cimv2")
$dm = $dn.ExecQuery("Select * From Win32_ComputerSystemProduct", "WQL", 0x30)
If IsObj($dm) Then
For $do In $dm
$dl[0] = $do.Name
$dl[1] = $do.IdentifyingNumber
Next
Return $dl
EndIf
Return SetError(1, 0, $dl)
EndFunc
