#include-once

#include <Array.au3>
#include <File.au3>

; #INDEX# =======================================================================================================================
; Title .........: Ini
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Functions for manipulating ini files.
; Author(s) .....: Searinox
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _IniReadToArray
; _IniArraySort
; _IniArrayWriteToFile
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ===============================================================================================================================

; #GLOBAL CONSTANTS# ============================================================================================================
Global Const $RANDOM_DELIM = "Rc3@%$8U~?LHG<TDAX=DAXQ-f%JK>.T&"
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Author ........: Searinox
; ===============================================================================================================================
Func _IniReadToArray($sFilePath)
	Local $aSections[0][2]
	Local $aSection[0][2]
	Local $aLines = FileReadToArray($sFilePath)
	If @error Then Return SetError(@error, 0, 0)
	For $i = 0 To UBound($aLines) - 1
		Local $sLine = StringStripWS($aLines[$i], $STR_STRIPLEADING)
		If StringLeft($sLine, 1) = "[" Then
			_ArrayAdd($aSections, $sLine, 0, $RANDOM_DELIM, $RANDOM_DELIM)
			_ArrayDelete($aSection, "0-" & UBound($aSection) - 1)
			ContinueLoop
		EndIf
		Local $iSplitIdx = StringInStr($sLine, "=")
		If $iSplitIdx Then
			_ArrayAdd($aSection, StringMid($sLine, 1, $iSplitIdx - 1), 0, $RANDOM_DELIM, $RANDOM_DELIM)
			$aSection[UBound($aSection) - 1][1] = StringMid($sLine, $iSplitIdx + 1)
			$aSections[UBound($aSections) - 1][1] = $aSection
		EndIf
	Next
	Return $aSections
EndFunc   ;==>_IniReadToArray

; #FUNCTION# ====================================================================================================================
; Author ........: Searinox
; ===============================================================================================================================
Func _IniArraySort($aIniArray, $iDescending = 0, $iSortSections = 1, $iSortKeys = 1)
	Local $aResult[0][1]
	If $iSortSections Then _ArraySort($aIniArray, $iDescending)
	For $i = 0 To UBound($aIniArray) - 1
		_ArrayAdd($aResult, ($i ? @CRLF : "") & $aIniArray[$i][0], 0, $RANDOM_DELIM, $RANDOM_DELIM)
		Local $aSection = $aIniArray[$i][1]
		If $iSortKeys Then _ArraySort($aSection)
		For $j = 0 To UBound($aSection) - 1
			_ArrayAdd($aResult, $aSection[$j][0] & "=" & $aSection[$j][1], 0, $RANDOM_DELIM, $RANDOM_DELIM)
		Next
	Next
	Return $aResult
EndFunc   ;==>_IniArraySort

; #FUNCTION# ====================================================================================================================
; Author ........: Searinox
; ===============================================================================================================================
Func _IniArrayWriteToFile($sFilePath, $aIniArray)
	Return _FileWriteFromArray($sFilePath, $aIniArray)
EndFunc   ;==>_IniArrayWriteToFile
