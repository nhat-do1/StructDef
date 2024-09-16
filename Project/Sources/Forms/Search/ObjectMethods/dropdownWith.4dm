
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		Case of 
			: (Form:C1466.dropFind.currentValue="Tables")
				If (Form:C1466.structDef.validTableProps[Form:C1466.dropWith.currentValue]=6)  // Boolean
					OBJECT SET VISIBLE:C603(*; "inputValue"; False:C215)
					OBJECT SET VISIBLE:C603(*; "dropdownValue"; True:C214)
					Form:C1466.inputValue:=""
				Else   // Text
					OBJECT SET VISIBLE:C603(*; "inputValue"; True:C214)
					OBJECT SET VISIBLE:C603(*; "dropdownValue"; False:C215)
				End if 
				
			: (Form:C1466.dropFind.currentValue="Fields")
				// Boolean or limited values
				If ((Form:C1466.structDef.validFieldProps[Form:C1466.dropWith.currentValue]=6) | (Form:C1466.dropWith.currentValue="index") | (Form:C1466.dropWith.currentValue="storage") | (Form:C1466.dropWith.currentValue="type"))
					
					Case of 
						: (Form:C1466.dropWith.currentValue="index")
							Form:C1466.dropValue:={values: ["Automatic"; "Cluster B-tree"; "B-tree"; ""]; index: -1; currentValue: "Automatic"}
						: (Form:C1466.dropWith.currentValue="storage")
							Form:C1466.dropValue:={values: ["In data file"; "Outside data file"; "In Record / In data file"; "In record"; ""]; index: -1; currentValue: "In data file"}
						: (Form:C1466.dropWith.currentValue="type")
							Form:C1466.dropValue:={values: ["Alpha"; "Blob"; "Boolean"; "Date"; "Picture"; "Integer"; "Object"; "Real Number"; "Text"; "Time"]; index: -1; currentValue: "Alpha"}
						Else 
							Form:C1466.dropValue:={values: [True:C214; False:C215]; index: -1; currentValue: True:C214}
					End case 
					
					OBJECT SET VISIBLE:C603(*; "inputValue"; False:C215)
					OBJECT SET VISIBLE:C603(*; "dropdownValue"; True:C214)
					Form:C1466.inputValue:=""
				Else   // Text
					OBJECT SET VISIBLE:C603(*; "inputValue"; True:C214)
					OBJECT SET VISIBLE:C603(*; "dropdownValue"; False:C215)
				End if 
				
		End case 
		
End case 
