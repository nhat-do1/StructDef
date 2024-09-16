
Case of 
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.resTables:=Form:C1466.structInst.findTables(Form:C1466.searchProp; Form:C1466.searchVal)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		var $fields : Collection
		var $tableName : Text
		var $formData : Object
		var $winRef : Integer
		
		$fields:=Form:C1466.currentItem.fields
		$tableName:=Form:C1466.currentItem.tableInfo.name
		
		$formData:={fields: $fields; tableName: $tableName}
		
		$winRef:=Open form window:C675("Fields"; Plain form window:K39:10; Horizontally centered:K39:1)
		DIALOG:C40("Fields"; $formData)
		CLOSE WINDOW:C154($winRef)
End case 
