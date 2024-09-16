var $winRef; $valueType : Integer
var $formData : Object
var $structureInstance : cs:C1710.StructDef
var $concernType; $propertyToSearch : Text
var $valueToSearch : Variant

$structureInstance:=Form:C1466.structDef
$concernType:=Form:C1466.dropFind.currentValue
$propertyToSearch:=Form:C1466.dropWith.currentValue
$valueType:=$concernType="Tables" ? $structureInstance.validTableProps[$propertyToSearch] : $structureInstance.validFieldProps[$propertyToSearch]
$valueToSearch:=(($valueType=6) | ($propertyToSearch="index") | ($propertyToSearch="storage") | ($propertyToSearch="type")) ? Form:C1466.dropValue.currentValue : Form:C1466.inputValue

$formData:={structInst: $structureInstance; searchProp: $propertyToSearch; searchVal: $valueToSearch}


Case of 
	: ($concernType="Tables")
		$winRef:=Open form window:C675("Results Tables"; Plain form window:K39:10; Horizontally centered:K39:1)
		DIALOG:C40("Results Tables"; $formData)
		CLOSE WINDOW:C154($winRef)
		
	: ($concernType="Fields")
		$winRef:=Open form window:C675("Results Fields"; Plain form window:K39:10; Horizontally centered:K39:1)
		DIALOG:C40("Results Fields"; $formData)
		CLOSE WINDOW:C154($winRef)
End case 

