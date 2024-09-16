
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		Case of 
			: (Form:C1466.dropFind.currentValue="Tables")
				Form:C1466.dropWith:={values: OB Keys:C1719(Form:C1466.structDef.validTableProps); index: -1; currentValue: "name"}
				Form:C1466.dropValue:={values: [True:C214; False:C215]; index: -1; currentValue: True:C214}
				
				OBJECT SET VISIBLE:C603(*; "inputValue"; True:C214)
				OBJECT SET VISIBLE:C603(*; "dropdownValue"; False:C215)
				
			: (Form:C1466.dropFind.currentValue="Fields")
				Form:C1466.dropWith:={values: OB Keys:C1719(Form:C1466.structDef.validFieldProps); index: -1; currentValue: "fieldName"}
				OBJECT SET VISIBLE:C603(*; "inputValue"; True:C214)
				OBJECT SET VISIBLE:C603(*; "dropdownValue"; False:C215)
				
		End case 
		
End case 
