//%attributes = {"invisible":true,"preemptive":"capable"}
/*
* This method performs content negotiation on the
* Accept HTTP request header if its present.
*
* The first object parameter takes an object:
* MIME-TYPE : FORMULA
* For instance:
* <code>
* {
*     "text/html" : Formula(MethodReturnsText),
*     "application/json" : Formula(MethodReturnsJson),
*     "default" : Formula(MethodReturns406Status)
* }
* </code>
* Then this method look for the mime type that matches 
* with Accept HTTP request header value.
* If one matches, Content-Type header is set to the one found,
* then the corresponding formula is called and
* This of the callee method is set to request object.
* Otherwise default formula is called if it's
* present. If default formula does not present, it
* returns 406 Not Acceptable status.
*
* @param{Object}$1 Object that contains list of acceptable mimetype as key and correspond formula
* @author HARADA Koichi
*/

C_OBJECT:C1216($1;$acceptableMimes_o)

C_COLLECTION:C1488($acceptableMimes_c)
C_OBJECT:C1216($request_o)
C_TEXT:C284($mime_t;$matchMime_t)

$acceptableMimes_o:=$1

  // populate acceptable mimetype list
$acceptableMimes_c:=New collection:C1472()
For each ($mime_t;$acceptableMimes_o)
	
	If (Position:C15("/";$mime_t)>0)
		
		$acceptableMimes_c.push($mime_t)
		
	End if 
	
End for each 

$request_o:=This:C1470.__request__
$matchMime_t:=$request_o.accepts($acceptableMimes_c)

Case of 
	: ($matchMime_t#"")
		
		This:C1470.type($matchMime_t)
		$acceptableMimes_o[$matchMime_t].call(This:C1470)
		
	: ($acceptableMimes_o.default#Null:C1517)
		
		$acceptableMimes_o.default.call(This:C1470)
		
	Else 
		
		This:C1470.sendStatus(406)
		
End case 
