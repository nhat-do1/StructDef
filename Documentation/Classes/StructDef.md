# StructDef

```
$myStructDef:=cs.StructTool.StructDef.new()
$tables:=$myStructDef.struct.tables
$fields:=$myStructDef.struct.fields
```

## findTables 
Input: (1) Table property or trigger [TEXT]; (2) Value to find [VARIANT]. \
Output: [COLLECTION] of tables; each table [OBJECT] has property matching value.

```
$prop:="encryptable"
$val:=True
$encrypTables:=$myStructDef.findTables($prop; $val)
```
### Table Properties
| Name      | Description | Type of Value |
| ----------- | ----------- | ----------- |
| name      | Name of table.<sup>P</sup>  | Text       |
| primaryKey   | Name of primary key.<sup>P</sup> | Text      |
| comment   | Comments for table.<sup>P</sup>  | Text      |
| encryptable      | Table data is set as Encryptable.  | Boolean       |
| exposedREST   | Table is exposed in context of REST requests.        | Boolean      |
| includedInLogFile   | Table data operations are included in log file.        | Boolean      |              
| invisible     | Tables is set as Invisible.       | Boolean       |
| recordDefDeleted   | Table records are definitively deleted.      | Boolean      |  
| onInsert   | Trigger enabled on saving new record.        | Boolean      |
| onDelete   | Trigger enabled on deleting record.         | Boolean      |   
| onUpdate   | Trigger enabled on saving existing record.         | Boolean      |    

<sup>P</sup> = Finds partial matching of text value.

## findFields
Input: (1) Field property [TEXT]; (2) Value to find [VARIANT]. \
Output: [COLLECTION] of fields; each field [OBJECT] has property matching value.

```
$prop:="storage"
$val:="Outside data file"
$outsideDataFields:=$myStructDef.findFields($prop; $val)
```
### Field Properties
| Name      | Description | Type of Value |
| ----------- | ----------- | ----------- |
| fieldName      | Name of field.<sup>P</sup>  | Text       |
| tableName   | Name of field's table.<sup>P</sup> | Text      |
| comment   | Comments for field.<sup>P</sup>  | Text      |
| type      | Field data type ("Alpha", "Blob", "Boolean", "Date", "Picture", "Integer", "Object", "Real Number", "Text", or "Time").  | Text       |
| index   | Type of field indexing, if any ("Automatic", "Cluster B-tree", "B-tree", or "").        | Text      |
| storage   | Storage location of field data ("In data file", "Outside data file", "In Record / In data file", "In record", or ""). | Text      |              
| maxLength     | Maximum length of data (e.g., "20"; empty value if not Alpha type).       | Text       |
| autoIncrement   | Field is automatically incremented.      | Boolean      |  
| autoUUID   | UUID is automatically generated in field.        | Boolean      |
| exposedREST   | Field is exposed in context of REST request.         | Boolean      |   
| formatUUID   | Field stores UUID identifiers.          | Boolean      |    
| invisible   | Field is set as Invisible.          | Boolean      |  
| keywordIndex   | Field is indexed by keyword.          | Boolean      |  
| neverNull   | "Map NULL values to blank values" is enabled.        | Boolean      |   
| notNull   | "Reject NULL value input" is enabled.        | Boolean      |    
| queriesAndSortsWithoutTags   | Queries/sorts in field data do not take into account any style tags.  | Boolean      |  
| unique   | Field is set as Unique.          | Boolean      |  

<sup>P</sup> = Finds partial matching of text value. 


## findRelations
Input: (1) Table name [TEXT]; (2) Relation type [INTEGER] (1 = Many to One, 2 = One to Many, 3 = All). \
Output: Relations [COLLECTION] of table; each relation [OBJECT] falls under relation type.

```
$table:="Employees"
$type:=1
$NtoOneRelations:=$myStructDef.findRelations($table; $type)
```