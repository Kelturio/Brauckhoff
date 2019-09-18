#include <Array.au3>
#include <File.au3>
;~ #include <FileConstants.au3>

$sFilePath = @ScriptDir & '\test.ini'
;~ _IniSort($sFilePath)




_IniReadToArray($sFilePath)

Func _IniReadToArray($sFilePath)
	Local $aSections[0][2]
	Local $aSection[0][2]
	Local $aResult[0][1]
	Local $aLines = FileReadToArray($sFilePath)
	If @error Then Return SetError(@error, 0, 0)
	For $i = 0 To UBound($aLines) - 1
		Local $sLine = StringStripWS($aLines[$i], $STR_STRIPLEADING)
		If StringLeft($sLine, 1) = "[" Then
			_ArrayAdd($aSections, $sLine)
			_ArrayDelete($aSection, "0-" & UBound($aSection) - 1)
            ContinueLoop
        EndIf
        Local $iSplitIdx = StringInStr($sLine, "=")
		If $iSplitIdx Then
			_ArrayAdd($aSection, StringMid($sLine, 1, $iSplitIdx - 1))
			$aSection[UBound($aSection) - 1][1] = StringMid($sLine, $iSplitIdx + 1)
			$aSections[UBound($aSections) - 1][1] = $aSection
		EndIf
	Next
;~     _ArraySort($aSections)
	For $i = 0 To UBound($aSections) - 1
		If $i > 0 Then _ArrayAdd($aResult, "")
		_ArrayAdd($aResult, $aSections[$i][0])
		$aSection = $aSections[$i][1]
		_ArraySort($aSection)
		For $j = 0 To UBound($aSection) - 1
			_ArrayAdd($aResult, $aSection[$j][0] & "=" & $aSection[$j][1])
		Next
	Next
	_FileWriteFromArray($sFilePath, $aResult)
EndFunc   ;==>_IniReadToArray




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
EndFunc   ;==>_IniSort
