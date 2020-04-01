//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method sets the specified value to the
* specified HTTP response header field.
* If the header is not already set, it creates
* the field. If it is already present, it is overwritten.
*
* @param {Variant} $1 Field name (Text) or name-value pair (Object)
* @param {Text} $2 Field value when $1 is field name
*/

C_VARIANT:C1683($1)
C_TEXT:C284($2)

C_OBJECT:C1216($headersToSet_o)
C_TEXT:C284($name_t;$value_t)

$type_l:=Value type:C1509($1)

Case of 
	: ($type_l=Is text:K8:3)
		
		$headersToSet_o:=New object:C1471($1;$2)
		
	: ($type_l=Is object:K8:27)
		
		$headersToSet_o:=$1
		
End case 

For each ($name_t;$headersToSet_o)
	
	$value_t:=$headersToSet_o[$name_t]
	
	  // Removes current entry
	$response_o.__headers__:=$response_o.__headers__.query("name != :1";$fieldName_t)
	
	  // Then add new one
	$response_o.__headers__.push(New object:C1471("name";$name_t;"value";$value_t))
	
End for each 
