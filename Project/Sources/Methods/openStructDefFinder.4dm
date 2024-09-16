//%attributes = {"shared":true}
var $winRef : Integer

$winRef:=Open form window:C675("Search"; Plain form window:K39:10; Horizontally centered:K39:1; At the top:K39:5)
DIALOG:C40("Search")
CLOSE WINDOW:C154($winRef)