Global Const $0 = '{66087055-AD66-4C7C-9A18-38A2310B8337}'
Global Const $1 = '{E09D739D-CCD4-44EE-8EBA-3FBF8BE4FC58}'
Global Const $2 = '{1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}'
Global Const $3 = "struct;long X;long Y;endstruct"
Global Const $4 = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $5 = "struct;word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds;endstruct"
Global Const $6 = "struct;long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias;endstruct"
Global Const $7 = "struct;byte GUID[16];ulong NumberOfValues;ulong Type;ptr Values;endstruct"
Global Const $8 = "uint Count;" & $7
Global Const $9 = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $a = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & "ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $b = "struct;ulong Data1;ushort Data2;ushort Data3;byte Data4[8];endstruct"
Global Const $c = "dword Length;ptr Descriptor;bool InheritHandle"
Func _m($d, $e, $f = 0, $g = 0, $h = 0, $i = "wparam", $j = "lparam", $k = "lresult")
Local $l = DllCall("user32.dll", $k, "SendMessageW", "hwnd", $d, "uint", $e, $i, $f, $j, $g)
If @error Then Return SetError(@error, @extended, "")
If $h >= 0 And $h <= 4 Then Return $l[$h]
Return $l
EndFunc
Global Const $m = Ptr(-1)
Global Const $n = Ptr(-1)
Global Const $o = BitShift(0x0100, 8)
Global Const $p = BitShift(0x2000, 8)
Global Const $q = BitShift(0x8000, 8)
Global Const $r = "dword Size;dword Flags;handle hCursor;" & $3
Global Const $s = "bool Icon;dword XHotSpot;dword YHotSpot;handle hMask;handle hColor"
Func _r($t, $u, $v, $w, $x, $y, $0z, $10, $11)
Local $l = DllCall("gdi32.dll", "bool", "BitBlt", "handle", $t, "int", $u, "int", $v, "int", $w, "int", $x, "handle", $y, "int", $0z, "int", $10, "dword", $11)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _y($12)
Local $l = DllCall("user32.dll", "handle", "CopyIcon", "handle", $12)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _10($13, $w, $x)
Local $l = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $13, "int", $w, "int", $x)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _11($13)
Local $l = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $13)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _1e($13)
Local $l = DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $13)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _1f($14)
Local $l = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $14)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _1g($12)
Local $l = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $12)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _1k($13, $15, $16, $12)
Local $l = DllCall("user32.dll", "bool", "DrawIcon", "handle", $13, "int", $15, "int", $16, "handle", $12)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _2l()
Local $17 = DllStructCreate($r)
Local $18 = DllStructGetSize($17)
DllStructSetData($17, "Size", $18)
Local $19 = DllCall("user32.dll", "bool", "GetCursorInfo", "struct*", $17)
If @error Or Not $19[0] Then Return SetError(@error + 10, @extended, 0)
Local $1a[5]
$1a[0] = True
$1a[1] = DllStructGetData($17, "Flags") <> 0
$1a[2] = DllStructGetData($17, "hCursor")
$1a[3] = DllStructGetData($17, "X")
$1a[4] = DllStructGetData($17, "Y")
Return $1a
EndFunc
Func _2m($d)
Local $l = DllCall("user32.dll", "handle", "GetDC", "hwnd", $d)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _2n()
Local $l = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _2w($12)
Local $1b = DllStructCreate($s)
Local $19 = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $12, "struct*", $1b)
If @error Or Not $19[0] Then Return SetError(@error + 10, @extended, 0)
Local $1c[6]
$1c[0] = True
$1c[1] = DllStructGetData($1b, "Icon") <> 0
$1c[2] = DllStructGetData($1b, "XHotSpot")
$1c[3] = DllStructGetData($1b, "YHotSpot")
$1c[4] = DllStructGetData($1b, "hMask")
$1c[5] = DllStructGetData($1b, "hColor")
Return $1c
EndFunc
Func _3e($1d)
Local $l = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $1d)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _3m($d)
Local $1e = DllStructCreate($4)
Local $19 = DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $d, "struct*", $1e)
If @error Or Not $19[0] Then Return SetError(@error + 10, @extended, 0)
Return $1e
EndFunc
Func _3t($1f)
Local $1g = DllStructCreate($b)
_3u($1f, $1g)
If @error Then Return SetError(@error + 10, @extended, 0)
Return $1g
EndFunc
Func _3u($1f, $1g)
Local $l = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $1f, "struct*", $1g)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _50($d, $13)
Local $l = DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $d, "handle", $13)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _52($13, $1h)
Local $l = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $13, "handle", $1h)
If @error Then Return SetError(@error, @extended, False)
Return $l[0]
EndFunc
Func _5u($1g)
Local $l = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $1g, "wstr", "", "int", 40)
If @error Or Not $l[0] Then Return SetError(@error, @extended, "")
Return SetExtended($l[0], $l[2])
EndFunc
Func _67($1i, $1j = 0, $1k = True)
Local $1l = "wstr"
If Not IsString($1i) Then $1l = "struct*"
Local $l = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $1j, "dword", 0, $1l, $1i, "int", -1, "ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
If @error Or Not $l[0] Then Return SetError(@error + 20, @extended, "")
Local $1m = DllStructCreate("char[" & $l[0] & "]")
$l = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $1j, "dword", 0, $1l, $1i, "int", -1, "struct*", $1m, "int", $l[0], "ptr", 0, "ptr", 0)
If @error Or Not $l[0] Then Return SetError(@error + 10, @extended, "")
If $1k Then Return DllStructGetData($1m, 1)
Return $1m
EndFunc
Global Const $1n = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $1o = _7b()
Func _7b()
Local $1p = DllStructCreate($1n)
DllStructSetData($1p, 1, DllStructGetSize($1p))
Local $19 = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $1p)
If @error Or Not $19[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($1p, 2), -8), DllStructGetData($1p, 3))
EndFunc
Global $1q = 0
Global $1r = 0
Global $1s = 0
Global $1t = True
Func _ee($1u, $1v, $1w, $1x, $1y, $1z = 0x00021808)
Local $l = DllCall($1q, "int", "GdipCloneBitmapArea", "float", $1v, "float", $1w, "float", $1x, "float", $1y, "int", $1z, "handle", $1u, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $l[0] Then Return SetError(10, $l[0], 0)
Return $l[7]
EndFunc
Func _ei($1u, $20 = 0)
Local $l = DllCall($1q, "int", "GdipCreateBitmapFromHBITMAP", "handle", $1u, "handle", $20, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $l[0] Then Return SetError(10, $l[0], 0)
Return $l[3]
EndFunc
Func _fg()
Local $21 = _fi()
Local $22 = _fl()
Local $23 = DllStructCreate("byte[" & $22 & "]")
Local $l = DllCall($1q, "int", "GdipGetImageEncoders", "uint", $21, "uint", $22, "struct*", $23)
If @error Then Return SetError(@error, @extended, 0)
If $l[0] Then Return SetError(10, $l[0], 0)
Local $24 = DllStructGetPtr($23)
Local $25, $26[$21 + 1][14]
$26[0][0] = $21
For $27 = 1 To $21
$25 = DllStructCreate($a, $24)
$26[$27][1] = _5u(DllStructGetPtr($25, "CLSID"))
$26[$27][2] = _5u(DllStructGetPtr($25, "FormatID"))
$26[$27][3] = _67(DllStructGetData($25, "CodecName"))
$26[$27][4] = _67(DllStructGetData($25, "DllName"))
$26[$27][5] = _67(DllStructGetData($25, "FormatDesc"))
$26[$27][6] = _67(DllStructGetData($25, "FileExt"))
$26[$27][7] = _67(DllStructGetData($25, "MimeType"))
$26[$27][8] = DllStructGetData($25, "Flags")
$26[$27][9] = DllStructGetData($25, "Version")
$26[$27][10] = DllStructGetData($25, "SigCount")
$26[$27][11] = DllStructGetData($25, "SigSize")
$26[$27][12] = DllStructGetData($25, "SigPattern")
$26[$27][13] = DllStructGetData($25, "SigMask")
$24 += DllStructGetSize($25)
Next
Return $26
EndFunc
Func _fh($28)
Local $29 = _fg()
If @error Then Return SetError(@error, 0, "")
For $27 = 1 To $29[0][0]
If StringInStr($29[$27][6], "*." & $28) > 0 Then Return $29[$27][1]
Next
Return SetError(-1, -1, "")
EndFunc
Func _fi()
Local $l = DllCall($1q, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $l[0] Then Return SetError(10, $l[0], -1)
Return $l[1]
EndFunc
Func _fl()
Local $l = DllCall($1q, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $l[0] Then Return SetError(10, $l[0], -1)
Return $l[2]
EndFunc
Func _hr($2a)
Local $l = DllCall($1q, "int", "GdipDisposeImage", "handle", $2a)
If @error Then Return SetError(@error, @extended, False)
If $l[0] Then Return SetError(10, $l[0], False)
Return True
EndFunc
Func _hv($2a)
Local $l = DllCall($1q, "int", "GdipGetImageHeight", "handle", $2a, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $l[0] Then Return SetError(10, $l[0], -1)
Return $l[2]
EndFunc
Func _i2($2a)
Local $l = DllCall($1q, "int", "GdipGetImageWidth", "handle", $2a, "uint*", -1)
If @error Then Return SetError(@error, @extended, -1)
If $l[0] Then Return SetError(10, $l[0], -1)
Return $l[2]
EndFunc
Func _i7($2a, $2b, $2c, $2d = 0)
Local $1g = _3t($2c)
Local $l = DllCall($1q, "int", "GdipSaveImageToFile", "handle", $2a, "wstr", $2b, "struct*", $1g, "struct*", $2d)
If @error Then Return SetError(@error, @extended, False)
If $l[0] Then Return SetError(10, $l[0], False)
Return True
EndFunc
Func _j1(ByRef $2d, $1f, $2e, $2f, $2g)
Local $21 = DllStructGetData($2d, "Count")
Local $2h = DllStructGetPtr($2d, "GUID") +($21 * _j3())
Local $2i = DllStructCreate($7, $2h)
_3u($1f, $2h)
DllStructSetData($2i, "Type", $2f)
DllStructSetData($2i, "NumberOfValues", $2e)
DllStructSetData($2i, "Values", $2g)
DllStructSetData($2d, "Count", $21 + 1)
EndFunc
Func _j2($21)
Local $2j = $8
For $2k = 2 To $21
$2j &= ";struct;byte[16];ulong;ulong;ptr;endstruct"
Next
Return DllStructCreate($2j)
EndFunc
Func _j3()
Local $2i = DllStructCreate($7)
Return DllStructGetSize($2i)
EndFunc
Func _lw()
If $1q = 0 Then Return SetError(-1, -1, False)
$1r -= 1
If $1r = 0 Then
DllCall($1q, "none", "GdiplusShutdown", "ulong_ptr", $1s)
DllClose($1q)
$1q = 0
EndIf
Return True
EndFunc
Func _lx($2l = Default, $2m = False)
$1r += 1
If $1r > 1 Then Return True
If $2l = Default Then $2l = "gdiplus.dll"
$1q = DllOpen($2l)
If $1q = -1 Then
$1r = 0
Return SetError(1, 2, False)
EndIf
Local $2n = FileGetVersion($2l)
$2n = StringSplit($2n, ".")
If $2n[1] > 5 Then $1t = False
Local $2o = DllStructCreate($9)
Local $2p = DllStructCreate("ulong_ptr Data")
DllStructSetData($2o, "Version", 1)
Local $l = DllCall($1q, "int", "GdiplusStartup", "struct*", $2p, "struct*", $2o, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $l[0] Then Return SetError(10, $l[0], False)
$1s = DllStructGetData($2p, "Data")
If $2m Then Return $1q
Return SetExtended($2n[1], True)
EndFunc
Func _m9($2b, $2q = True)
Local $1d = _ma(".\:", $2b)
If($1d > 0) And(StringMid($2b, $1d, 1) = '.') Then
If $2q Then
Return StringMid($2b, $1d + 1)
Else
Return StringMid($2b, $1d)
EndIf
Else
Return ""
EndIf
EndFunc
Func _ma($2r, $2s)
Local $2t, $2u
For $27 = 1 To StringLen($2r)
$2t = StringMid($2r, $27, 1)
$2u = StringInStr($2s, $2t, 0, -1)
If $2u > 0 Then Return $2u
Next
EndFunc
Global $2v = 0x00021808
Global $2w = 100
Global $2x = 24
Global $2y = 2
Global Const $2z = 0x00CC0020
Func _n4($2b = "", $30 = 0, $31 = 0, $32 = -1, $33 = -1, $34 = True)
Local $35 = False
If $32 = -1 Then $32 = _3e(0) - 1
If $33 = -1 Then $33 = _3e(1) - 1
If $32 < $30 Then Return SetError(-1, 0, $35)
If $33 < $31 Then Return SetError(-2, 0, $35)
Local $36 =($32 - $30) + 1
Local $37 =($33 - $31) + 1
Local $d = _2n()
Local $38 = _2m($d)
Local $39 = _11($38)
Local $3a = _10($38, $36, $37)
_52($39, $3a)
_r($39, 0, 0, $36, $37, $38, $30, $31, $2z)
If $34 Then
Local $1a = _2l()
If Not @error And $1a[1] Then
$34 = True
Local $12 = _y($1a[2])
Local $1c = _2w($12)
If Not @error Then
_1f($1c[4])
If $1c[5] <> 0 Then _1f($1c[5])
_1k($39, $1a[3] - $1c[2] - $30, $1a[4] - $1c[3] - $31, $12)
EndIf
_1g($12)
EndIf
EndIf
_50($d, $38)
_1e($39)
If $2b = "" Then Return $3a
$35 = _n6($2b, $3a, True)
Return SetError(@error, @extended, $35)
EndFunc
Func _n5($2b, $d, $30 = 0, $31 = 0, $32 = -1, $33 = -1, $34 = True)
If Not IsHWnd($d) Then $d = WinGetHandle($d)
Local $1e = DllStructCreate($4)
Local Const $3b = 9
Local $35 = DllCall("dwmapi.dll", "long", "DwmGetWindowAttribute", "hwnd", $d, "dword", $3b, "struct*", $1e, "dword", DllStructGetSize($1e))
If(@error Or $35[0] Or(Abs(DllStructGetData($1e, "Left")) + Abs(DllStructGetData($1e, "Top")) + Abs(DllStructGetData($1e, "Right")) + Abs(DllStructGetData($1e, "Bottom"))) = 0) Then
$1e = _3m($d)
If @error Then Return SetError(@error + 10, @extended, False)
EndIf
$30 += DllStructGetData($1e, "Left")
$31 += DllStructGetData($1e, "Top")
If $32 = -1 Then $32 = DllStructGetData($1e, "Right") - DllStructGetData($1e, "Left") - 1
If $33 = -1 Then $33 = DllStructGetData($1e, "Bottom") - DllStructGetData($1e, "Top") - 1
$32 += DllStructGetData($1e, "Left")
$33 += DllStructGetData($1e, "Top")
If $30 > DllStructGetData($1e, "Right") Then $30 = DllStructGetData($1e, "Left")
If $31 > DllStructGetData($1e, "Bottom") Then $31 = DllStructGetData($1e, "Top")
If $32 > DllStructGetData($1e, "Right") Then $32 = DllStructGetData($1e, "Right") - 1
If $33 > DllStructGetData($1e, "Bottom") Then $33 = DllStructGetData($1e, "Bottom") - 1
$35 = _n4($2b, $30, $31, $32, $33, $34)
Return SetError(@error, @extended, $35)
EndFunc
Func _n6($2b, $1u, $3c = True)
_lx()
If @error Then Return SetError(-1, -1, False)
Local $3d = StringUpper(_m9($2b))
Local $3e = _fh($3d)
If $3e = "" Then Return SetError(-2, -2, False)
Local $2a = _ei($1u)
If @error Then Return SetError(-3, -3, False)
Local $3f, $2d
Switch $3d
Case "BMP"
Local $15 = _i2($2a)
Local $16 = _hv($2a)
Local $3g = _ee($2a, 0, 0, $15, $16, $2v)
_hr($2a)
$2a = $3g
Case "JPG", "JPEG"
$2d = _j2(1)
$3f = DllStructCreate("int Quality")
DllStructSetData($3f, "Quality", $2w)
_j1($2d, $2, 1, 4, DllStructGetPtr($3f))
Case "TIF", "TIFF"
$2d = _j2(2)
$3f = DllStructCreate("int ColorDepth;int Compression")
DllStructSetData($3f, "ColorDepth", $2x)
DllStructSetData($3f, "Compression", $2y)
_j1($2d, $0, 1, 4, DllStructGetPtr($3f, "ColorDepth"))
_j1($2d, $1, 1, 4, DllStructGetPtr($3f, "Compression"))
EndSwitch
Local $3h = 0
If IsDllStruct($2d) Then $3h = $2d
Local $35 = _i7($2a, $2b, $3e, $3h)
_hr($2a)
If $3c Then _1f($1u)
_lw()
Return SetError($35 = False, 0, $35)
EndFunc
Global Enum $3i, $3j, $3k, $3l, $3m, $3n, $3o
Func _nb(ByRef $3p, $3q, $3r = 0, $3s = "|", $3t = @CRLF, $3u = $3i)
If $3r = Default Then $3r = 0
If $3s = Default Then $3s = "|"
If $3t = Default Then $3t = @CRLF
If $3u = Default Then $3u = $3i
If Not IsArray($3p) Then Return SetError(1, 0, -1)
Local $3v = UBound($3p, 1)
Local $3w = 0
Switch $3u
Case $3k
$3w = Int
Case $3l
$3w = Number
Case $3m
$3w = Ptr
Case $3n
$3w = Hwnd
Case $3o
$3w = String
EndSwitch
Switch UBound($3p, 0)
Case 1
If $3u = $3j Then
ReDim $3p[$3v + 1]
$3p[$3v] = $3q
Return $3v
EndIf
If IsArray($3q) Then
If UBound($3q, 0) <> 1 Then Return SetError(5, 0, -1)
$3w = 0
Else
Local $3x = StringSplit($3q, $3s, 2 + 1)
If UBound($3x, 1) = 1 Then
$3x[0] = $3q
EndIf
$3q = $3x
EndIf
Local $3y = UBound($3q, 1)
ReDim $3p[$3v + $3y]
For $2k = 0 To $3y - 1
If IsFunc($3w) Then
$3p[$3v + $2k] = $3w($3q[$2k])
Else
$3p[$3v + $2k] = $3q[$2k]
EndIf
Next
Return $3v + $3y - 1
Case 2
Local $3z = UBound($3p, 2)
If $3r < 0 Or $3r > $3z - 1 Then Return SetError(4, 0, -1)
Local $40, $41 = 0, $42
If IsArray($3q) Then
If UBound($3q, 0) <> 2 Then Return SetError(5, 0, -1)
$40 = UBound($3q, 1)
$41 = UBound($3q, 2)
$3w = 0
Else
Local $43 = StringSplit($3q, $3t, 2 + 1)
$40 = UBound($43, 1)
Local $3x[$40][0], $44
For $2k = 0 To $40 - 1
$44 = StringSplit($43[$2k], $3s, 2 + 1)
$42 = UBound($44)
If $42 > $41 Then
$41 = $42
ReDim $3x[$40][$41]
EndIf
For $45 = 0 To $42 - 1
$3x[$2k][$45] = $44[$45]
Next
Next
$3q = $3x
EndIf
If UBound($3q, 2) + $3r > UBound($3p, 2) Then Return SetError(3, 0, -1)
ReDim $3p[$3v + $40][$3z]
For $46 = 0 To $40 - 1
For $45 = 0 To $3z - 1
If $45 < $3r Then
$3p[$46 + $3v][$45] = ""
ElseIf $45 - $3r > $41 - 1 Then
$3p[$46 + $3v][$45] = ""
Else
If IsFunc($3w) Then
$3p[$46 + $3v][$45] = $3w($3q[$46][$45 - $3r])
Else
$3p[$46 + $3v][$45] = $3q[$46][$45 - $3r]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($3p, 1) - 1
EndFunc
Func _o2(Const ByRef $3p, $47 = "|", $48 = -1, $49 = -1, $3t = @CRLF, $4a = -1, $4b = -1)
If $47 = Default Then $47 = "|"
If $3t = Default Then $3t = @CRLF
If $48 = Default Then $48 = -1
If $49 = Default Then $49 = -1
If $4a = Default Then $4a = -1
If $4b = Default Then $4b = -1
If Not IsArray($3p) Then Return SetError(1, 0, -1)
Local $3v = UBound($3p, 1) - 1
If $48 = -1 Then $48 = 0
If $49 = -1 Then $49 = $3v
If $48 < -1 Or $49 < -1 Then Return SetError(3, 0, -1)
If $48 > $3v Or $49 > $3v Then Return SetError(3, 0, "")
If $48 > $49 Then Return SetError(4, 0, -1)
Local $4c = ""
Switch UBound($3p, 0)
Case 1
For $2k = $48 To $49
$4c &= $3p[$2k] & $47
Next
Return StringTrimRight($4c, StringLen($47))
Case 2
Local $3z = UBound($3p, 2) - 1
If $4a = -1 Then $4a = 0
If $4b = -1 Then $4b = $3z
If $4a < -1 Or $4b < -1 Then Return SetError(5, 0, -1)
If $4a > $3z Or $4b > $3z Then Return SetError(5, 0, -1)
If $4a > $4b Then Return SetError(6, 0, -1)
For $2k = $48 To $49
For $45 = $4a To $4b
$4c &= $3p[$2k][$45] & $47
Next
$4c = StringTrimRight($4c, StringLen($47)) & $3t
Next
Return StringTrimRight($4c, StringLen($3t))
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Global Enum $4d, $4e, $4f, $4g
Func _oh(Const ByRef $4h, Const ByRef $4i, $4j = $4d)
If Not(IsArray($4h)) Or Not(IsArray($4i)) Then
Return SetError(1, 0, 0)
EndIf
Local $4k = UBound($4h, 0)
If $4k <> UBound($4i, 0) Then
Return SetError(2, 0, 0)
EndIf
Local $4l = UBound($4h, 1)
Local $4m = UBound($4h, 2)
If $4l <> UBound($4i, 1) Or $4m <> UBound($4i, 2) Then
Return SetError(3, 0, 0)
EndIf
Local $4n, $4o
Switch $4j
Case $4d
For $2k = 0 To $4l - 1
For $45 = 0 To $4m - 1
If $4h[$2k][$45] <> $4h[$2k][$45] Then
Return SetError(4, 0, 0)
EndIf
Next
Next
Case $4e
For $2k = 0 To $4l - 1
For $45 = 0 To $4m - 1
$4n &= $4h[$2k][$45]
$4o &= $4i[$2k][$45]
Next
If $4n <> $4o Then
Return SetError(4, 0, 0)
EndIf
Next
Case $4f
For $45 = 0 To $4m - 1
For $2k = 0 To $4l - 1
$4n &= $4h[$2k][$45]
$4o &= $4i[$2k][$45]
Next
If $4n <> $4o Then
Return SetError(4, 0, 0)
EndIf
Next
Case $4g
If _o2($4h) <> _o2($4i) Then
Return SetError(4, 0, 0)
EndIf
EndSwitch
Return 1
EndFunc
Global Const $4p = 0x007F
Func _p2($4q = 0, $4r = 0, $4s = 0, $4t = '')
If Not $4q Then $4q = 0x0400
Local $4u = 'wstr'
If Not StringStripWS($4t, 1 + 2) Then
$4u = 'ptr'
$4t = 0
EndIf
Local $19 = DllCall('kernel32.dll', 'int', 'GetDateFormatW', 'dword', $4q, 'dword', $4s, 'struct*', $4r, $4u, $4t, 'wstr', '', 'int', 2048)
If @error Or Not $19[0] Then Return SetError(@error, @extended, '')
Return $19[5]
EndFunc
Func _pq($4v, $1z = Default)
Local Const $4w = 128
If $1z = Default Then $1z = 0
$4v = Int($4v)
If $4v < 1 Or $4v > 7 Then Return SetError(1, 0, "")
Local $4r = DllStructCreate($5)
DllStructSetData($4r, "Year", BitAND($1z, $4w) ? 2007 : 2006)
DllStructSetData($4r, "Month", 1)
DllStructSetData($4r, "Day", $4v)
Return _p2(BitAND($1z, 2) ? 0x0400 : $4p, $4r, 0, BitAND($1z, 1) ? "ddd" : "dddd")
EndFunc
Func _pt($4x)
If StringIsInt($4x) Then
Select
Case Mod($4x, 4) = 0 And Mod($4x, 100) <> 0
Return 1
Case Mod($4x, 400) = 0
Return 1
Case Else
Return 0
EndSelect
EndIf
Return SetError(1, 0, 0)
EndFunc
Func _pu($4y)
$4y = Int($4y)
Return $4y >= 1 And $4y <= 12
EndFunc
Func _pv($4z)
Local $50[4], $51[4]
_q4($4z, $50, $51)
If Not StringIsInt($50[1]) Then Return 0
If Not StringIsInt($50[2]) Then Return 0
If Not StringIsInt($50[3]) Then Return 0
$50[1] = Int($50[1])
$50[2] = Int($50[2])
$50[3] = Int($50[3])
Local $52 = _qn($50[1])
If $50[1] < 1000 Or $50[1] > 2999 Then Return 0
If $50[2] < 1 Or $50[2] > 12 Then Return 0
If $50[3] < 1 Or $50[3] > $52[$50[2]] Then Return 0
If $51[0] < 1 Then Return 1
If $51[0] < 2 Then Return 0
If $51[0] = 2 Then $51[3] = "00"
If Not StringIsInt($51[1]) Then Return 0
If Not StringIsInt($51[2]) Then Return 0
If Not StringIsInt($51[3]) Then Return 0
$51[1] = Int($51[1])
$51[2] = Int($51[2])
$51[3] = Int($51[3])
If $51[1] < 0 Or $51[1] > 23 Then Return 0
If $51[2] < 0 Or $51[2] > 59 Then Return 0
If $51[3] < 0 Or $51[3] > 59 Then Return 0
Return 1
EndFunc
Func _q4($4z, ByRef $53, ByRef $54)
Local $55 = StringSplit($4z, " T")
If $55[0] > 0 Then $53 = StringSplit($55[1], "/-.")
If $55[0] > 1 Then
$54 = StringSplit($55[2], ":")
If UBound($54) < 4 Then ReDim $54[4]
Else
Dim $54[4]
EndIf
If UBound($53) < 4 Then ReDim $53[4]
For $56 = 1 To 3
If StringIsInt($53[$56]) Then
$53[$56] = Int($53[$56])
Else
$53[$56] = -1
EndIf
If StringIsInt($54[$56]) Then
$54[$56] = Int($54[$56])
Else
$54[$56] = 0
EndIf
Next
Return 1
EndFunc
Func _q7($4x, $57, $58)
If Not _pv(StringFormat("%04d/%02d/%02d", $4x, $57, $58)) Then
Return SetError(1, 0, "")
EndIf
If $57 < 3 Then
$57 = $57 + 12
$4x = $4x - 1
EndIf
Local $59 = Int($4x / 100)
Local $5a = Int($59 / 4)
Local $5b = 2 - $59 + $5a
Local $5c = Int(1461 *($4x + 4716) / 4)
Local $5d = Int(153 *($57 + 1) / 5)
Local $5e = $5b + $58 + $5c + $5d - 1524.5
Return $5e
EndFunc
Func _q8($5f, $1z = Default)
If $1z = Default Then $1z = 0
$5f = Int($5f)
If Not _pu($5f) Then Return SetError(1, 0, "")
Local $4r = DllStructCreate($5)
DllStructSetData($4r, "Year", @YEAR)
DllStructSetData($4r, "Month", $5f)
DllStructSetData($4r, "Day", 1)
Return _p2(BitAND($1z, 2) ? 0x0400 : $4p, $4r, 0, BitAND($1z, 1) ? "MMM" : "MMMM")
EndFunc
Func _qn($4x)
Local $5g = [12, 31,(_pt($4x) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Return $5g
EndFunc
Func _qo($5h)
Local $5i = DllStructCreate($5, $5h)
Local $5j = DllStructCreate($5)
DllStructSetData($5j, "Month", DllStructGetData($5i, "Month"))
DllStructSetData($5j, "Day", DllStructGetData($5i, "Day"))
DllStructSetData($5j, "Year", DllStructGetData($5i, "Year"))
DllStructSetData($5j, "Hour", DllStructGetData($5i, "Hour"))
DllStructSetData($5j, "Minute", DllStructGetData($5i, "Minute"))
DllStructSetData($5j, "Second", DllStructGetData($5i, "Second"))
DllStructSetData($5j, "MSeconds", DllStructGetData($5i, "MSeconds"))
DllStructSetData($5j, "DOW", DllStructGetData($5i, "DOW"))
Return $5j
EndFunc
Func _rb()
Local $5k = DllStructCreate($6)
Local $l = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "struct*", $5k)
If @error Or $l[0] = -1 Then Return SetError(@error, @extended, 0)
Local $26[8]
$26[0] = $l[0]
$26[1] = DllStructGetData($5k, "Bias")
$26[2] = _67(DllStructGetPtr($5k, "StdName"))
$26[3] = _qo(DllStructGetPtr($5k, "StdDate"))
$26[4] = DllStructGetData($5k, "StdBias")
$26[5] = _67(DllStructGetPtr($5k, "DayName"))
$26[6] = _qo(DllStructGetPtr($5k, "DayDate"))
$26[7] = DllStructGetData($5k, "DayBias")
Return $26
EndFunc
Global $5l
Func _rr($5m)
Local $l = DllCall("advapi32.dll", "bool", "CloseEventLog", "handle", $5m)
If @error Then Return SetError(@error, @extended, False)
Return $l[0] <> 0
EndFunc
Func _rs($5m)
Local $l = DllCall("advapi32.dll", "bool", "GetNumberOfEventLogRecords", "handle", $5m, "dword*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $l[0] = 0 Then Return -1
Return $l[2]
EndFunc
Func _s5($5m)
Local $l = DllCall("advapi32.dll", "bool", "GetEventLogInformation", "handle", $5m, "dword", 0, "dword*", 0, "dword", 4, "dword*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $l[3] <> 0
EndFunc
Func _s7($5m)
Local $l = DllCall("advapi32.dll", "bool", "GetOldestEventLogRecord", "handle", $5m, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return $l[2]
EndFunc
Func _s8($5n, $5o)
$5l = $5o
Local $l = DllCall("advapi32.dll", "handle", "OpenEventLogW", "wstr", $5n, "wstr", $5o)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _sd($5p)
Local $5q = FileOpen($5p, 0)
If $5q = -1 Then Return SetError(1, 0, 0)
Local $5r = StringStripWS(FileRead($5q), 2)
FileClose($5q)
Return UBound(StringRegExp($5r, "\R", 3)) + 1 - Int($5r = "")
EndFunc
Func _sf($5p, $5s = "*", $5t = 0, $5u = False)
Local $2t = "|", $5v = "", $2b = "", $5w = ""
$5p = StringRegExpReplace($5p, "[\\/]+$", "") & "\"
If $5t = Default Then $5t = 0
If $5u Then $5w = $5p
If $5s = Default Then $5s = "*"
If Not FileExists($5p) Then Return SetError(1, 0, 0)
If StringRegExp($5s, "[\\/:><\|]|(?s)^\s*$") Then Return SetError(2, 0, 0)
If Not($5t = 0 Or $5t = 1 Or $5t = 2) Then Return SetError(3, 0, 0)
Local $5x = FileFindFirstFile($5p & $5s)
If @error Then Return SetError(4, 0, 0)
While 1
$2b = FileFindNextFile($5x)
If @error Then ExitLoop
If($5t + @extended = 2) Then ContinueLoop
$5v &= $2t & $5w & $2b
WEnd
FileClose($5x)
If $5v = "" Then Return SetError(4, 0, 0)
Return StringSplit(StringTrimLeft($5v, 1), $2t)
EndFunc
Func _sl($5p, ByRef $5y, $4s = 1, $2t = "")
$5y = 0
If $4s = Default Then $4s = 1
If $2t = Default Then $2t = ""
Local $5z = True
If BitAND($4s, 2) Then
$5z = False
$4s -= 2
EndIf
Local $60 = 0
If BitAND($4s, 4) Then
$60 = 1
$4s -= 4
EndIf
Local $61 = 0
If $4s <> 1 Then
$4s = 0
$61 = 2
EndIf
If $2t Then
Local $62 = FileReadToArray($5p)
If @error Then Return SetError(@error, 0, 0)
Local $3v = UBound($62) + $4s
If $5z Then
Local $3z = UBound(StringSplit($62[0], $2t, $60 + 2))
Local $63[$3v][$3z]
Local $64, $65
For $2k = 0 To $3v - $4s - 1
$65 = StringSplit($62[$2k], $2t, $60 + 2)
$64 = UBound($65)
If $64 <> $3z Then
Return SetError(3, 0, 0)
EndIf
For $45 = 0 To $64 - 1
$63[$2k + $4s][$45] = $65[$45]
Next
Next
If $3z < 2 Then Return SetError(4, 0, 0)
If $4s Then
$63[0][0] = $3v - $4s
$63[0][1] = $3z
EndIf
Else
Local $63[$3v]
For $2k = 0 To $3v - $4s - 1
$63[$2k + $4s] = StringSplit($62[$2k], $2t, $60 + $61)
Next
If $4s Then
$63[0] = $3v - $4s
EndIf
EndIf
$5y = $63
Else
If $4s Then
Local $5q = FileOpen($5p, 0)
If $5q = -1 Then Return SetError(1, 0, 0)
Local $5r = FileRead($5q)
FileClose($5q)
If StringLen($5r) Then
$5y = StringRegExp(@LF & $5r, "(?|(\N+)\z|(\N*)(?:\R))", 3)
$5y[0] = UBound($5y) - 1
Else
Return SetError(2, 0, 0)
EndIf
Else
$5y = FileReadToArray($5p)
If @error Then
$5y = 0
Return SetError(@error, 0, 0)
EndIf
EndIf
EndIf
Return 1
EndFunc
Func _sm($5p, Const ByRef $3p, $66 = Default, $67 = Default, $2t = "|")
Local $h = 0
If Not IsArray($3p) Then Return SetError(2, 0, $h)
Local $4k = UBound($3p, 0)
If $4k > 2 Then Return SetError(4, 0, 0)
Local $68 = UBound($3p) - 1
If $67 = Default Or $67 > $68 Then $67 = $68
If $66 < 0 Or $66 = Default Then $66 = 0
If $66 > $67 Then Return SetError(5, 0, $h)
If $2t = Default Then $2t = "|"
Local $5q = $5p
If IsString($5p) Then
$5q = FileOpen($5p, 2)
If $5q = -1 Then Return SetError(1, 0, $h)
EndIf
Local $69 = 0
$h = 1
Switch $4k
Case 1
For $2k = $66 To $67
If Not FileWrite($5q, $3p[$2k] & @CRLF) Then
$69 = 3
$h = 0
ExitLoop
EndIf
Next
Case 2
Local $6a = ""
For $2k = $66 To $67
$6a = $3p[$2k][0]
For $45 = 1 To UBound($3p, 2) - 1
$6a &= $2t & $3p[$2k][$45]
Next
If Not FileWrite($5q, $6a & @CRLF) Then
$69 = 3
$h = 0
ExitLoop
EndIf
Next
EndSwitch
If IsString($5p) Then FileClose($5q)
Return SetError($69, 0, $h)
EndFunc
Func _sn($6b, $6c, $5t = -1)
Local $6d = 1
Local $6e = @YEAR & "-" & @MON & "-" & @MDAY
Local $6f = @HOUR & ":" & @MIN & ":" & @SEC
Local $6g = $6e & " " & $6f & " : " & $6c
If $5t = Default Then $5t = -1
If $5t <> -1 Then
$6d = 2
$6g &= @CRLF & FileRead($6b)
EndIf
Local $5q = $6b
If IsString($6b) Then
$5q = FileOpen($6b, $6d)
EndIf
If $5q = -1 Then Return SetError(1, 0, 0)
Local $h = FileWriteLine($5q, $6g)
If IsString($6b) Then $h = FileClose($5q)
If $h <= 0 Then Return SetError(2, $h, 0)
Return $h
EndFunc
Func _ss($5p, ByRef $6h, ByRef $6i, ByRef $2b, ByRef $6j)
Local $3p = StringRegExp($5p, "^\h*((?:\\\\\?\\)*(\\\\[^\?\/\\]+|[A-Za-z]:)?(.*[\/\\]\h*)?((?:[^\.\/\\]|(?(?=\.[^\/\\]*\.)\.))*)?([^\/\\]*))$", 1)
If @error Then
ReDim $3p[5]
$3p[0] = $5p
EndIf
$6h = $3p[1]
If StringLeft($3p[2], 1) == "/" Then
$6i = StringRegExpReplace($3p[2], "\h*[\/\\]+\h*", "\/")
Else
$6i = StringRegExpReplace($3p[2], "\h*[\/\\]+\h*", "\\")
EndIf
$3p[2] = $6i
$2b = $3p[3]
$6j = $3p[4]
Return $3p
EndFunc
Global Const $6k = 0x000E
Func _zv()
Local $6l = DllStructCreate("uint;dword")
DllStructSetData($6l, 1, DllStructGetSize($6l))
Local $l = DllCall("user32.dll", "bool", "GetLastInputInfo", "struct*", $6l)
If @error Or $l[0] = 0 Then Return SetError(@error, @extended, 0)
Local $6m = DllCall("kernel32.dll", "dword", "GetTickCount")
If @error Or Not $l[0] Then Return SetError(@error, @extended, 0)
Local $6n = $6m[0] - DllStructGetData($6l, 2)
If $6n < 0 Then Return SetExtended(1, $6m[0])
Return $6n
EndFunc
Global Const $6o = "Debug Window hidden text"
Global $6p = "AutoIt Debug Report"
Global $6q = True, $6r = True
Global $6s = 0
Func _10f()
Local $6t = Opt("WinDetectHiddenText", 1)
Local $6u = WinExists($6p, $6o)
If $6u Then
If $6s = 0 Then
$6s = ControlGetHandle($6p, $6o, "Edit1")
$6q = False
EndIf
EndIf
Opt("WinDetectHiddenText", $6t)
$6r = False
If Not $6q Then Return 0
Local Const $6v = 0x00CF0000
Local Const $6w = 0x00100000
Local Const $6x = 0x00200000
Local Const $6y = 2048
Local Const $6z = 0xC5
Local Const $70 = 32
Local $71 = 580, $72 = 280
GUICreate($6p, $71, $72, -1, -1, $6v)
Local $73 = GUICtrlCreateLabel($6o, 0, 0, 1, 1)
GUICtrlSetState($73, $70)
Local $74 = GUICtrlCreateEdit("", 4, 4, $71 - 8, $72 - 8, BitOR($6w, $6x, $6y))
$6s = GUICtrlGetHandle($74)
GUICtrlSetBkColor($74, 0xFFFFFF)
GUICtrlSendMsg($74, $6z, 0, 0)
GUISetState()
$6q = True
Return 1
EndFunc
#Au3Stripper_Off
Func __Debug_ReportWindowWrite($sData)
#Au3Stripper_On
If $6r Then _10f()
Local Const $6k = 0x000E
Local Const $75 = 0xB1
Local Const $76 = 0xC2
Local $77 = _m($6s, $6k, 0, 0, 0, "int", "int")
_m($6s, $75, $77, $77, 0, "int", "int")
_m($6s, $76, True, $78, 0, "int", "wstr")
EndFunc
Func _10h()
Local $6u = WinExists($6p)
If $6u Then
If $6s = 0 Then
$6s = WinGetHandle($6p)
Return 0
EndIf
EndIf
Local $79 = Run("Notepad.exe")
$6s = WinWait("[CLASS:Notepad]")
If $79 <> WinGetProcess($6s) Then
Return SetError(3, 0, 0)
EndIf
WinActivate($6s)
WinSetTitle($6s, "", String($6p))
Return 1
EndFunc
#Au3Stripper_Off
Func __Debug_ReportNotepadWrite($sData)
#Au3Stripper_On
If $6s = 0 Then _10h()
ControlCommand($6s, "", "Edit1", "EditPaste", String($78))
EndFunc
Func _10n($7a, $7b, $7c, $7d, $7e = "", $7f = "", $7g = "", $7h = "", $7i = 0)
If $7a = "" Or $7c = "" Or $7d = "" Or $7b = "" Or StringLen($7b) > 256 Then Return SetError(1, 0, 0)
If $7g = "" Then $7g = @ComputerName
If TCPStartup() = 0 Then Return SetError(2, 0, 0)
Local $7j, $7k
If StringRegExp($7a, "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") Then
$7j = $7a
Else
$7j = TCPNameToIP($7a)
EndIf
If $7j = "" Then
TCPShutdown()
Return SetError(3, 0, 0)
EndIf
Local $7l = TCPConnect($7j, 25)
If $7l = -1 Then
TCPShutdown()
Return SetError(4, 0, 0)
EndIf
Local $7m[6], $7n[6]
$7m[0] = "HELO " & $7g & @CRLF
If StringLeft($7g, 5) = "EHLO " Then $7m[0] = $7g & @CRLF
$7n[0] = "250"
$7m[1] = "MAIL FROM: <" & $7c & ">" & @CRLF
$7n[1] = "250"
$7m[2] = "RCPT TO: <" & $7d & ">" & @CRLF
$7n[2] = "250"
$7m[3] = "DATA" & @CRLF
$7n[3] = "354"
Local $l = _rb()
Local $7o = -$l[1] / 60
Local $7p = Int($7o)
Local $7q = 0
If $7p <> $7o Then $7q = Abs($7o - $7p) * 60
$7o = StringFormat(" (%+.2d%.2d)", $7p, $7q)
$7m[4] = "From:" & $7b & "<" & $7c & ">" & @CRLF & "To:" & "<" & $7d & ">" & @CRLF & "Subject:" & $7e & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _pq(@WDAY, 1) & ", " & @MDAY & " " & _q8(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $7o & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$7n[4] = ""
$7m[5] = @CRLF & "." & @CRLF
$7n[5] = "250"
If _10p($7l, $7m[0], $7n[0], $7i, "220", $7h) Then Return SetError(50, 0, 0)
For $7k = 1 To UBound($7m) - 2
If _10p($7l, $7m[$7k], $7n[$7k], $7i) Then Return SetError(50 + $7k, 0, 0)
Next
For $7k = 0 To UBound($7f) - 1
If StringLeft($7f[$7k], 1) = "." Then $7f[$7k] = "." & $7f[$7k]
If _10p($7l, $7f[$7k] & @CRLF, "", $7i) Then Return SetError(500 + $7k, 0, 0)
Next
$7k = UBound($7m) - 1
If _10p($7l, $7m[$7k], $7n[$7k], $7i) Then Return SetError(5000, 0, 0)
TCPCloseSocket($7l)
TCPShutdown()
Return 1
EndFunc
Func _10o($7r, $7s = 0)
Local $7t = "SMTP trace"
Local $7u = ControlGetText($7t, "", "Static1")
$7r = StringLeft(StringReplace($7r, @CRLF, ""), 70)
$7u &= @HOUR & ":" & @MIN & ":" & @SEC & " " & $7r & @LF
If WinExists($7t) Then
ControlSetText($7t, "", "Static1", $7u)
Else
SplashTextOn($7t, $7u, 400, 500, 500, 100, 4 + 16, "", 8)
EndIf
If $7s Then Sleep($7s * 1000)
EndFunc
Func _10p($7l, $7v, $7w, $7i, $7x = "", $7h = "")
Local $7y, $2k, $7z
If $7i Then _10o($7v)
If $7x <> "" Then
If $7h <> -1 Then
If TCPSend($7l, $7h) = 0 Then
TCPCloseSocket($7l)
TCPShutdown()
Return 1
EndIf
EndIf
$7y = ""
$7z = TimerInit()
While StringLeft($7y, StringLen($7x)) <> $7x And TimerDiff($7z) < 45000
$7y = TCPRecv($7l, 1000)
If $7i And $7y <> "" Then _10o("intermediate->" & $7y)
WEnd
EndIf
If TCPSend($7l, $7v) = 0 Then
TCPCloseSocket($7l)
TCPShutdown()
Return 1
EndIf
$7z = TimerInit()
$7y = ""
While $7y = "" And TimerDiff($7z) < 45000
$2k += 1
$7y = TCPRecv($7l, 1000)
If $7w = "" Then ExitLoop
WEnd
If $7w <> "" Then
If $7i Then _10o($2k & " <- " & $7y)
If StringLeft($7y, StringLen($7w)) <> $7w Then
TCPCloseSocket($7l)
TCPShutdown()
If $7i Then _10o("<-> " & $7w, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Func _10w($80, $5t = 0)
Local Const $81 = 183
Local Const $82 = 1
Local $83 = 0
If BitAND($5t, 2) Then
Local $84 = DllStructCreate("byte;byte;word;ptr[4]")
Local $19 = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "struct*", $84, "dword", $82)
If @error Then Return SetError(@error, @extended, 0)
If $19[0] Then
$19 = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "struct*", $84, "bool", 1, "ptr", 0, "bool", 0)
If @error Then Return SetError(@error, @extended, 0)
If $19[0] Then
$83 = DllStructCreate($c)
DllStructSetData($83, 1, DllStructGetSize($83))
DllStructSetData($83, 2, DllStructGetPtr($84))
DllStructSetData($83, 3, 0)
EndIf
EndIf
EndIf
Local $85 = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $83, "bool", 1, "wstr", $80)
If @error Then Return SetError(@error, @extended, 0)
Local $86 = DllCall("kernel32.dll", "dword", "GetLastError")
If @error Then Return SetError(@error, @extended, 0)
If $86[0] = $81 Then
If BitAND($5t, 1) Then
DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $85[0])
If @error Then Return SetError(@error, @extended, 0)
Return SetError($86[0], $86[0], 0)
Else
Exit -1
EndIf
EndIf
Return $85[0]
EndFunc
Opt('ExpandVarStrings', 1)
Opt('MustDeclareVars', 1)
Opt('TrayAutoPause', 0)
ConsoleWrite(@CRLF)
Global Const $87 = 60 * 5
Global $88 = 0
Global $89 = TimerInit()
Global $8a = $89
Global $8b = $89
Global $8c = $89
Global $8d = $89
Global $8e = $89
Global $8f = $89
Global Const $8g = StringReplace(StringFormat("%-16s", @ComputerName), " ", ".")
Global Const $8h = FileGetVersion(@ScriptFullPath)
Global $8i = ""
Global $8j
Global $8k
Global $8l
Global Const $8m = "ShadowSpawn.exe"
Global Const $8n = @MyDocumentsDir & "\Isopedia GmbH\ShadowSpawn\"
Global Const $8o = $8n & $8m
Global Const $8p = FileExists($8o)
Global Const $8q = @ProgramFilesDir & "\KPS designstudio\KPSInfo\"
Global Const $8r = $8q & "KPSInfo.exe"
Global Const $8s = FileExists($8r)
Global Const $8t = "Powerkatalog-Schnittstelle.exe"
Global Const $8u = @ProgramFilesDir & "\KPS designstudio\Powerkatalog-Schnittstelle\"
Global Const $8v = $8u & $8t
Global Const $8w = FileExists($8v)
Global Const $8x = "SHDUpdater_min.exe"
Global Const $8y = @ProgramFilesDir & "\SHDUpdater\"
Global Const $8z = $8y & $8x
Global Const $90 = FileExists($8z)
Global Const $91 = "NetPhone Client.exe"
Global Const $92 = @ProgramFilesDir & "\NetPhone Client\"
Global Const $93 = $92 & $91
Global Const $94 = FileExists($93)
Global Const $95 = "\\172.16.128.4\edv\Gerrit\"
Global Const $96 = $95 & ""
Global Const $97 = FileExists($96)
Global Const $98 = $95 & "akk\"
Global Const $99 = $98 & ""
Global Const $9a = FileExists($99)
Global Const $9b = @ScriptDir & "\"
Global Const $9c = $9b & "akk.exe"
Global Const $9d = FileExists($9c)
Global Const $9e = $95
Global Const $9f = $9e & "akk.exe"
Global Const $9g = FileExists($9f)
Global Const $9h = "akkUpdater.exe"
Global Const $9i = $9b
Global Const $9j = $9i & $9h
Global $9k = FileExists($9j)
Global Const $9l = $9h
Global Const $9m = $95
Global Const $9n = $9m & $9l
Global Const $9o = FileExists($9n)
Global Const $9p = $9b
Global Const $9q = $9p & "akk.ini"
Global Const $9r = FileExists($9q)
Global Const $9s = "akkGlobalConfig.ini"
Global Const $9t = $9b
Global Const $9u = $9t & $9s
Global $9v = FileExists($9u)
Global Const $9w = $9s
Global Const $9x = $98
Global Const $9y = $9x & $9w
Global Const $9z = FileExists($9y)
Global Const $a0 = "akkGlobalConfigExtended.ini"
Global Const $a1 = $9t
Global Const $a2 = $a1 & $a0
Global $a3 = FileExists($a2)
Global Const $a4 = $a0
Global Const $a5 = $98
Global Const $a6 = $a5 & $a4
Global Const $a7 = FileExists($a6)
Global $a8
Global $a9 = ""
Global Const $aa = $9b & "log\"
Global $ab = $aa & $a9
Global $ac = FileExists($ab)
If Not FileExists($aa) Then DirCreate($aa)
Global $ad = ""
Global Const $ae = $98 & "log\" & @ComputerName & "\"
Global $af = $ae & $ad
Global $ag = FileExists($af)
If Not FileExists($ae) Then DirCreate($ae)
Global $ah = "akkGlobal.log"
Global Const $ai = $98 & "log\"
Global $aj = $ai & $ah
Global $ak = FileExists($aj)
Global $al = ""
Global Const $am = $98 & "log\_archive\"
Global $an = $am & $al
Global $ao = FileExists($an)
If Not FileExists($am) Then DirCreate($am)
Global Const $ap = $98 & "log\"
Global Const $aq = $ap & "akkGlobal.ini"
Global Const $ar = FileExists($aq)
Global Const $as = "akkGlobalSpawnStats.ini"
Global Const $at = $98 & "log\"
Global Const $au = $at & $as
Global Const $av = FileExists($au)
Global Const $aw = $ae
Global Const $ax = $aw & "akkMacro.ini"
Global Const $ay = FileExists($ax)
Global Const $az = $9b & "log\"
Global Const $b0 = $az & "scrape.prom"
Global Const $b1 = FileExists($b0)
Global Const $b2 = $ae
Global Const $b3 = $b2 & "scrape.prom"
Global Const $b4 = FileExists($b3)
Global Const $b5 = $9b & "log\sc\"
Global Const $b6 = $b5 & ""
Global Const $b7 = FileExists($b6)
If Not FileExists($b5) Then DirCreate($b5)
Global Const $b8 = $98 & "log\_sc\NetPhoneUser\"
Global Const $b9 = $b8 & ""
Global Const $ba = FileExists($b9)
If Not FileExists($b8) Then DirCreate($b8)
Global Const $bb = @UserProfileDir & "\Downloads"
Global Const $bc = $bb & " alt"
Global $bd = ""
Global Const $be = @ComputerName
Global $bf
Global $bg[10][2]
Global $bh = 0
Global $bi = 1
Global $bj
Global $bk
Global $bl
Global $bm
Global Const $bn = @HomeDrive & "\Brauckhoff\akk\"
Global Const $bo = $bn & "exf.exe"
Global $bp = FileExists($bo)
Global Const $bq = $98
Global Const $br = $bq & "exf.exe"
Global Const $bs = FileExists($br)
Global Const $bt = "wmi_exporter.exe"
Global Const $bu = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $bv = $bu & $bt
Global $bw = FileExists($bv)
Global Const $bx = "wmi_exporter-0.8.3-386.exe"
Global Const $by = $98 & "wmi_exporter\"
Global Const $bz = $by & $bx
Global Const $c0 = FileExists($bz)
Global Const $c1 = "wmi_exporter-0.8.3-amd64.exe"
Global Const $c2 = $98 & "wmi_exporter\"
Global Const $c3 = $c2 & $c1
Global Const $c4 = FileExists($c3)
Global Const $c5 = "cpu,cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $c6 = $bu & "textfile_inputs\"
Global Const $c7 = $c6
Global Const $c8 = $c7 & "metadata.prom"
Global $c9 = FileExists($c8)
Global Const $ca = $98 & "prometheus\targets\"
Global Const $cb = $ca & ""
Global Const $cc = FileExists($cb)
If Not FileExists($ca) Then DirCreate($ca)
Global $cd
Global Const $ce = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $c5 & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $c6
Global Enum $cf, $cg, $ch, $ci, $cj, $ck, $cl
_10w("akk")
If @Compiled Then Sleep(5e3)
_119()
_117()
_113("akk.exe läuft Spawn, KPSInfo & WMI Exporter werden überwacht")
If Not @Compiled Then _113("$WmiExporterParams: " & $ce)
_115()
_118()
_114()
_11v()
_11u()
_11i()
_11n()
_11a()
_11w()
_11x()
_11d()
If @Compiled Then Sleep(5e3)
While 42
Sleep(10)
If(Mod($88, 300) = 0) Then
If _11c($8a, 15e3 * 1) Then _11f()
If _11c($8b, 60e3 * 5) Then _115()
If _11c($8c, 60e3 * 5) Then _117()
If _11c($8d, 60e3 * 10) Then _11s()
If _11c($8e, 30e3 * 1) Then _11w()
If _zv() > 60e3 * 2 And _11c($8f, 60e3 * 15) Then _11a()
EndIf
If(Mod($88, 500) = 0) Then _11t()
$88 += 1
WEnd
Func _113($cm)
$cm = StringFormat("%10s", $88) & " : " & $cm
ConsoleWrite($cm & @CRLF)
_sn($ab, $cm)
_sn($af, $cm)
_sn($aj, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $cm)
EndFunc
Func _114()
Local $5m = _s8("", "Application")
$bk = _s5($5m)
$bl = _rs($5m)
$bm = _s7($5m)
_rr($5m)
EndFunc
Func _115()
If $9z And Not $9v Then
$9v = FileCopy($9y, $9u, 1 + 8)
EndIf
If $a7 And Not $a3 Then
$a3 = FileCopy($a6, $a2, 1 + 8)
EndIf
If $9o And Not $9k Then
$9k = FileCopy($9n, $9j, 1 + 8)
EndIf
Local $cn = FileGetTime($9u, 0, 1)
Local $co = FileGetTime($9y, 0, 1)
If $cn <> $co Then
$9v = FileCopy($9y, $9u, 1 + 8)
_113("Reload Config " & $9y)
_118()
EndIf
Local $cp = FileGetTime($a2, 0, 1)
Local $cq = FileGetTime($a6, 0, 1)
If $cp <> $cq Then
$a3 = FileCopy($a6, $a2, 1 + 8)
_113("Reload Config Ex" & $a6)
_118()
_11w()
EndIf
Local $cr = FileGetTime($9j, 0, 1)
Local $cs = FileGetTime($9n, 0, 1)
If $cr <> $cs And @Compiled Then
$9k = FileCopy($9n, $9j, 1 + 8)
_113("Reload Akk Updater " & $9n)
EndIf
Local $ct = FileGetTime($9c, 0, 1)
Local $cu = FileGetTime($9f, 0, 1)
If $ct <> $cu And @Compiled Then
_11g($9h, $9i, $9j, $9k)
_113("Reload Akk " & $9f)
EndIf
EndFunc
Func _116()
Local $cv = WinList()
Local $cw[1][8]
$cw[0][1] = "hWnd"
$cw[0][2] = "$WIN_STATE_EXISTS"
$cw[0][3] = "$WIN_STATE_VISIBLE"
$cw[0][4] = "$WIN_STATE_ENABLED"
$cw[0][5] = "$WIN_STATE_ACTIVE"
$cw[0][6] = "$WIN_STATE_MINIMIZED"
$cw[0][7] = "$WIN_STATE_MAXIMIZED"
Local $cx
For $2k = 1 To $cv[0][0]
$cx = WinGetState($cv[$2k][1])
_nb($cw, $cv[$2k][0] & "|" & String($cv[$2k][1]) & "|" & BitAND($cx, 1) & "|" & BitAND($cx, 2) & "|" & BitAND($cx, 4) & "|" & BitAND($cx, 8) & "|" & BitAND($cx, 16) & "|" & BitAND($cx, 32), 0, "|")
Next
$cw[0][0] = UBound($cw) - 1
Local $cy[1][5] = [["", "hWnd", "$WIN_STATE_ACTIVE", "$WIN_STATE_MINIMIZED", "$WIN_STATE_MAXIMIZED"]]
For $2k = 1 To $cw[0][0]
If $cw[$2k][0] <> "" And $cw[$2k][3] = 2 Then
_nb($cy, $cw[$2k][0] & "|" & $cw[$2k][1] & "|" & $cw[$2k][5] & "|" & $cw[$2k][6] & "|" & $cw[$2k][7], 0, "|")
EndIf
Next
$cy[0][0] = UBound($cy) - 1
Return $cy
EndFunc
Func _117()
$a9 = StringFormat("%04s", $a8) & ".log"
$ab = $aa & $a9
$af = $ae & $a9
If _sd($ab) > 1e3 Then
$a8 += 1
IniWrite($9q, "LogFile", "ID", $a8)
EndIf
IniWrite($9q, "LogFile", "LogPath", $ab)
IniWrite($9q, "LogFile", "LogNetPath", $af)
If FileGetSize($aj) / 1024 > 100 Then
Local $cz = $am & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($aj, $cz, 1 + 8)
EndIf
EndFunc
Func _118()
If FileExists($9u) Then
$bf = IniRead($9u, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $2k = 0 To 9 Step 1
$bg[$2k][0] = IniRead($9u, "FreeSpaceCheck", "Mail" & $2k & "Address", "")
$bg[$2k][1] = IniRead($9u, "FreeSpaceCheck", "Mail" & $2k & "Active", 0)
Next
$bd = IniRead($9u, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($a2) Then
$cd = IniRead($a2, "MetaData", @ComputerName, "NULL")
If $cd = "NULL" Then
IniWrite($a6, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _119()
$a8 = IniRead($9q, "LogFile", "ID", "NULL")
If $a8 = "NULL" Then
IniWrite($9q, "LogFile", "ID", 0)
$a8 = 0
EndIf
EndFunc
Func _11a()
Local $d0 = _11b()
Local $d = WinGetHandle("NetPhone Client")
If @error Then
If ProcessExists($91) Then _113("Error ScreenCaptureNetPhoneClient")
Else
Local $cx = WinGetState($d)
If False Then
WinActivate($d)
Sleep(250)
EndIf
Local $d1 = WinGetPos($d)
$d1[0] = $d1[0] + 57
$d1[1] = $d1[1] + $d1[3] - 54
$d1[2] = $d1[0] + 174
$d1[3] = $d1[1] + 15
_11e("", "NetPhoneUser", "$NetPhoneClientPos", 0, _o2($d1))
$8i = PixelChecksum($d1[0], $d1[1], $d1[2], $d1[3], 1, Default, 1)
If Not FileExists($b8 & $8i & ".png") And Not FileExists($b8 & "del\" & $8i & ".png") And Not FileExists($b8 & "ini\" & $8i & ".png") Then
_n4($b8 & $8i & ".png", $d1[0], $d1[1], $d1[2], $d1[3], 0)
EndIf
If BitAND($cx, 16) Then WinSetState($d, Default, @SW_MINIMIZE)
EndIf
If False Then WinActivate($d0)
$8j = IniRead($a2, "$NetPhoneUser", $8i, "NULL")
_11e("", "NetPhoneUser", "$NetPhoneUser", 0, $8j)
_11e("", "NetPhoneUser", "$NetPhoneUserChecksum", 0, $8i)
EndFunc
Func _11b()
Local $d2 = _116()
Local $d
Local $d0
For $2k = 1 To $d2[0][0]
If $d2[$2k][0] <> "" Then
If $d2[$2k][2] = 8 Then
$8k = $d2[$2k][0]
$d0 = $d2[$2k][1]
EndIf
If False & StringStripWS($d2[$2k][0], 1 + 2) = "NetPhone Client" Then
$d = HWnd($d2[$2k][1])
If WinActivate($d) Then
_n5($b5 & $2k & ".png", $d)
EndIf
If $d2[$2k][3] = 16 Then
WinSetState($d, Default, @SW_MINIMIZE)
EndIf
If $d2[$2k][4] = 32 Then
WinSetState($d, Default, @SW_MAXIMIZE)
EndIf
If @error Then _113("Error ScreenCaptureWnd")
EndIf
EndIf
Next
$d = HWnd($d0)
$8l = WinGetProcess($d)
WinActivate($d)
Return $d
EndFunc
Func _11c(ByRef $d3, $d4)
Local $d5 = TimerDiff($d3)
If $d5 > $d4 Then
$d3 = TimerInit()
Return $d5
EndIf
Return 0
EndFunc
Func _11d()
IniWrite($ap & "Global" & ".ini", "@ComputerName", StringReplace(StringFormat("%-16s", @IPAddress1), " ", "."), @ComputerName)
_11e("", "Global", "@IPAddress1", 0, @IPAddress1)
_11e("", "Global", "$AkkVersion", 0, $8h)
_11e("", "Global", "$SpawnExists", 0, $8p)
_11e("", "Global", "$KPSInfoExists", 0, $8s)
_11e("", "Global", "$PowerkatalogExists", 0, $8w)
_11e("", "Global", "$SHDUpdaterExists", 0, $90)
_11e("", "Global", "$NetPhoneClientExists", 0, $94)
_11e("", "Global", "$ActiveWinTitle", 0, $8k)
_11e("", "Global", "$hWndActivePid", 0, $8l)
_11e("", "EventLog", "$EventLogFull", 0, $bk)
_11e("", "EventLog", "$EventLogCount", 0, $bl)
_11e("", "EventLog", "$EventLogOldest", 0, $bm)
_11e("", "SpawnStats", $8m & "TimeModified", 0, FileGetTime($8o, 0, 1))
Local $d6 = IsAdmin()
_11e("", "Misc", "$iIsAdmin", 0, $d6)
Local $d7 = _11y()
_11e("", "Wmi", "$ComputerSystemProductName", 0, $d7[0])
_11e("", "Wmi", "$ComputerSystemProductIdentifyingNumber", 0, $d7[1])
_11e("", "AutoIt", "@Compiled", 0, @Compiled)
_11e("", "AutoIt", "@ScriptName", 0, @ScriptName)
_11e("", "AutoIt", "@ScriptDir", 0, @ScriptDir)
_11e("", "AutoIt", "@ScriptFullPath", 0, @ScriptFullPath)
_11e("", "AutoIt", "@WorkingDir", 0, @WorkingDir)
_11e("", "AutoIt", "@AutoItExe", 0, @AutoItExe)
_11e("", "AutoIt", "@AutoItPID", 0, @AutoItPID)
_11e("", "AutoIt", "@AutoItVersion", 0, @AutoItVersion)
_11e("", "AutoIt", "@AutoItX64", 0, @AutoItX64)
_11e("", "Directory", "@AppDataCommonDir", 0, @AppDataCommonDir)
_11e("", "Directory", "@DesktopCommonDir", 0, @DesktopCommonDir)
_11e("", "Directory", "@DocumentsCommonDir", 0, @DocumentsCommonDir)
_11e("", "Directory", "@FavoritesCommonDir", 0, @FavoritesCommonDir)
_11e("", "Directory", "@ProgramsCommonDir", 0, @ProgramsCommonDir)
_11e("", "Directory", "@StartMenuCommonDir", 0, @StartMenuCommonDir)
_11e("", "Directory", "@StartupCommonDir", 0, @StartupCommonDir)
_11e("", "Directory", "@AppDataDir", 0, @AppDataDir)
_11e("", "Directory", "@LocalAppDataDir", 0, @LocalAppDataDir)
_11e("", "Directory", "@DesktopDir", 0, @DesktopDir)
_11e("", "Directory", "@MyDocumentsDir", 0, @MyDocumentsDir)
_11e("", "Directory", "@FavoritesDir", 0, @FavoritesDir)
_11e("", "Directory", "@ProgramsDir", 0, @ProgramsDir)
_11e("", "Directory", "@StartMenuDir", 0, @StartMenuDir)
_11e("", "Directory", "@UserProfileDir", 0, @UserProfileDir)
_11e("", "Directory", "@HomeDrive", 0, @HomeDrive)
_11e("", "Directory", "@HomePath", 0, @HomePath)
_11e("", "Directory", "@HomeShare", 0, @HomeShare)
_11e("", "Directory", "@LogonDNSDomain", 0, @LogonDNSDomain)
_11e("", "Directory", "@LogonDomain", 0, @LogonDomain)
_11e("", "Directory", "@LogonServer", 0, @LogonServer)
_11e("", "Directory", "@ProgramFilesDir", 0, @ProgramFilesDir)
_11e("", "Directory", "@CommonFilesDir", 0, @CommonFilesDir)
_11e("", "Directory", "@WindowsDir", 0, @WindowsDir)
_11e("", "Directory", "@SystemDir", 0, @SystemDir)
_11e("", "Directory", "@TempDir", 0, @TempDir)
_11e("", "Directory", "@ComSpec", 0, @ComSpec)
_11e("", "SystemInfo", "@CPUArch", 0, @CPUArch)
_11e("", "SystemInfo", "@KBLayout", 0, @KBLayout)
_11e("", "SystemInfo", "@MUILang", 0, @MUILang)
_11e("", "SystemInfo", "@OSArch", 0, @OSArch)
_11e("", "SystemInfo", "@OSLang", 0, @OSLang)
_11e("", "SystemInfo", "@OSType", 0, @OSType)
_11e("", "SystemInfo", "@OSVersion", 0, @OSVersion)
_11e("", "SystemInfo", "@OSBuild", 0, @OSBuild)
_11e("", "SystemInfo", "@OSServicePack", 0, @OSServicePack)
_11e("", "SystemInfo", "@ComputerName", 0, @ComputerName)
_11e("", "SystemInfo", "@UserName", 0, @UserName)
_11e("", "SystemInfo", "@IPAddress1", 0, @IPAddress1)
_11e("", "SystemInfo", "@IPAddress2", 0, @IPAddress2)
_11e("", "SystemInfo", "@IPAddress3", 0, @IPAddress3)
_11e("", "SystemInfo", "@IPAddress4", 0, @IPAddress4)
_11e("", "SystemInfo", "@DesktopHeight", 0, @DesktopHeight)
_11e("", "SystemInfo", "@DesktopWidth", 0, @DesktopWidth)
_11e("", "SystemInfo", "@DesktopDepth", 0, @DesktopDepth)
_11e("", "SystemInfo", "@DesktopRefresh", 0, @DesktopRefresh)
EndFunc
Func _11e($d8, $d9, $da, $db, $dc)
If $d8 = "" Then
$d8 = $ap & $d9 & ".ini"
EndIf
IniWrite($d8,($db ? $d9 & $da : $da), $8g, $dc)
IniWrite($ax, $d9, $da, $dc)
EndFunc
Func _11f()
_11g($8m, $8n, $8o, $8p)
_11g("KPSInfo.exe", $8q, $8r, $8s)
$bj = _11g($bt, $bu, $bv & $ce, $bw)
EndFunc
Func _11g($dd, $de, $df, $dg, $dh = @SW_HIDE)
If $dg And Not ProcessExists($dd) Then
_113($dd & " wird gestartet")
Return Run($df, $de, $dh)
EndIf
Return 0
EndFunc
Func _11i()
If _11j() And @Compiled Then
DirRemove($bc, 1)
_11k($bb, $bc)
FileDelete($bc & "\Downloads alt.lnk")
FileCreateShortcut($bc, $bb & "\Downloads alt")
IniWrite($9q, "Downloads", "LastCleaningDate", _q7(@YEAR, @MON, @MDAY))
Local Const $di = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $di, $87) = 6 Then
ShellExecute($bc)
EndIf
EndIf
EndFunc
Func _11j()
Return(_q7(@YEAR, @MON, @MDAY) - _11l()) >= 14
EndFunc
Func _11k($dj, $dk)
If FileExists($dj) Then
If Not FileExists($dk) Then DirCreate($dk)
FileMove($dj & "\*.*", $dk, 1 + 8)
Local Const $dl = _sf($dj, Default, 2, True)
If Not @error Then
For $dm In $dl
DirMove($dm, $dk, 1)
Next
EndIf
EndIf
EndFunc
Func _11l()
Return IniRead($9q, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _11n()
Local Const $dn = DriveGetLabel(@HomeDrive & "\")
Local Const $do = DriveSpaceFree(@HomeDrive & "\")
Local Const $dp = DriveSpaceTotal(@HomeDrive & "\")
Local Const $dq =($do / $dp) * 100
If $dq < $bf Then
If(_q7(@YEAR, @MON, @MDAY) - IniRead($9q, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($9q, "FreeSpaceCheck", "LastMailSendDate", _q7(@YEAR, @MON, @MDAY))
For $2k = 0 To 9 Step 1
If $bg[$2k][0] <> "" And $bg[$2k][1] = 1 Then
_113("Sending Mail to " & $bg[$2k][0])
_11o($bg[$2k][0], Round($dq, 2), $dn, $do, $dp)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _11o($7d, $dq, $dn, $do, $dp)
Local $7b = "akk.exe (Gerrit)"
Local $7c = "akk@kuechen-brauckhoff.de"
Local $7e = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $dq & "% !"
Local $dr[0]
_nb($dr, "Akk Warnung wenig Speicherplatz auf:")
_nb($dr, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _nb($dr, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _nb($dr, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _nb($dr, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _nb($dr, @IPAddress4)
_nb($dr, $dn & " (" & @HomeDrive & ")")
_nb($dr, Round($do / 1024, 2) & " GB frei von " & Round($dp / 1024, 2) & " GB")
_nb($dr, $dq & "% frei")
Local $ds = _10n($bd, $7b, $7c, $7d, $7e, $dr, $be, -1, 0)
Local $dt = @error
If $ds = 0 Then
Local Const $di = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _o2($dr, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $dt & @CRLF
MsgBox(48 + 4096, "Warnung!", $di)
EndIf
EndFunc
Func _11p($du)
Return Round($du / 1024 / 1024, 2)
EndFunc
Func _11q(ByRef $dv, $dw, $dx, $dy = 0, $dz = "")
Local Static $e0 = 0
$e0 += 1
Local Const $e1 = "Metric read from C:\\Brauckhoff\\wmi_exporter\\textfile_inputs\\metadata.prom"
Local $e2[]
Local $e3[]
$e2.Name = $dw & "+" & $e0
$e2.Type = $dx
$e2.Value = $dy
$e2.Text =($dz = "" ? $e1 : $dz)
$e2.Labels = $e3
$dv[$e2.Name] = $e2
Return $e2.Name
EndFunc
Func _11r($e4)
Local $e2[]
Local $e5 = ProcessList($e4)
Local $6h = "", $6i = "", $2b = "", $6j = ""
_ss($e4, $6h, $6i, $2b, $6j)
$e2.Count = $e5[0][0]
$e2.FileName = $2b
Return $e2
EndFunc
Func _11s()
If $bi And ProcessExists($bt) Then
$bh = InetGet("http://localhost:9182/metrics", $b0, 1, 1)
$bi = 0
EndIf
EndFunc
Func _11t()
If Not $bi Then
If InetGetInfo($bh, 2) Then
If InetGetInfo($bh, 3) Then
If FileGetSize($b0) Then FileCopy($b0, $b3, 1 + 8)
Else
FileDelete($b0)
_113("Error ScrapeDownload")
EndIf
InetClose($bh)
$bh = 0
$bi = 1
EndIf
EndIf
EndFunc
Func _11u()
If Not $bp Then
If FileCopy($br, $bo, 1 + 8) Then
$bp = FileExists($bo)
EndIf
EndIf
EndFunc
Func _11v()
ProcessClose($bt)
Local $e6 =(@OSArch = "X64") ? $c3 : $bz
Local $e7 = FileGetTime($bv, 0, 1)
Local $e8 = FileGetTime($e6, 0, 1)
If Not $bw Or $e7 <> $e8 Then
_113("Reload WmiExporter " & $e6)
If FileCopy($e6, $bv, 1 + 8) Then
$bw = FileExists($bv)
Else
_113("ERROR Reload WmiExporter " & $e6)
EndIf
EndIf
If Not FileExists($c6) Then DirCreate($c6)
EndFunc
Func _11w()
_114()
Local $e9[]
Local $dw = _11q($e9, "akk_metadata", "gauge", _zv() / 1e3)
$e9[$dw].Labels.username = @UserName
$e9[$dw].Labels.ip_address = @IPAddress1
$e9[$dw].Labels.netphone_user =($8k = "LockScreen" ? "LockScreen" : $8j)
If $cd <> "NULL" And StringLen($cd) And Not StringIsSpace($cd) Then
$e9[$dw].LabelsRaw = $cd
EndIf
Local $ea = MemGetStats()
_11q($e9, "akk_idletime_sec", "gauge", _zv() / 1e3, "Returns the number of seconds since last user activity (i.e. KYBD/Mouse)")
_11q($e9, "akk_memstats_load", "gauge", $ea[$cf], "Memory Load (Percentage of memory in use)")
_11q($e9, "akk_memstats_total_physram_gb", "gauge", _11p($ea[$cg]), "Total physical RAM")
_11q($e9, "akk_memstats_avail_physram_gb", "gauge", _11p($ea[$ch]), "Available physical RAM")
_11q($e9, "akk_memstats_total_pagefile_gb", "gauge", _11p($ea[$ci]), "Total Pagefile")
_11q($e9, "akk_memstats_avail_pagefile_gb", "gauge", _11p($ea[$cj]), "Available Pagefile")
_11q($e9, "akk_memstats_total_virtual_gb", "gauge", _11p($ea[$ck]), "Total virtual")
_11q($e9, "akk_memstats_avail_virtual_gb", "gauge", _11p($ea[$cl]), "Available virtual")
_11q($e9, "akk_eventlog_full", "gauge",($bk ? 1 : 0), "Retrieves whether the event log is full")
_11q($e9, "akk_eventlog_count", "gauge", $bl, "Retrieves the number of records in the event log")
_11q($e9, "akk_eventlog_oldest", "gauge", $bm, "Retrieves the absolute record number of the oldest record in the event log")
Local $eb = _11r("chrome.exe")
$dw = _11q($e9, "akk_process_count", "gauge", $eb.Count)
$e9[$dw].Labels.process = $eb.FileName
Local $ec = _11r("javaw.exe")
$dw = _11q($e9, "akk_process_count", "gauge", $ec.Count)
$e9[$dw].Labels.process = $ec.FileName
Local $ed = _11r("FusionFX.exe")
$dw = _11q($e9, "akk_process_count", "gauge", $ed.Count)
$e9[$dw].Labels.process = $ed.FileName
Local $ee[1]
Local $ef = "", $eg = ""
Local $eh
For $dv In $e9
$dw = StringSplit($dv.Name, "+")[1]
If $ef <> $dw Then
_nb($ee, "# HELP " & $dw & " " & $dv.Text)
_nb($ee, "# TYPE " & $dw & " " & $dv.Type)
EndIf
$eh = MapKeys($dv.Labels)
$eg = ""
If UBound($eh) Then
$eg &= "{"
For $ei In $eh
$eg &= $ei & '="' & $dv.Labels[$ei] & '",'
Next
If MapExists($dv, "LabelsRaw") Then
$eg &= $dv.LabelsRaw
EndIf
If StringRight($eg, 1) = "," Then $eg = StringTrimRight($eg, 1)
$eg &= "}"
EndIf
_nb($ee, $dw & $eg & " " & $dv.Value)
$ef = $dw
Next
$ee[0] = UBound($ee) - 1
Local $ej
_sl($c8, $ej)
If Not _oh($ee, $ej, 3) Then
_sm($c8, $ee, 1)
EndIf
EndFunc
Func _11x()
Local $ek[1]
_nb($ek, '[')
_nb($ek, '  {')
_nb($ek, '    "labels": {')
_nb($ek, '      "job": "node",')
_nb($ek, '      "instance": "@ComputerName@"')
_nb($ek, '    },')
_nb($ek, '    "targets": [')
_nb($ek, '      "@IPAddress1@:9182"')
_nb($ek, '    ]')
_nb($ek, '  }')
_nb($ek, ']')
Local $el
$ek[0] = UBound($ek) - 1
Local $em = $ca & "@ComputerName@.json"
_sl($em, $el)
If Not _oh($ek, $el, 3) Then
_sm($em, $ek, 1)
EndIf
EndFunc
Func _11y()
Local $en[2] = ["(Unknown)", "(Unknown)"], $eo, $ep
$ep = ObjGet("winmgmts:\\.\root\cimv2")
$eo = $ep.ExecQuery("Select * From Win32_ComputerSystemProduct", "WQL", 0x30)
If IsObj($eo) Then
For $eq In $eo
$en[0] = StringStripWS($eq.Name, 1 + 2)
$en[1] = StringStripWS($eq.IdentifyingNumber, 1 + 2)
Next
Return $en
EndIf
Return SetError(1, 0, $en)
EndFunc
