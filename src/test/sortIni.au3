#include <Array.au3>
#include <FileConstants.au3>

$file = @ScriptDir & '\test.ini'
_IniSort($file)

Func _IniSort($hIni, $iDescend = 0)
    Local $aIRSN = IniReadSectionNames($hIni)
    If Not IsArray($aIRSN) Then Return SetError(1, 0, 0)
    _ArrayDisplay($aIRSN)
    _ArraySort($aIRSN, $iDescend, 1)
    _ArrayDisplay($aIRSN)
    Local $sHold

    For $iCC = 1 To UBound($aIRSN) - 1
       Local $aIRS = IniReadSection($hIni, $aIRSN[$iCC])
       $sHold &= '[' & $aIRSN[$iCC] & ']' & @CRLF
       If Not IsArray($aIRS) Then
             $sHold &= @CRLF
             ContinueLoop
       EndIf
       _ArrayDisplay($aIRS)
       _ArraySort($aIRS, $iDescend, 1)
       _ArrayDisplay($aIRS)
       For $xCC = 1 To $aIRS[0][0]
           $sHold &= $aIRS[$xCC][0] & '=' & $aIRS[$xCC][1] & @CRLF
       Next
       $sHold &= @CRLF
    Next

    If $sHold Then
       $sHold = StringTrimRight($sHold, 2)
       FileClose(FileOpen($hIni, 2 + $FO_UTF8_NOBOM))
       FileWrite($hIni, $sHold)
       Return 1
    EndIf

    Return SetError(1, 0, 0)
EndFunc
