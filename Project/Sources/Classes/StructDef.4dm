Class constructor
	This:C1470.struct:=parseStructDefHTML
	// for param error checking: { property name : value type }
	This:C1470.validTableProps:={name: 2; primaryKey: 2; comment: 2; encryptable: 6; exposedREST: 6; includedInLogFile: 6; invisible: 6; recordDefDeleted: 6; onInsert: 6; onDelete: 6; onUpdate: 6}
	This:C1470.validFieldProps:={fieldName: 2; tableName: 2; type: 2; index: 2; comment: 2; storage: 2; maxLength: 2; autoIncrement: 6; autoUUID: 6; exposedREST: 6; formatUUID: 6; invisible: 6; keywordIndex: 6; neverNull: 6; notNull: 6; queriesAndSortsWithoutTags: 6; unique: 6}
	
Function findTables($prop : Text; $val : Variant) : Variant
	var $tablesFound; $tablesColl : Collection
	var $tableObj : Object
	var $matchVal : Variant
	
	
	If (This:C1470.validTableProps[$prop]#Null:C1517)
		If (Value type:C1509($val)=This:C1470.validTableProps[$prop])
			$tablesFound:=[]
			$tablesColl:=This:C1470.struct.tables
			
			For each ($tableObj; $tablesColl)
				If (($prop="onInsert") | ($prop="onDelete") | ($prop="onUpdate"))
					If ($tableObj.triggers[$prop]=$val)
						$tablesFound.push($tableObj)
					End if 
				Else 
					If (This:C1470.validTableProps[$prop]=2)
						// search text partial match
						$matchVal:="@"+$val+"@"
					Else 
						$matchVal:=$val
					End if 
					
					If ($tableObj.tableInfo[$prop]=$matchVal)
						$tablesFound.push($tableObj)
					End if 
					
				End if 
			End for each 
			
			return $tablesFound
		Else 
			
			return "Invalid value type."
		End if 
		
	Else 
		
		return "Invalid property or trigger."
	End if 
	
	
Function findFields($prop : Text; $val : Variant) : Variant
	var $fieldsFound; $fieldsColl : Collection
	var $fieldObj : Object
	var $matchVal : Variant
	
	If (This:C1470.validFieldProps[$prop]#Null:C1517)
		If (Value type:C1509($val)=This:C1470.validFieldProps[$prop])
			$fieldsFound:=[]
			$fieldsColl:=This:C1470.struct.fields
			
			For each ($fieldObj; $fieldsColl)
				If (($prop="fieldName") | ($prop="tableName") | ($prop="comment"))
					// search text partial match
					$matchVal:="@"+$val+"@"
				Else 
					$matchVal:=$val
				End if 
				
				If ($fieldObj[$prop]=$matchVal)
					$fieldsFound.push($fieldObj)
				End if 
			End for each 
			
			return $fieldsFound
		Else 
			
			return "Invalid value type."
		End if 
		
	Else 
		
		return "Invalid property."
	End if 
	
	
Function findRelations($tableName : Text; $relType : Integer) : Variant
	var $tableObj : Object
	
	$tableObj:=This:C1470.struct.tables.find(Formula:C1597($1.value.tableInfo.name=$2); $tableName)
	
	If ($tableObj=Null:C1517)
		return "Table not found."
	Else 
		
		Case of 
			: ($relType=1)  // N-to-1
				return $tableObj.manyToOne
				
			: ($relType=2)  // 1-to-N
				return $tableObj.oneToMany
				
			: ($relType=3)  // all
				return $tableObj.manyToOne.concat($tableObj.oneToMany)
			Else 
				return "Invalid parameter."
		End case 
		
	End if 
	
	
	