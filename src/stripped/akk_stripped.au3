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
Func _qs()
Local $19 = DllCall('kernel32.dll', 'dword', 'GetTickCount')
If @error Then Return SetError(@error, @extended, 0)
Return $19[0]
EndFunc
Func _qt()
Local $19 = DllCall('kernel32.dll', 'uint64', 'GetTickCount64')
If @error Then Return SetError(@error, @extended, 0)
Return $19[0]
EndFunc
Global Const $4p = 0x007F
Func _td($4q = 0, $4r = 0, $4s = 0, $4t = '')
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
Func _u1($4v, $1z = Default)
Local Const $4w = 128
If $1z = Default Then $1z = 0
$4v = Int($4v)
If $4v < 1 Or $4v > 7 Then Return SetError(1, 0, "")
Local $4r = DllStructCreate($5)
DllStructSetData($4r, "Year", BitAND($1z, $4w) ? 2007 : 2006)
DllStructSetData($4r, "Month", 1)
DllStructSetData($4r, "Day", $4v)
Return _td(BitAND($1z, 2) ? 0x0400 : $4p, $4r, 0, BitAND($1z, 1) ? "ddd" : "dddd")
EndFunc
Func _u4($4x)
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
Func _u5($4y)
$4y = Int($4y)
Return $4y >= 1 And $4y <= 12
EndFunc
Func _u6($4z)
Local $50[4], $51[4]
_uf($4z, $50, $51)
If Not StringIsInt($50[1]) Then Return 0
If Not StringIsInt($50[2]) Then Return 0
If Not StringIsInt($50[3]) Then Return 0
$50[1] = Int($50[1])
$50[2] = Int($50[2])
$50[3] = Int($50[3])
Local $52 = _uy($50[1])
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
Func _uf($4z, ByRef $53, ByRef $54)
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
Func _ui($4x, $57, $58)
If Not _u6(StringFormat("%04d/%02d/%02d", $4x, $57, $58)) Then
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
Func _uj($5f, $1z = Default)
If $1z = Default Then $1z = 0
$5f = Int($5f)
If Not _u5($5f) Then Return SetError(1, 0, "")
Local $4r = DllStructCreate($5)
DllStructSetData($4r, "Year", @YEAR)
DllStructSetData($4r, "Month", $5f)
DllStructSetData($4r, "Day", 1)
Return _td(BitAND($1z, 2) ? 0x0400 : $4p, $4r, 0, BitAND($1z, 1) ? "MMM" : "MMMM")
EndFunc
Func _uy($4x)
Local $5g = [12, 31,(_u4($4x) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
Return $5g
EndFunc
Func _uz($5h)
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
Func _vm()
Local $5k = DllStructCreate($6)
Local $l = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "struct*", $5k)
If @error Or $l[0] = -1 Then Return SetError(@error, @extended, 0)
Local $26[8]
$26[0] = $l[0]
$26[1] = DllStructGetData($5k, "Bias")
$26[2] = _67(DllStructGetPtr($5k, "StdName"))
$26[3] = _uz(DllStructGetPtr($5k, "StdDate"))
$26[4] = DllStructGetData($5k, "StdBias")
$26[5] = _67(DllStructGetPtr($5k, "DayName"))
$26[6] = _uz(DllStructGetPtr($5k, "DayDate"))
$26[7] = DllStructGetData($5k, "DayBias")
Return $26
EndFunc
Global $5l
Func _w2($5m)
Local $l = DllCall("advapi32.dll", "bool", "CloseEventLog", "handle", $5m)
If @error Then Return SetError(@error, @extended, False)
Return $l[0] <> 0
EndFunc
Func _w3($5m)
Local $l = DllCall("advapi32.dll", "bool", "GetNumberOfEventLogRecords", "handle", $5m, "dword*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $l[0] = 0 Then Return -1
Return $l[2]
EndFunc
Func _wg($5m)
Local $l = DllCall("advapi32.dll", "bool", "GetEventLogInformation", "handle", $5m, "dword", 0, "dword*", 0, "dword", 4, "dword*", 0)
If @error Then Return SetError(@error, @extended, False)
Return $l[3] <> 0
EndFunc
Func _wi($5m)
Local $l = DllCall("advapi32.dll", "bool", "GetOldestEventLogRecord", "handle", $5m, "dword*", 0)
If @error Then Return SetError(@error, @extended, 0)
Return $l[2]
EndFunc
Func _wj($5n, $5o)
$5l = $5o
Local $l = DllCall("advapi32.dll", "handle", "OpenEventLogW", "wstr", $5n, "wstr", $5o)
If @error Then Return SetError(@error, @extended, 0)
Return $l[0]
EndFunc
Func _wo($5p)
Local $5q = FileOpen($5p, 0)
If $5q = -1 Then Return SetError(1, 0, 0)
Local $5r = StringStripWS(FileRead($5q), 2)
FileClose($5q)
Return UBound(StringRegExp($5r, "\R", 3)) + 1 - Int($5r = "")
EndFunc
Func _wq($5p, $5s = "*", $5t = 0, $5u = False)
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
Func _ww($5p, ByRef $5y, $4s = 1, $2t = "")
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
Func _wx($5p, Const ByRef $3p, $66 = Default, $67 = Default, $2t = "|")
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
Func _wy($6b, $6c, $5t = -1)
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
Func _x3($5p, ByRef $6h, ByRef $6i, ByRef $2b, ByRef $6j)
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
Func _146()
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
Func _14q()
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
If $6r Then _14q()
Local Const $6k = 0x000E
Local Const $75 = 0xB1
Local Const $76 = 0xC2
Local $77 = _m($6s, $6k, 0, 0, 0, "int", "int")
_m($6s, $75, $77, $77, 0, "int", "int")
_m($6s, $76, True, $78, 0, "int", "wstr")
EndFunc
Func _14s()
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
If $6s = 0 Then _14s()
ControlCommand($6s, "", "Edit1", "EditPaste", String($78))
EndFunc
Func _14y($7a, $7b, $7c, $7d, $7e = "", $7f = "", $7g = "", $7h = "", $7i = 0)
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
Local $l = _vm()
Local $7o = -$l[1] / 60
Local $7p = Int($7o)
Local $7q = 0
If $7p <> $7o Then $7q = Abs($7o - $7p) * 60
$7o = StringFormat(" (%+.2d%.2d)", $7p, $7q)
$7m[4] = "From:" & $7b & "<" & $7c & ">" & @CRLF & "To:" & "<" & $7d & ">" & @CRLF & "Subject:" & $7e & @CRLF & "Mime-Version: 1.0" & @CRLF & "Date: " & _u1(@WDAY, 1) & ", " & @MDAY & " " & _uj(@MON, 1) & " " & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & $7o & @CRLF & "Content-Type: text/plain; charset=US-ASCII" & @CRLF & @CRLF
$7n[4] = ""
$7m[5] = @CRLF & "." & @CRLF
$7n[5] = "250"
If _150($7l, $7m[0], $7n[0], $7i, "220", $7h) Then Return SetError(50, 0, 0)
For $7k = 1 To UBound($7m) - 2
If _150($7l, $7m[$7k], $7n[$7k], $7i) Then Return SetError(50 + $7k, 0, 0)
Next
For $7k = 0 To UBound($7f) - 1
If StringLeft($7f[$7k], 1) = "." Then $7f[$7k] = "." & $7f[$7k]
If _150($7l, $7f[$7k] & @CRLF, "", $7i) Then Return SetError(500 + $7k, 0, 0)
Next
$7k = UBound($7m) - 1
If _150($7l, $7m[$7k], $7n[$7k], $7i) Then Return SetError(5000, 0, 0)
TCPCloseSocket($7l)
TCPShutdown()
Return 1
EndFunc
Func _14z($7r, $7s = 0)
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
Func _150($7l, $7v, $7w, $7i, $7x = "", $7h = "")
Local $7y, $2k, $7z
If $7i Then _14z($7v)
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
If $7i And $7y <> "" Then _14z("intermediate->" & $7y)
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
If $7i Then _14z($2k & " <- " & $7y)
If StringLeft($7y, StringLen($7w)) <> $7w Then
TCPCloseSocket($7l)
TCPShutdown()
If $7i Then _14z("<-> " & $7w, 5)
Return 2
EndIf
EndIf
Return 0
EndFunc
Func _157($80, $5t = 0)
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
Global Const $95 = "ppRemoteEcoroTray.exe"
Global Const $96 = @ProgramFilesDir & "\SHD Ecoro-KPS-Butler\"
Global Const $97 = $96 & $95
Global Const $98 = FileExists($97)
Global Const $99 = "\\172.16.128.4\edv\Gerrit\"
Global Const $9a = $99 & ""
Global Const $9b = FileExists($9a)
Global Const $9c = $99 & "akk\"
Global Const $9d = $9c & ""
Global Const $9e = FileExists($9d)
Global Const $9f = @ScriptDir & "\"
Global Const $9g = $9f & "akk.exe"
Global Const $9h = FileExists($9g)
Global Const $9i = $99
Global Const $9j = $9i & "akk.exe"
Global Const $9k = FileExists($9j)
Global Const $9l = "akkUpdater.exe"
Global Const $9m = $9f
Global Const $9n = $9m & $9l
Global $9o = FileExists($9n)
Global Const $9p = $9l
Global Const $9q = $99
Global Const $9r = $9q & $9p
Global Const $9s = FileExists($9r)
Global Const $9t = $9f
Global Const $9u = $9t & "akk.ini"
Global Const $9v = FileExists($9u)
Global Const $9w = "akkGlobalConfig.ini"
Global Const $9x = $9f
Global Const $9y = $9x & $9w
Global $9z = FileExists($9y)
Global Const $a0 = $9w
Global Const $a1 = $9c
Global Const $a2 = $a1 & $a0
Global Const $a3 = FileExists($a2)
Global Const $a4 = "akkGlobalConfigExtended.ini"
Global Const $a5 = $9x
Global Const $a6 = $a5 & $a4
Global $a7 = FileExists($a6)
Global Const $a8 = $a4
Global Const $a9 = $9c
Global Const $aa = $a9 & $a8
Global Const $ab = FileExists($aa)
Global $ac
Global $ad = ""
Global Const $ae = $9f & "log\"
Global $af = $ae & $ad
Global $ag = FileExists($af)
If Not FileExists($ae) Then DirCreate($ae)
Global $ah = ""
Global Const $ai = $9c & "log\" & @ComputerName & "\"
Global $aj = $ai & $ah
Global $ak = FileExists($aj)
If Not FileExists($ai) Then DirCreate($ai)
Global $al = "akkGlobal.log"
Global Const $am = $9c & "log\"
Global $an = $am & $al
Global $ao = FileExists($an)
Global $ap = ""
Global Const $aq = $9c & "log\_archive\"
Global $ar = $aq & $ap
Global $as = FileExists($ar)
If Not FileExists($aq) Then DirCreate($aq)
Global Const $at = $9c & "log\"
Global Const $au = $at & "akkGlobal.ini"
Global Const $av = FileExists($au)
Global Const $aw = "akkGlobalSpawnStats.ini"
Global Const $ax = $9c & "log\"
Global Const $ay = $ax & $aw
Global Const $az = FileExists($ay)
Global Const $b0 = $ai
Global Const $b1 = $b0 & "akkMacro.ini"
Global Const $b2 = FileExists($b1)
Global Const $b3 = $9f & "log\"
Global Const $b4 = $b3 & "scrape.prom"
Global Const $b5 = FileExists($b4)
Global Const $b6 = $ai
Global Const $b7 = $b6 & "scrape.prom"
Global Const $b8 = FileExists($b7)
Global Const $b9 = $9f & "log\sc\"
Global Const $ba = $b9 & ""
Global Const $bb = FileExists($ba)
If Not FileExists($b9) Then DirCreate($b9)
Global Const $bc = $9c & "log\_sc\NetPhoneUser\"
Global Const $bd = $bc & ""
Global Const $be = FileExists($bd)
If Not FileExists($bc) Then DirCreate($bc)
Global Const $bf = @UserProfileDir & "\Downloads"
Global Const $bg = $bf & " alt"
Global $bh = ""
Global Const $bi = @ComputerName
Global $bj
Global $bk[10][2]
Global $bl = 0
Global $bm = 1
Global $bn
Global $bo
Global $bp
Global Const $bq = @HomeDrive & "\Brauckhoff\akk\"
Global Const $br = $bq & "exf.exe"
Global $bs = FileExists($br)
Global Const $bt = $9c
Global Const $bu = $bt & "exf.exe"
Global Const $bv = FileExists($bu)
Global Const $bw = "wmi_exporter.exe"
Global Const $bx = @HomeDrive & "\Brauckhoff\wmi_exporter\"
Global Const $by = $bx & $bw
Global $bz = FileExists($by)
Global Const $c0 = "wmi_exporter-0.8.3-386.exe"
Global Const $c1 = $9c & "wmi_exporter\"
Global Const $c2 = $c1 & $c0
Global Const $c3 = FileExists($c2)
Global Const $c4 = "wmi_exporter-0.8.3-amd64.exe"
Global Const $c5 = $9c & "wmi_exporter\"
Global Const $c6 = $c5 & $c4
Global Const $c7 = FileExists($c6)
Global Const $c8 = "cpu,cs,logical_disk,memory,net,os,process,service,system,textfile"
Global Const $c9 = $bx & "textfile_inputs\"
Global Const $ca = $c9
Global Const $cb = $ca & "metadata.prom"
Global $cc = FileExists($cb)
Global Const $cd = $9c & "prometheus\targets\"
Global Const $ce = $cd & ""
Global Const $cf = FileExists($ce)
If Not FileExists($cd) Then DirCreate($cd)
Global $cg
Global Const $ch = '' & ' --log.format logger:eventlog?name=wmi_exporter' & ' --collectors.enabled ' & $c8 & ' --telemetry.addr :9182 ' & ' --collector.textfile.directory ' & $c9
Global Enum $ci, $cj, $ck, $cl, $cm, $cn, $co
_157("akk")
If @Compiled Then Sleep(5e3)
_15k()
_15i()
_15e("akk.exe läuft Spawn, KPSInfo, KPS Butler & WMI Exporter werden überwacht")
If Not @Compiled Then _15e("$WmiExporterParams: " & $ch)
_15g()
_15j()
_15f()
_166()
_165()
_15t()
_15y()
_15l()
_167()
_168()
_15o()
If @Compiled Then Sleep(5e3)
While 42
Sleep(10)
If(Mod($88, 300) == 0) Then
If _15n($8a, 15e3 * 1) Then _15q()
If _15n($8b, 60e3 * 5) Then _15g()
If _15n($8c, 60e3 * 5) Then _15i()
If _15n($8d, 60e3 * 15) Then _163()
If _15n($8e, 30e3 * 1) Then _167()
If _15n($8f, 60e3 * 15) And _146() > 60e3 * 2 Then _15l()
EndIf
If(Mod($88, 500) == 0) Then _164()
$88 += 1
WEnd
Func _15e($cp)
$cp = StringFormat("%10s", $88) & " : " & $cp
ConsoleWrite($cp & @CRLF)
_wy($af, $cp)
_wy($aj, $cp)
_wy($an, StringFormat("%-16s", @ComputerName) & " " & StringFormat("%-16s", @UserName) & " " & $cp)
EndFunc
Func _15f()
Local $5m = _wj("", "Application")
$bn = _wg($5m)
$bo = _w3($5m)
$bp = _wi($5m)
_w2($5m)
EndFunc
Func _15g()
If $a3 And Not $9z Then
$9z = FileCopy($a2, $9y, 1 + 8)
EndIf
If $ab And Not $a7 Then
$a7 = FileCopy($aa, $a6, 1 + 8)
EndIf
If $9s And Not $9o Then
$9o = FileCopy($9r, $9n, 1 + 8)
EndIf
Local $cq = FileGetTime($9y, 0, 1)
Local $cr = FileGetTime($a2, 0, 1)
If $cq <> $cr Then
$9z = FileCopy($a2, $9y, 1 + 8)
_15e("Reload Config " & $a2)
_15j()
EndIf
Local $cs = FileGetTime($a6, 0, 1)
Local $ct = FileGetTime($aa, 0, 1)
If $cs <> $ct Then
$a7 = FileCopy($aa, $a6, 1 + 8)
_15e("Reload Config Ex" & $aa)
_15j()
_167()
EndIf
Local $cu = FileGetTime($9n, 0, 1)
Local $cv = FileGetTime($9r, 0, 1)
If $cu <> $cv And @Compiled Then
$9o = FileCopy($9r, $9n, 1 + 8)
_15e("Reload Akk Updater " & $9r)
EndIf
Local $cw = FileGetTime($9g, 0, 1)
Local $cx = FileGetTime($9j, 0, 1)
If $cw <> $cx And @Compiled Then
_15r($9l, $9m, $9n, $9o)
_15e("Reload Akk " & $9j)
EndIf
EndFunc
Func _15h()
Local $cy = WinList()
Local $cz[1][8]
$cz[0][1] = "hWnd"
$cz[0][2] = "$WIN_STATE_EXISTS"
$cz[0][3] = "$WIN_STATE_VISIBLE"
$cz[0][4] = "$WIN_STATE_ENABLED"
$cz[0][5] = "$WIN_STATE_ACTIVE"
$cz[0][6] = "$WIN_STATE_MINIMIZED"
$cz[0][7] = "$WIN_STATE_MAXIMIZED"
Local $d0
For $2k = 1 To $cy[0][0]
$d0 = WinGetState($cy[$2k][1])
_nb($cz, $cy[$2k][0] & "|" & String($cy[$2k][1]) & "|" & BitAND($d0, 1) & "|" & BitAND($d0, 2) & "|" & BitAND($d0, 4) & "|" & BitAND($d0, 8) & "|" & BitAND($d0, 16) & "|" & BitAND($d0, 32), 0, "|")
Next
$cz[0][0] = UBound($cz) - 1
Local $d1[1][5] = [["", "hWnd", "$WIN_STATE_ACTIVE", "$WIN_STATE_MINIMIZED", "$WIN_STATE_MAXIMIZED"]]
For $2k = 1 To $cz[0][0]
If $cz[$2k][0] <> "" And $cz[$2k][3] = 2 Then
_nb($d1, $cz[$2k][0] & "|" & $cz[$2k][1] & "|" & $cz[$2k][5] & "|" & $cz[$2k][6] & "|" & $cz[$2k][7], 0, "|")
EndIf
Next
$d1[0][0] = UBound($d1) - 1
Return $d1
EndFunc
Func _15i()
$ad = StringFormat("%04s", $ac) & ".log"
$af = $ae & $ad
$aj = $ai & $ad
If _wo($af) > 1e3 Then
$ac += 1
IniWrite($9u, "LogFile", "ID", $ac)
EndIf
IniWrite($9u, "LogFile", "LogPath", $af)
IniWrite($9u, "LogFile", "LogNetPath", $aj)
If FileGetSize($an) / 1024 > 100 Then
Local $d2 = $aq & @YEAR & @MON & @MDAY & @MIN & @SEC & @MSEC & ".log"
FileMove($an, $d2, 1 + 8)
EndIf
EndFunc
Func _15j()
If FileExists($9y) Then
$bj = IniRead($9y, "FreeSpaceCheck", "LowSpaceThresholdPerc", 5)
For $2k = 0 To 9 Step 1
$bk[$2k][0] = IniRead($9y, "FreeSpaceCheck", "Mail" & $2k & "Address", "")
$bk[$2k][1] = IniRead($9y, "FreeSpaceCheck", "Mail" & $2k & "Active", 0)
Next
$bh = IniRead($9y, "SmtpMail", "SmtpServer", "")
EndIf
If FileExists($a6) Then
$cg = IniRead($a6, "MetaData", @ComputerName, "NULL")
If $cg = "NULL" Then
IniWrite($aa, "MetaData", @ComputerName, "")
EndIf
EndIf
EndFunc
Func _15k()
$ac = IniRead($9u, "LogFile", "ID", "NULL")
If $ac = "NULL" Then
IniWrite($9u, "LogFile", "ID", 0)
$ac = 0
EndIf
EndFunc
Func _15l()
Local $d3 = _15m()
Local $d = WinGetHandle("NetPhone Client")
If @error Then
If ProcessExists($91) Then _15e("Error ScreenCaptureNetPhoneClient")
Else
Local $d0 = WinGetState($d)
If False Then
WinActivate($d)
Sleep(250)
EndIf
Local $d4 = WinGetPos($d)
$d4[0] = $d4[0] + 57
$d4[1] = $d4[1] + $d4[3] - 54
$d4[2] = $d4[0] + 174
$d4[3] = $d4[1] + 15
_15p("", "NetPhoneUser", "$NetPhoneClientPos", 0, _o2($d4))
$8i = PixelChecksum($d4[0], $d4[1], $d4[2], $d4[3], 1, Default, 1)
Local $d5[13] = [0x535353, 0x525252, 0x515151, 0x505050, 0x4F4F4F, 0x4D4D4D, 0x4C4C4C, 0x4B4B4B, 0x4A4A4A, 0x494949, 0x484848, 0x474747, 0x464646]
Local $21 = 0
For $d6 In $d5
PixelSearch($d4[0], $d4[1], $d4[2], $d4[3], $d6)
If Not @error Then $21 += 1
Next
If $21 > 8 And Not FileExists($bc & $8i & ".png") And Not FileExists($bc & "del\" & $8i & ".png") And Not FileExists($bc & "ini\" & $8i & ".png") Then
_n4($bc & $8i & ".png", $d4[0], $d4[1], $d4[2], $d4[3], 0)
EndIf
If BitAND($d0, 16) Then WinSetState($d, Default, @SW_MINIMIZE)
EndIf
If False Then WinActivate($d3)
$8j = IniRead($a6, "$NetPhoneUser", $8i, "NULL")
_15p("", "NetPhoneUser", "$NetPhoneUser", 0, $8j)
_15p("", "NetPhoneUser", "$NetPhoneUserChecksum", 0, $8i)
EndFunc
Func _15m()
Local $d7 = _15h()
Local $d
Local $d3
For $2k = 1 To $d7[0][0]
If $d7[$2k][0] <> "" Then
If $d7[$2k][2] = 8 Then
$8k = $d7[$2k][0]
$d3 = $d7[$2k][1]
EndIf
If False & StringStripWS($d7[$2k][0], 1 + 2) = "NetPhone Client" Then
$d = HWnd($d7[$2k][1])
If WinActivate($d) Then
_n5($b9 & $2k & ".png", $d)
EndIf
If $d7[$2k][3] = 16 Then
WinSetState($d, Default, @SW_MINIMIZE)
EndIf
If $d7[$2k][4] = 32 Then
WinSetState($d, Default, @SW_MAXIMIZE)
EndIf
If @error Then _15e("Error ScreenCaptureWnd")
EndIf
EndIf
Next
$d = HWnd($d3)
$8l = WinGetProcess($d)
WinActivate($d)
Return $d
EndFunc
Func _15n(ByRef $d8, $d9)
Local $da = TimerDiff($d8)
If $da > $d9 Then
$d8 = TimerInit()
Return $da
EndIf
Return 0
EndFunc
Func _15o()
IniWrite($at & "Global" & ".ini", "@ComputerName", StringReplace(StringFormat("%-16s", @IPAddress1), " ", "."), @ComputerName)
_15p("", "Global", "@IPAddress1", 0, @IPAddress1)
_15p("", "Global", "$AkkVersion", 0, $8h)
_15p("", "Global", "$SpawnExists", 0, $8p)
_15p("", "Global", "$KPSInfoExists", 0, $8s)
_15p("", "Global", "$PowerkatalogExists", 0, $8w)
_15p("", "Global", "$SHDUpdaterExists", 0, $90)
_15p("", "Global", "$NetPhoneClientExists", 0, $94)
_15p("", "Global", "$EcoroKpsButlerExists", 0, $98)
_15p("", "Global", "$ActiveWinTitle", 0, $8k)
_15p("", "Global", "$hWndActivePid", 0, $8l)
_15p("", "EventLog", "$EventLogFull", 0, $bn)
_15p("", "EventLog", "$EventLogCount", 0, $bo)
_15p("", "EventLog", "$EventLogOldest", 0, $bp)
_15p("", "SpawnStats", $8m & "TimeModified", 0, FileGetTime($8o, 0, 1))
Local $db = IsAdmin()
_15p("", "Misc", "$iIsAdmin", 0, $db)
Local $dc = _qs()
_15p("", "Misc", "$iTickCount", 0, $dc)
Local $dd = _qt()
_15p("", "Misc", "$iTickCount64", 0, $dd)
Local $de = _169()
_15p("", "Wmi", "$ComputerSystemProductName", 0, $de[0])
_15p("", "Wmi", "$ComputerSystemProductIdentifyingNumber", 0, $de[1])
_15p("", "AutoIt", "@Compiled", 0, @Compiled)
_15p("", "AutoIt", "@ScriptName", 0, @ScriptName)
_15p("", "AutoIt", "@ScriptDir", 0, @ScriptDir)
_15p("", "AutoIt", "@ScriptFullPath", 0, @ScriptFullPath)
_15p("", "AutoIt", "@WorkingDir", 0, @WorkingDir)
_15p("", "AutoIt", "@AutoItExe", 0, @AutoItExe)
_15p("", "AutoIt", "@AutoItPID", 0, @AutoItPID)
_15p("", "AutoIt", "@AutoItVersion", 0, @AutoItVersion)
_15p("", "AutoIt", "@AutoItX64", 0, @AutoItX64)
_15p("", "Directory", "@AppDataCommonDir", 0, @AppDataCommonDir)
_15p("", "Directory", "@DesktopCommonDir", 0, @DesktopCommonDir)
_15p("", "Directory", "@DocumentsCommonDir", 0, @DocumentsCommonDir)
_15p("", "Directory", "@FavoritesCommonDir", 0, @FavoritesCommonDir)
_15p("", "Directory", "@ProgramsCommonDir", 0, @ProgramsCommonDir)
_15p("", "Directory", "@StartMenuCommonDir", 0, @StartMenuCommonDir)
_15p("", "Directory", "@StartupCommonDir", 0, @StartupCommonDir)
_15p("", "Directory", "@AppDataDir", 0, @AppDataDir)
_15p("", "Directory", "@LocalAppDataDir", 0, @LocalAppDataDir)
_15p("", "Directory", "@DesktopDir", 0, @DesktopDir)
_15p("", "Directory", "@MyDocumentsDir", 0, @MyDocumentsDir)
_15p("", "Directory", "@FavoritesDir", 0, @FavoritesDir)
_15p("", "Directory", "@ProgramsDir", 0, @ProgramsDir)
_15p("", "Directory", "@StartMenuDir", 0, @StartMenuDir)
_15p("", "Directory", "@UserProfileDir", 0, @UserProfileDir)
_15p("", "Directory", "@HomeDrive", 0, @HomeDrive)
_15p("", "Directory", "@HomePath", 0, @HomePath)
_15p("", "Directory", "@HomeShare", 0, @HomeShare)
_15p("", "Directory", "@LogonDNSDomain", 0, @LogonDNSDomain)
_15p("", "Directory", "@LogonDomain", 0, @LogonDomain)
_15p("", "Directory", "@LogonServer", 0, @LogonServer)
_15p("", "Directory", "@ProgramFilesDir", 0, @ProgramFilesDir)
_15p("", "Directory", "@CommonFilesDir", 0, @CommonFilesDir)
_15p("", "Directory", "@WindowsDir", 0, @WindowsDir)
_15p("", "Directory", "@SystemDir", 0, @SystemDir)
_15p("", "Directory", "@TempDir", 0, @TempDir)
_15p("", "Directory", "@ComSpec", 0, @ComSpec)
_15p("", "SystemInfo", "@CPUArch", 0, @CPUArch)
_15p("", "SystemInfo", "@KBLayout", 0, @KBLayout)
_15p("", "SystemInfo", "@MUILang", 0, @MUILang)
_15p("", "SystemInfo", "@OSArch", 0, @OSArch)
_15p("", "SystemInfo", "@OSLang", 0, @OSLang)
_15p("", "SystemInfo", "@OSType", 0, @OSType)
_15p("", "SystemInfo", "@OSVersion", 0, @OSVersion)
_15p("", "SystemInfo", "@OSBuild", 0, @OSBuild)
_15p("", "SystemInfo", "@OSServicePack", 0, @OSServicePack)
_15p("", "SystemInfo", "@ComputerName", 0, @ComputerName)
_15p("", "SystemInfo", "@UserName", 0, @UserName)
_15p("", "SystemInfo", "@IPAddress1", 0, @IPAddress1)
_15p("", "SystemInfo", "@IPAddress2", 0, @IPAddress2)
_15p("", "SystemInfo", "@IPAddress3", 0, @IPAddress3)
_15p("", "SystemInfo", "@IPAddress4", 0, @IPAddress4)
_15p("", "SystemInfo", "@DesktopHeight", 0, @DesktopHeight)
_15p("", "SystemInfo", "@DesktopWidth", 0, @DesktopWidth)
_15p("", "SystemInfo", "@DesktopDepth", 0, @DesktopDepth)
_15p("", "SystemInfo", "@DesktopRefresh", 0, @DesktopRefresh)
EndFunc
Func _15p($df, $dg, $dh, $di, $dj)
If $df = "" Then
$df = $at & $dg & ".ini"
EndIf
IniWrite($df,($di ? $dg & $dh : $dh), $8g, $dj)
IniWrite($b1, $dg, $dh, $dj)
EndFunc
Func _15q()
_15r($8m, $8n, $8o, $8p)
_15r("KPSInfo.exe", $8q, $8r, $8s)
_15r($bw, $bx, $by & $ch, $bz)
If _qt() > 60e3 * 5 Then
_15r($95, $96, $97, $98)
EndIf
EndFunc
Func _15r($dk, $dl, $dm, $dn, $do = @SW_HIDE)
If $dn And Not ProcessExists($dk) Then
_15e($dk & " wird gestartet")
Return Run($dm, $dl, $do)
EndIf
Return 0
EndFunc
Func _15t()
If _15u() And @Compiled Then
DirRemove($bg, 1)
_15v($bf, $bg)
FileDelete($bg & "\Downloads alt.lnk")
FileCreateShortcut($bg, $bf & "\Downloads alt")
IniWrite($9u, "Downloads", "LastCleaningDate", _ui(@YEAR, @MON, @MDAY))
Local Const $dp = '' & 'Wenn Sie noch wichtige Dateien im Ordner "Downloads" aufbewahren, die Sie benötigen, kopieren Sie diese bitte an einen anderen Ort.' & @CRLF & 'Alle Dateien aus dem Ordner "Downloads" wurden bereits in den Ordner "Downloads alt" verschoben.' & @CRLF & 'Der Ordner "Downloads alt" ist über eine Verknüpfung in "Downloads" zu erreichen.' & @CRLF & 'Alle Ihre Dateien die im Ordner "Downloads alt" bleiben, werden demnächst unwiderruflich GELÖSCHT!' & @CRLF & 'Bitte sichten und sichern Sie am besten jetzt sofort Ihre weiterhin benötigten Dateien.' & @CRLF & 'Soll der Ordner "Downloads alt" jetzt geöffnet werden?' & @CRLF
If MsgBox(4 + 48 + 4096, "ACHTUNG WICHTIG! LÖSCHUNG IHRER DOWNLOAD-DATEIEN", $dp, $87) = 6 Then
ShellExecute($bg)
EndIf
EndIf
EndFunc
Func _15u()
Return(_ui(@YEAR, @MON, @MDAY) - _15w()) >= 14
EndFunc
Func _15v($dq, $dr)
If FileExists($dq) Then
If Not FileExists($dr) Then DirCreate($dr)
FileMove($dq & "\*.*", $dr, 1 + 8)
Local Const $ds = _wq($dq, Default, 2, True)
If Not @error Then
For $dt In $ds
DirMove($dt, $dr, 1)
Next
EndIf
EndIf
EndFunc
Func _15w()
Return IniRead($9u, "Downloads", "LastCleaningDate", "NULL")
EndFunc
Func _15y()
Local Const $du = DriveGetLabel(@HomeDrive & "\")
Local Const $dv = DriveSpaceFree(@HomeDrive & "\")
Local Const $dw = DriveSpaceTotal(@HomeDrive & "\")
Local Const $dx =($dv / $dw) * 100
If $dx < $bj Then
If(_ui(@YEAR, @MON, @MDAY) - IniRead($9u, "FreeSpaceCheck", "LastMailSendDate", "NULL")) >= 1 Then
IniWrite($9u, "FreeSpaceCheck", "LastMailSendDate", _ui(@YEAR, @MON, @MDAY))
For $2k = 0 To 9 Step 1
If $bk[$2k][0] <> "" And $bk[$2k][1] = 1 Then
_15e("Sending Mail to " & $bk[$2k][0])
_15z($bk[$2k][0], Round($dx, 2), $du, $dv, $dw)
Sleep(3000)
EndIf
Next
EndIf
EndIf
EndFunc
Func _15z($7d, $dx, $du, $dv, $dw)
Local $7b = "akk.exe (Gerrit)"
Local $7c = "akk@kuechen-brauckhoff.de"
Local $7e = "AKK Warnung freier Speicher auf " & @ComputerName & " ist " & $dx & "% !"
Local $dy[0]
_nb($dy, "Akk Warnung wenig Speicherplatz auf:")
_nb($dy, @ComputerName)
If @IPAddress1 <> "0.0.0.0" Then _nb($dy, @IPAddress1)
If @IPAddress2 <> "0.0.0.0" Then _nb($dy, @IPAddress2)
If @IPAddress3 <> "0.0.0.0" Then _nb($dy, @IPAddress3)
If @IPAddress4 <> "0.0.0.0" Then _nb($dy, @IPAddress4)
_nb($dy, $du & " (" & @HomeDrive & ")")
_nb($dy, Round($dv / 1024, 2) & " GB frei von " & Round($dw / 1024, 2) & " GB")
_nb($dy, $dx & "% frei")
Local $dz = _14y($bh, $7b, $7c, $7d, $7e, $dy, $bi, -1, 0)
Local $e0 = @error
If $dz = 0 Then
Local Const $dp = '' & 'DIE FESTPLATTE IST FAST VOLL!' & @CRLF & @CRLF & 'Bitte Herrn Heger bescheid geben:' & @CRLF & 'heger@easyconnectit.de' & @CRLF & 'oder 0176 23984427' & @CRLF & @CRLF & _o2($dy, @CRLF) & @CRLF & @CRLF & 'Mail failed with error code ' & $e0 & @CRLF
MsgBox(48 + 4096, "Warnung!", $dp)
EndIf
EndFunc
Func _160($e1)
Return Round($e1 / 1024 / 1024, 2)
EndFunc
Func _161(ByRef $e2, $e3, $e4, $e5 = 0, $e6 = "")
Local Static $e7 = 0
$e7 += 1
Local Const $e8 = "Metric read from " & StringReplace($cb, "\", "\\")
Local $e9[]
Local $ea[]
$e9.Name = $e3 & "+" & $e7
$e9.Type = $e4
$e9.Value = $e5
$e9.Text =($e6 = "" ? $e8 : $e6)
$e9.Labels = $ea
$e2[$e9.Name] = $e9
Return $e9.Name
EndFunc
Func _162($eb)
Local $e9[]
Local $ec = ProcessList($eb)
Local $6h = "", $6i = "", $2b = "", $6j = ""
_x3($eb, $6h, $6i, $2b, $6j)
$e9.Count = $ec[0][0]
$e9.FileName = $2b
Return $e9
EndFunc
Func _163()
If $bm And ProcessExists($bw) Then
$bl = InetGet("http://localhost:9182/metrics", $b4, 1, 1)
$bm = 0
EndIf
EndFunc
Func _164()
If Not $bm Then
If InetGetInfo($bl, 2) Then
If InetGetInfo($bl, 3) Then
If FileGetSize($b4) Then FileCopy($b4, $b7, 1 + 8)
Else
FileDelete($b4)
_15e("Error ScrapeDownload")
EndIf
InetClose($bl)
$bl = 0
$bm = 1
EndIf
EndIf
EndFunc
Func _165()
If Not $bs Then
If FileCopy($bu, $br, 1 + 8) Then
$bs = FileExists($br)
EndIf
EndIf
EndFunc
Func _166()
ProcessClose($bw)
Local $ed =(@OSArch = "X64") ? $c6 : $c2
Local $ee = FileGetTime($by, 0, 1)
Local $ef = FileGetTime($ed, 0, 1)
If Not $bz Or $ee <> $ef Then
_15e("Reload WmiExporter " & $ed)
If FileCopy($ed, $by, 1 + 8) Then
$bz = FileExists($by)
Else
_15e("ERROR Reload WmiExporter " & $ed)
EndIf
EndIf
If Not FileExists($c9) Then DirCreate($c9)
EndFunc
Func _167()
_15f()
Local $eg[]
Local $e3 = _161($eg, "akk_metadata", "gauge", _146() / 1e3)
$eg[$e3].Labels.username = @UserName
$eg[$e3].Labels.ip_address = @IPAddress1
$eg[$e3].Labels.netphone_user =($8k = "LockScreen" ? "LockScreen" : $8j)
If $cg <> "NULL" And StringLen($cg) And Not StringIsSpace($cg) Then
$eg[$e3].LabelsRaw = $cg
EndIf
Local $eh = MemGetStats()
_161($eg, "akk_idletime_sec", "gauge", _146() / 1e3, "Returns the number of seconds since last user activity (i.e. KYBD/Mouse)")
_161($eg, "akk_memstats_load", "gauge", $eh[$ci], "Memory Load (Percentage of memory in use)")
_161($eg, "akk_memstats_total_physram_gb", "gauge", _160($eh[$cj]), "Total physical RAM")
_161($eg, "akk_memstats_avail_physram_gb", "gauge", _160($eh[$ck]), "Available physical RAM")
_161($eg, "akk_memstats_total_pagefile_gb", "gauge", _160($eh[$cl]), "Total Pagefile")
_161($eg, "akk_memstats_avail_pagefile_gb", "gauge", _160($eh[$cm]), "Available Pagefile")
_161($eg, "akk_memstats_total_virtual_gb", "gauge", _160($eh[$cn]), "Total virtual")
_161($eg, "akk_memstats_avail_virtual_gb", "gauge", _160($eh[$co]), "Available virtual")
_161($eg, "akk_eventlog_full", "gauge",($bn ? 1 : 0), "Retrieves whether the event log is full")
_161($eg, "akk_eventlog_count", "gauge", $bo, "Retrieves the number of records in the event log")
_161($eg, "akk_eventlog_oldest", "gauge", $bp, "Retrieves the absolute record number of the oldest record in the event log")
Local $ei = _162("chrome.exe")
$e3 = _161($eg, "akk_process_count", "gauge", $ei.Count)
$eg[$e3].Labels.process = $ei.FileName
Local $ej = _162("javaw.exe")
$e3 = _161($eg, "akk_process_count", "gauge", $ej.Count)
$eg[$e3].Labels.process = $ej.FileName
Local $ek = _162("FusionFX.exe")
$e3 = _161($eg, "akk_process_count", "gauge", $ek.Count)
$eg[$e3].Labels.process = $ek.FileName
Local $el[1]
Local $em = "", $en = ""
Local $eo
For $e2 In $eg
$e3 = StringSplit($e2.Name, "+")[1]
If $em <> $e3 Then
_nb($el, "# HELP " & $e3 & " " & $e2.Text)
_nb($el, "# TYPE " & $e3 & " " & $e2.Type)
EndIf
$eo = MapKeys($e2.Labels)
$en = ""
If UBound($eo) Then
$en &= "{"
For $ep In $eo
$en &= $ep & '="' & $e2.Labels[$ep] & '",'
Next
If MapExists($e2, "LabelsRaw") Then
$en &= $e2.LabelsRaw
EndIf
If StringRight($en, 1) = "," Then $en = StringTrimRight($en, 1)
$en &= "}"
EndIf
_nb($el, $e3 & $en & " " & $e2.Value)
$em = $e3
Next
$el[0] = UBound($el) - 1
Local $eq
_ww($cb, $eq)
If Not _oh($el, $eq, 3) Then
_wx($cb, $el, 1)
EndIf
EndFunc
Func _168()
Local $er[1]
_nb($er, '[')
_nb($er, '  {')
_nb($er, '    "labels": {')
_nb($er, '      "job": "node",')
_nb($er, '      "instance": "@ComputerName@"')
_nb($er, '    },')
_nb($er, '    "targets": [')
_nb($er, '      "@IPAddress1@:9182"')
_nb($er, '    ]')
_nb($er, '  }')
_nb($er, ']')
Local $es
$er[0] = UBound($er) - 1
Local $et = $cd & "@ComputerName@.json"
_ww($et, $es)
If Not _oh($er, $es, 3) Then
_wx($et, $er, 1)
EndIf
EndFunc
Func _169()
Local $eu[2] = ["(Unknown)", "(Unknown)"], $ev, $ew
$ew = ObjGet("winmgmts:\\.\root\cimv2")
$ev = $ew.ExecQuery("Select * From Win32_ComputerSystemProduct", "WQL", 0x30)
If IsObj($ev) Then
For $ex In $ev
$eu[0] = StringStripWS($ex.Name, 1 + 2)
$eu[1] = StringStripWS($ex.IdentifyingNumber, 1 + 2)
Next
Return $eu
EndIf
Return SetError(1, 0, $eu)
EndFunc
