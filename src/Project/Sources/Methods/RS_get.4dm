//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method returns HTTP response header value
* specified by response header field name.
*
* It returns text type value except when the header
* field name is "Set-Cookie". In this case it returns
* Collection, even though only one "Set-Cookie" header
* resides.
*
* If specified header is not found, it returns empty string or collection.
*
* @param {Text} $1 Field name
* @return {Variant} $0 Header field value (Text or Collection)
* @author HARADA Koichi
*/

C_TEXT:C284($1;$headerName_t)
C_VARIANT:C1683($0)

C_TEXT:C284($headerValue_t)
C_COLLECTION:C1488($queryResult_c)

$headerName_t:=$1

$queryResult_c:=This:C1470.__headers__.query("name = :1";$headerName_t)

Case of 
	: ($headerName_t="Set-Cookie")
		
		If ($queryResult_c.length=0)
			
			$0:=New collection:C1472()
			
		Else 
			
			$0:=$queryResult_c.extract("value")
			
		End if 
		
	Else 
		
		If ($queryResult_c.length=0)
			
			$0:=""
			
		Else 
			
			$0:=$queryResult_c[0].value
			
		End if 
		
End case 
