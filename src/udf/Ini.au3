; AU3Check settings
#AutoIt3Wrapper_Res_Fileversion=1.0.0.3
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Fileversion_First_Increment=y
#AutoIt3Wrapper_Run_AU3Check=y
#Autoit3wrapper_Jump_to_First_Error=y
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#Tidy_Parameters=/tc 4 /gd /reel /sci 1 /kv 0 /bdir "tidy\bdir\" /sf /ewnl
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
; Name ..........: _IniArraySort
; Description ...:
; Syntax ........: _IniArraySort($aIniArray[, $iDescending = 0[, $iSortSections = 1[, $iSortKeys = 1]]])
; Parameters ....: $aIniArray           - an array of unknowns.
;                  $iDescending         - [optional] an integer value. Default is 0.
;                  $iSortSections       - [optional] an integer value. Default is 1.
;                  $iSortKeys           - [optional] an integer value. Default is 1.
; Return values .: None
; Author ........: Searinox
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
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
; Name ..........: _IniArrayWriteToFile
; Description ...:
; Syntax ........: _IniArrayWriteToFile($sFilePath, $aIniArray)
; Parameters ....: $sFilePath           - a string value.
;                  $aIniArray           - an array of unknowns.
; Return values .: None
; Author ........: Searinox
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IniArrayWriteToFile($sFilePath, $aIniArray)
    Return _FileWriteFromArray($sFilePath, $aIniArray)
EndFunc   ;==>_IniArrayWriteToFile
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _IniReadToArray
; Description ...:
; Syntax ........: _IniReadToArray($sFilePath)
; Parameters ....: $sFilePath           - a string value.
; Return values .: None
; Author ........: Searinox
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
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
