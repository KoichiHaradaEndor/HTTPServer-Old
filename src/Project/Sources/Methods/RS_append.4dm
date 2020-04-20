//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method appends the specified value to the
* specified HTTP response header field.
* If the header is not already set, it creates
* the field. If it is already present, it is appended
* to the existing value separated by comma ','.
*
* Exception to the above is "Set-Cookie". In this case, 
* another entry will be created. However, to set cookies
* using Response.cookie is preferable.
*
* The value can be either text or collection.
*
* @param {Text} $1 Field name
* @param {Variant} $2 Field value, text or collection
* @return {Object} $0 Response object
* @author HARADA Koichi
*/

C_TEXT:C284($1;$fieldName_t)
C_VARIANT:C1683($2)
C_OBJECT:C1216($0)

C_LONGINT:C283($type_l)
C_TEXT:C284($item_t;$flag_t;$currentValue_t;$appendValue_t)
C_COLLECTION:C1488($queryResult_c)

$fieldName_t:=$1

$type_l:=Value type:C1509($2)

If ($fieldName_t="Set-Cookie")
	
	  // In case of set-cookie, always create another entry.
	$flag_t:="create"
	
Else 
	
	  // In case of not set-cookie, check if its already present
	$queryResult_c:=This:C1470.__headers__.query("name = :1";$fieldName_t)
	If ($queryResult_c.length=0)
		
		  // If the field is not present, create one
		$flag_t:="create"
		
	Else 
		
		  // If the field is present, append the data with comma
		$flag_t:="append"
		
	End if 
	
End if 

Case of 
	: ($flag_t="create")
		
		Case of 
			: ($type_l=Is text:K8:3)
				
				This:C1470.__headers__.push(New object:C1471("name";$fieldName_t;"value";$2))
				
			: ($type_l=Is collection:K8:32)
				
				This:C1470.__headers__.push(New object:C1471("name";$fieldName_t;"value";$2.join(", ")))
				
		End case 
		
	: ($flag_t="append")
		
		  // Each $queryResult_c item is the same reference as the one of This.__headers__
		Case of 
			: ($type_l=Is text:K8:3)
				
				$currentValue_t:=$queryResult_c[0].value
				$queryResult_c[0].value:=$currentValue_t+", "+$2
				
			: ($type_l=Is collection:K8:32)
				
				$currentValue_t:=$queryResult_c[0].value
				$queryResult_c[0].value:=$currentValue_t+", "+$2.join(", ")
				
		End case 
		
End case 

$0:=This:C1470
