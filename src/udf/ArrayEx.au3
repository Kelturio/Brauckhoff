; AU3Check settings
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Fileversion_First_Increment=y
#AutoIt3Wrapper_Run_AU3Check=y
#Autoit3wrapper_Jump_to_First_Error=y
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#Tidy_Parameters=/tc 4 /gd /reel /sci 1 /kv 0 /bdir "tidy\bdir\" /sf /ewnl
#include-once

#include <Array.au3>

; #INDEX# =======================================================================================================================
; Title .........: ArrayEx
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Functions for manipulating arrays.
; Author(s) .....: Searinox, Melba23
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _ArrayCompare
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; ===============================================================================================================================

; #GLOBAL CONSTANTS# ============================================================================================================
Global Enum $ARRAYCOMPARE_MODE_CELL, $ARRAYCOMPARE_MODE_ROWS, $ARRAYCOMPARE_MODE_COLS, $ARRAYCOMPARE_MODE_ARR
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _ArrayCompare
; Description ...:
; Syntax ........: _ArrayCompare(Const Byref $aArray1, Const Byref $aArray2[, $iMode = 0])
; Parameters ....: $aArray1             - [in/out and const] an array of unknowns.
;                  $aArray2             - [in/out and const] an array of unknowns.
;                  $iMode               - [optional] an integer value. Default is 0.
; Return values .: None
; Author ........: Melba23
; Modified ......: Searinox
; Remarks .......:
; Related .......:
; Link ..........: https://www.autoitscript.com/forum/topic/182506-array-comparison/?do=findComment&comment=1310873
; Example .......: No
; ===============================================================================================================================
Func _ArrayCompare(Const ByRef $aArray1, Const ByRef $aArray2, $iMode = $ARRAYCOMPARE_MODE_CELL)
    ; Check if arrays
    If Not (IsArray($aArray1)) Or Not (IsArray($aArray2)) Then
        Return SetError(1, 0, 0)
    EndIf

    ; Check if same number of dimensions
    Local $iDims = UBound($aArray1, $UBOUND_DIMENSIONS)
    If $iDims <> UBound($aArray2, $UBOUND_DIMENSIONS) Then
        Return SetError(2, 0, 0)
    EndIf

    ; Check if same size
    Local $iRows = UBound($aArray1, $UBOUND_ROWS)
    Local $iCols = UBound($aArray1, $UBOUND_COLUMNS)
    If $iRows <> UBound($aArray2, $UBOUND_ROWS) Or $iCols <> UBound($aArray2, $UBOUND_COLUMNS) Then
        Return SetError(3, 0, 0)
    EndIf

    Local $sString_1, $sString_2

    Switch $iMode

        Case $ARRAYCOMPARE_MODE_CELL ; Compare each element
            For $i = 0 To $iRows - 1
                For $j = 0 To $iCols - 1
                    If $aArray1[$i][$j] <> $aArray1[$i][$j] Then
                        Return SetError(4, 0, 0)
                    EndIf
                Next
            Next

        Case $ARRAYCOMPARE_MODE_ROWS ; Convert rows to strings
            For $i = 0 To $iRows - 1
                For $j = 0 To $iCols - 1
                    $sString_1 &= $aArray1[$i][$j]
                    $sString_2 &= $aArray2[$i][$j]
                Next
                If $sString_1 <> $sString_2 Then
                    Return SetError(4, 0, 0)
                EndIf
            Next

        Case $ARRAYCOMPARE_MODE_COLS ; Convert columnss to strings
            For $j = 0 To $iCols - 1
                For $i = 0 To $iRows - 1
                    $sString_1 &= $aArray1[$i][$j]
                    $sString_2 &= $aArray2[$i][$j]
                Next
                If $sString_1 <> $sString_2 Then
                    Return SetError(4, 0, 0)
                EndIf
            Next

        Case $ARRAYCOMPARE_MODE_ARR ; Convert whole array to string
            If _ArrayToString($aArray1) <> _ArrayToString($aArray2) Then
                Return SetError(4, 0, 0)
            EndIf

    EndSwitch

    ; Looks as if they match
    Return 1
EndFunc   ;==>_ArrayCompare
