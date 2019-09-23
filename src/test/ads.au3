#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

ConsoleWrite(@CRLF)

_DebugOut(42)
_DebugOut("")
_DebugOut(Default)
_DebugOut(True)


Func _DebugOut(Const $sOutput, Const $_iCurrentError = @error, Const $_iCurrentExtended = @extended)
	ConsoleWrite((IsNumber($sOutput) = 0) & @CRLF)
	ConsoleWrite((IsString($sOutput) = 0) & @CRLF)
	ConsoleWrite((IsBool($sOutput) = 0) & @CRLF)
	If IsNumber($sOutput) = 0 And IsString($sOutput) = 0 And IsBool($sOutput) = 0 Then
		ConsoleWrite("if" & @CRLF)
	Else
		ConsoleWrite("else" & @CRLF)
	EndIf


EndFunc   ;==>_DebugOut

Exit

Example()




Func Example()
	; Create a constant variable in Local scope of the filepath that will be read/written to.
;~     Local Const $sFilePath = _WinAPI_GetTempFileName(@TempDir)
	Local Const $sFilePath = "asdf.txt:werner.txt"

	; Create a temporary file to write data to.
	If Not FileWrite($sFilePath, "Start of the FileWrite example, line 1. " & @CRLF) Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	FileCopy($sFilePath, "qwertz.txt")

	; Open the file for writing (append to the end of a file) and store the handle to a variable.
	Local $hFileOpen = FileOpen($sFilePath, $FO_OVERWRITE)
	If $hFileOpen = -1 Then
		MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
		Return False
	EndIf

	; Write data to the file using the handle returned by FileOpen.
	FileWrite($hFileOpen, "Line 2")
	FileWrite($hFileOpen, "This is still line 2 as a new line wasn't appended to the last FileWrite call." & @CRLF)
	FileWrite($hFileOpen, "Line 3" & @CRLF)
	FileWrite($hFileOpen, "Line 4")

	; Close the handle returned by FileOpen.
	FileClose($hFileOpen)

	; Display the contents of the file passing the filepath to FileRead instead of a handle returned by FileOpen.
	MsgBox($MB_SYSTEMMODAL, "", "Contents of the file:" & @CRLF & FileRead($sFilePath))

	; Delete the temporary file.
	FileDelete($hFileOpen)
	FileClose($hFileOpen)
EndFunc   ;==>Example
