
Case of 
	: (Form event code:C388=On Load:K2:1)
		var $tables; $tableNames : Collection
		
		Form:C1466.structDef:=cs:C1710.StructDef.new()
		Form:C1466.dropFind:={values: ["Tables"; "Fields"]; index: -1; currentValue: "Tables"}
		Form:C1466.dropWith:={values: OB Keys:C1719(Form:C1466.structDef.validTableProps); index: -1; currentValue: "name"}
		Form:C1466.dropValue:={values: [True:C214; False:C215]; index: -1; currentValue: True:C214}
		OBJECT SET VISIBLE:C603(*; "dropdownValue"; False:C215)
		
		Form:C1466.dropFindRel:={values: ["Many to One"; "One to Many"; "All"]; index: -1; currentValue: "Many to One"}
		
		$tables:=Form:C1466.structDef.struct.tables
		$tableNames:=$tables.map(Formula:C1597($1.value.tableInfo.name))
		Form:C1466.dropFor:={values: $tableNames; index: -1; currentValue: $tableNames.first()}
End case 