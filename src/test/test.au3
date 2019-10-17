
#include <array.au3>

ConsoleWrite(@CRLF)
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>








#include <MsgBoxConstants.au3>

Example()

Func Example()
    ; Run Notepad
;~     Run("notepad.exe")

    ; Wait 10 seconds for the Notepad window to appear.
;~     WinWait("[CLASS:Notepad]", "", 10)

    ; Retrieve the handle of the Notepad window using the classname of Notepad.
    Local $hWnd = WinGetHandle("[CLASS:Notepad]")
    If @error Then
        MsgBox($MB_SYSTEMMODAL, $hWnd, "An error occurred when trying to retrieve the window handle of Notepad.")
;~         Exit
    EndIf

    ; Display the handle of the Notepad window.
	if $hWnd then MsgBox($MB_SYSTEMMODAL, VarGetType($hWnd == 0), "akk")

    ; Close the Notepad window using the handle returned by WinGetHandle.
    WinClose($hWnd)
EndFunc   ;==>Example












exit






;
;
;

#include <array.au3>

;---------------------------------------------
;  define arrays
;---------------------------------------------

local $list[1337][4]                                                 ; 300 windows max
local enum $title, $handle, $pid, $exe                              ; enumerations for array offsets

;---------------------------------------------
;  get array of windows and populate $list
;---------------------------------------------

local $a1 = winlist()                                               ; get list of windows

for $i = 0 to $a1[0][0]                                             ; and copy title, handle and pid to $list array
    $list[$i][$title]   = $a1[$i][$title]                           ; window title
    $list[$i][$handle]  = $a1[$i][$handle]                          ; window handle
    $list[$i][$pid]     = wingetprocess($a1[$i][$handle])           ; owning process id
next

;---------------------------------------------
;  get array of processes and populate $list
;---------------------------------------------

local $a2 = processlist()                                           ; get list of processes

for $i = 0 to $a1[0][0]
    for $j = 0 to $a2[0][0]
        if $list[$i][2] = $a2[$j][1] then $list[$i][3] = $a2[$j][0] ; and copy process name to $list array
    Next
next

_arraysort($list,1,0,0,2)                                           ; sort the array by $pid desc



redim $list[$i][4]

_arraydisplay($list)

;---------------------------------------------
;  format output to console
;---------------------------------------------

local $savepid = '', $out = ''

for $i = 0 to ubound($list) - 1
    if $i = 0 then
        $out &= stringformat('%-10s%-15s',$list[$i][$pid],$list[$i][$exe]) & @crlf

        $savepid = $list[$i][$pid]
    endif

    if $list[$i][$pid] = '' then exitloop

    if  $savepid = $list[$i][$pid] then
        if $list[$i][$title] <> '' then $out &= @tab & @tab & $list[$i][$title] & @crlf

    else
        if $i <> 0 then $out &= stringformat('%-10s%-15s',$list[$i][$pid],$list[$i][$exe]) & @crlf

        $savepid = $list[$i][$pid]
    endif

next

consolewrite($out & @lf)





















exit


$file = @ScriptDir & '\test.ini'
_IniSort($file)


Func _IniSort($hIni, $iAscend = 1)
    Local $aIRSN = IniReadSectionNames($hIni)
    If Not IsArray($aIRSN) Then Return SetError(1, 0, 0)

    _ArraySort($aIRSN, 0, $iAscend)
    Local $sHold

    For $iCC = 1 To UBound($aIRSN) - 1
       Local $aIRS = IniReadSection($hIni, $aIRSN[$iCC])
       $sHold &= '[' & $aIRSN[$iCC] & ']' & @CRLF
       If Not IsArray($aIRS) Then
             $sHold &= @CRLF
             ContinueLoop
       EndIf
       _ArraySort($aIRS, 0, $iAscend, 0, 2)
       For $xCC = 1 To $aIRS[0][0]
           $sHold &= $aIRS[$xCC][0] & '=' & $aIRS[$xCC][1] & @CRLF
       Next
       $sHold &= @CRLF
    Next

    If $sHold Then
       $sHold = StringTrimRight($sHold, 2)
       FileClose(FileOpen($hIni, 2))
       FileWrite($hIni, $sHold)
       Return 1
    EndIf

    Return SetError(1, 0, 0)
EndFunc




exit



; Can return nothing relevant if machine is not a factory build
Global $aArray = _ComputerNameAndModel() ; Returns an Array with 2 indexes.
MsgBox(64, "_ComputerNameAndModel()", 'The Product is a "' & $aArray[0] & '" and the Serial Number is "' & $aArray[1] & '".')

Func _ComputerNameAndModel()
    Local $aReturn[2] = ["(Unknown)", "(Unknown)"], $oColItems, $oWMIService

    $oWMIService = ObjGet("winmgmts:\\.\root\cimv2")
    $oColItems = $oWMIService.ExecQuery("Select * From Win32_ComputerSystemProduct", "WQL", 0x30)
    If IsObj($oColItems) Then
        For $oObjectItem In $oColItems
            $aReturn[0] = $oObjectItem.Name
            $aReturn[1] = $oObjectItem.IdentifyingNumber
        Next
        Return $aReturn
    EndIf
    Return SetError(1, 0, $aReturn)
EndFunc   ;==>_ComputerNameAndModel



 ; Can return nothing relevant if machine is not a factory build
ConsoleWrite(_GetComputerModel() & @CRLF)

Func _GetComputerModel()
    Local $oWMIService = ObjGet("winmgmts:\\.\")

    Local $oColItems = $oWMIService.ExecQuery("Select * From Win32_ComputerSystem", "WQL", 0x30)
	Local $sDescription

    If IsObj($oColItems) Then
        For $oObjectItem In $oColItems
            $sDescription &= $oObjectItem.Model
        Next

        Return $sDescription
    EndIf

    Return SetError(1, 1, 0)
EndFunc   ;==>_GetComputerModel

 exit

 Global Const $aTSR = _GetTotalScreenResolution()

 MsgBox(0, "Total Screen Resolution", "Width = " & $aTSR[0] & @TAB & "Height = " & $aTSR[1])

 Func _GetTotalScreenResolution()
     Local Const $SM_VIRTUALWIDTH = 78
     Local Const $VirtualDesktopWidth = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_VIRTUALWIDTH)

     Local Const $SM_VIRTUALHEIGHT = 79
     Local Const $VirtualDesktopHeight = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $SM_VIRTUALHEIGHT)

     Local Const $aRet[2] = [$VirtualDesktopWidth[0], $VirtualDesktopHeight[0]]

     Return $aRet
 EndFunc

 exit

$text = "Motherboard" & @CRLF & "-------------------------------------" & @CRLF
Dim $Obj_WMIService = ObjGet("winmgmts:\\" & "localhost" & "\root\cimv2")
Dim $Obj_Services = $Obj_WMIService.ExecQuery("Select * from Win32_ComputerSystem")
Local $Obj_Item
For $Obj_Item In $Obj_Services
    $manufacturer =  $Obj_Item.Manufacturer
    $model = $Obj_Item.Model
Next
$text &= $manufacturer & @CRLF & $model & @CRLF
MsgBox(0,"", $text)

$text = "GPU" & @CRLF & "-------------------------------------" & @CRLF
Dim $Obj_WMIService = ObjGet("winmgmts:\\" & "localhost" & "\root\cimv2")
Dim $Obj_Services = $Obj_WMIService.ExecQuery("Select * from Win32_VideoController")
Local $Obj_Item
For $Obj_Item In $Obj_Services
    $text &= $Obj_Item.Name
Next
MsgBox(0,"", $text)

$text = "RAM" & @CRLF & "-------------------------------------" & @CRLF
Dim $Obj_WMIService = ObjGet("winmgmts:\\" & "localhost" & "\root\cimv2")
Dim $Obj_Services = $Obj_WMIService.ExecQuery("Select * from Win32_PhysicalMemory")
Local $Obj_Item
For $Obj_Item In $Obj_Services
    $text &= $Obj_Item.DeviceLocator & " - " & $Obj_Item.Capacity & " - " & $Obj_Item.Speed & @crlf
Next
MsgBox(0,"", $text)