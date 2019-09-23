#include <Array.au3>
#include <MsgBoxConstants.au3>

; Multi-Dimensional maps are just maps in a map

Local $mMapOfMapsvilla[] ; This map will store an other map
Local $mMapOfMapsvilla2[] ; This map will store an other map

Local $mParkMap[] ; This Park map will be inserted in the Mapsvilla's map :P

$mMapOfMapsvilla["asdf"] = "Town Hall"
$mMapOfMapsvilla["Map Item 2"] = "Police Station"
$mMapOfMapsvilla["Map Item 3"] = "Shopping Mall"
$mMapOfMapsvilla[42] = "Residential Area"
$mMapOfMapsvilla.Park = "werner"


Local $keys = $mMapOfMapsvilla.keys()
_ArrayDisplay($keys)
MsgBox($MB_OK, "", UBound($mMapOfMapsvilla.keys()))
MsgBox($MB_OK, "", UBound($mMapOfMapsvilla))

$mParkMap["asdf"] = "Cottan Candy Stand"
$mParkMap["Map Item 2"] = "Public Toilet"
$mParkMap["Map Item 3"] = "Woods"

;~ $mMapOfMapsvilla.Park = $mParkMap

;~ MsgBox($MB_OK, "Map Location", $mMapOfMapsvilla.asdf) ; Will display Town Hall
;~ MsgBox($MB_OK, "Map Location", $mMapOfMapsvilla) ; Will display Cottan Candy Stand

Global $testdict = ObjCreate("Scripting.Dictionary")
$testdict.Item("akk") = "sifte"
ConsoleWrite($testdict.Item("akk") & @CRLF)

