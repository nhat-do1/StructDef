var $winRef; $relationType : Integer
var $formData : Object

Case of 
	: (Form:C1466.dropFindRel.currentValue="Many to One")
		$relationType:=1
	: (Form:C1466.dropFindRel.currentValue="One to Many")
		$relationType:=2
	: (Form:C1466.dropFindRel.currentValue="All")
		$relationType:=3
End case 


$formData:={structInst: Form:C1466.structDef; relType: $relationType; tableName: Form:C1466.dropFor.currentValue}


$winRef:=Open form window:C675("Results Relations"; Plain form window:K39:10; Horizontally centered:K39:1)
DIALOG:C40("Results Relations"; $formData)
CLOSE WINDOW:C154($winRef)


