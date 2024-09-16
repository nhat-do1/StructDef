//%attributes = {}
#DECLARE()->$structObj : Object
var $src; $str; $prop; $val; $typeText : Text
var $tablesColl; $fieldsColl; $coll; $typeTextColl : Collection
var $posA; $posB; $i; $shift; $numFields; $n : Integer
var $tableObj; $fieldObj; $fieldObjCopy; $relObj : Object


EXPORT STRUCTURE:C1311($src; html format:K94:2)

$tablesColl:=[]
$fieldsColl:=[]

$posB:=0

Repeat 
	$tableObj:={}
	
	// TABLE INFO
	$tableObj.tableInfo:={}
	$posA:=Position:C15("[ - ]"; $src; $posB)+8
	$posB:=Position:C15("</p>"; $src; $posA)
	$str:=Substring:C12($src; $posA; $posB-$posA)
	$tableObj.tableInfo.name:=$str
	
	For ($i; 1; 7)
		Case of 
			: ($i=1)
				$prop:="primaryKey"
				$shift:=5
				$val:="text"
				
			: ($i=2)
				$prop:="invisible"
				$shift:=5
				$val:="bool"
				
			: ($i=3)
				$prop:="exposedREST"
				$shift:=5
				$val:="bool"
				
			: ($i=4)
				$prop:="recordDefDeleted"
				$shift:=5
				$val:="bool"
				
			: ($i=5)
				$prop:="encryptable"
				$shift:=5
				$val:="bool"
				
			: ($i=6)
				$prop:="includedInLogFile"
				$shift:=5
				$val:="bool"
				
			: ($i=7)
				$prop:="comment"
				$shift:=6
				$val:="text"
		End case 
		
		$posA:=Position:C15("<td>"; $src; $posB)+$shift
		$posB:=Position:C15("</td>"; $src; $posA)-1
		$str:=Substring:C12($src; $posA; $posB-$posA)
		
		Case of 
			: ($val="text")
				$tableObj.tableInfo[$prop]:=$str
			: ($val="bool")
				$tableObj.tableInfo[$prop]:=$str=" " ? False:C215 : True:C214
		End case 
	End for 
	
	// TRIGGERS
	$tableObj.triggers:={}
	
	For ($i; 1; 3)
		Case of 
			: ($i=1)
				$prop:="onInsert"
			: ($i=2)
				$prop:="onUpdate"
			: ($i=3)
				$prop:="onDelete"
		End case 
		
		$posA:=Position:C15("<td>"; $src; $posB)+5
		$posB:=Position:C15("</td>"; $src; $posA)-1
		$str:=Substring:C12($src; $posA; $posB-$posA)
		$tableObj.triggers[$prop]:=$str=" " ? False:C215 : True:C214
	End for 
	
	// FIELDS
	$tableObj.fields:=[]
	$posA:=Position:C15("<h2>Table"; $src; $posB)+11
	$posB:=Position:C15(")</h2>"; $src; $posA)
	$numFields:=Num:C11(Split string:C1554(Substring:C12($src; $posA; $posB-$posA); " ")[0])
	
	For ($n; 1; $numFields)
		$fieldObj:={}
		
		For ($i; 1; 15)
			Case of 
				: ($i=1)
					$prop:="fieldName"
					$shift:=5
					$val:="text"
					
				: ($i=2)
					$prop:="type"
					$shift:=5
					$val:="img"
					
				: ($i=3)
					$prop:="autoIncrement"
					$shift:=5
					$val:="bool"
					
				: ($i=4)
					$prop:="formatUUID"
					$shift:=5
					$val:="bool"
					
				: ($i=5)
					$prop:="autoUUID"
					$shift:=5
					$val:="bool"
					
				: ($i=6)
					$prop:="index"
					$shift:=5
					$val:="text"
					
				: ($i=7)
					$prop:="keywordIndex"
					$shift:=5
					$val:="bool"
					
				: ($i=8)
					$prop:="unique"
					$shift:=5
					$val:="bool"
					
				: ($i=9)
					$prop:="exposedREST"
					$shift:=5
					$val:="bool"
					
				: ($i=10)
					$prop:="notNull"
					$shift:=5
					$val:="bool"
					
				: ($i=11)
					$prop:="neverNull"
					$shift:=5
					$val:="bool"
					
				: ($i=12)
					$prop:="invisible"
					$shift:=5
					$val:="bool"
					
				: ($i=13)
					$prop:="storage"
					$shift:=5
					$val:="text"
					
				: ($i=14)
					$prop:="queriesAndSortsWithoutTags"
					$shift:=5
					$val:="bool"
					
				: ($i=15)
					$prop:="comment"
					$shift:=6
					$val:="text"
			End case 
			
			$posA:=Position:C15("<td>"; $src; $posB)+$shift
			$posB:=Position:C15("</td>"; $src; $posA)-1
			$str:=Substring:C12($src; $posA; $posB-$posA)
			
			Case of 
				: ($val="text")
					$fieldObj[$prop]:=$str=" " ? "" : $str
					
				: ($val="img")
					$coll:=Split string:C1554($str; "> "; sk trim spaces:K86:2)
					$typeText:=$coll.last()
					$typeTextColl:=Split string:C1554($typeText; " ")
					If (($typeTextColl.length>1) & ($typeTextColl[0]="Alpha"))  // "Alpha 20"
						$fieldObj[$prop]:=$typeTextColl[0]
						$fieldObj.maxLength:=$typeTextColl[1]
					Else 
						$fieldObj[$prop]:=$typeText="Hour" ? "Time" : $typeText="Image" ? "Picture" : $typeText
					End if 
					
				: ($val="bool")
					$fieldObj[$prop]:=$str=" " ? False:C215 : True:C214
			End case 
		End for 
		
		$tableObj.fields.push($fieldObj)
		$fieldObjCopy:=OB Copy:C1225($fieldObj)
		$fieldObjCopy.tableName:=$tableObj.tableInfo.name
		$fieldsColl.push($fieldObjCopy)
	End for 
	
	// RELATIONS
	$tableObj.manyToOne:=[]
	
	Repeat 
		$relObj:={}
		
		For ($i; 1; 3)
			
			Case of 
				: ($i=1)
					$prop:="from"
					
				: ($i=2)
					$prop:="to"
					
				: ($i=3)
					$prop:="name"
			End case 
			
			$posA:=Position:C15("<td>"; $src; $posB)+4
			$posB:=Position:C15("</td>"; $src; $posA)
			$str:=Substring:C12($src; $posA; $posB-$posA)
			
			$relObj[$prop]:=$str=" " ? "" : $str
			
		End for 
		
		If ($relObj.name#"")
			$tableObj.manyToOne.push($relObj)
		End if 
		
	Until (Substring:C12($src; $posB+14; 8)="</table>")
	
	$tableObj.oneToMany:=[]
	
	Repeat 
		$relObj:={}
		
		For ($i; 1; 3)
			
			Case of 
				: ($i=1)
					$prop:="from"
					
				: ($i=2)
					$prop:="to"
					
				: ($i=3)
					$prop:="name"
			End case 
			
			$posA:=Position:C15("<td>"; $src; $posB)+4
			$posB:=Position:C15("</td>"; $src; $posA)
			$str:=Substring:C12($src; $posA; $posB-$posA)
			
			$relObj[$prop]:=$str=" " ? "" : $str
			
		End for 
		
		If ($relObj.name#"")
			$tableObj.oneToMany.push($relObj)
		End if 
		
	Until (Substring:C12($src; $posB+14; 8)="</table>")
	
	$tablesColl.push($tableObj)
Until (Position:C15("[ - ]"; $src; $posB)=0)

$structObj:={tables: $tablesColl; fields: $fieldsColl}