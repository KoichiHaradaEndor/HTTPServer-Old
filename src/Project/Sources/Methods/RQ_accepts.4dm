//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method checks if the specified content types are acceptable,
* based on the request's Accept HTTP header field. The method
* returns the best match, or none of the spwcified content types is
* acceptable, returns empty string. In this case, the app should
* return 406 Not Acceptable.
*
* ex:
* Accept: text/html;q=.5, application/json
* mimetype list: ["application/json"; "text/html"]
* Then application/json is returned because it has high prority.
*/

C_VARIANT:C1683($1)
C_TEXT:C284($0;$matchedMimeType_t)

C_LONGINT:C283($type_l)
C_COLLECTION:C1488($candidates_c;$queryResult_c;$items_c;$parts_c;$acceptList_c)
C_TEXT:C284($accept_t;$item_t;$pattern_t)
C_REAL:C285($priority_r)
C_OBJECT:C1216($item_o)

$matchedMimeType_t:=""

$type_l:=Value type:C1509($1)

Case of 
	: ($type_l=Is text:K8:3)
		
		$candidates_c:=New collection:C1472($1)
		
	: ($type_l=Is collection:K8:32)
		
		$candidates_c:=$1
		
End case 

  // construct Accept header collection
$queryResult_c:=This:C1470.__headers__.query("name = :1";"Accept")
If ($queryResult_c.length>0)
	
	  // $accept_t: something like text/*;q=.5, application/json
	$accept_t:=$queryResult_c[0].value
	
	  // $items_c: ["text/*;q=.5"; "application/json"]
	$items_c:=Split string:C1554($accept_t;",";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	$acceptList_c:=New collection:C1472()
	For each ($item_t;$items_c)
		
		  // $item_t: "text/*;q=.5"
		  // $parts_c: ["text/*"; "q=.5"] or [application/json]
		$parts_c:=Split string:C1554($item_t;";";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
		Case of 
			: ($parts_c.length=1)
				
				$priority_r:=1
				$pattern_t:=Replace string:C233($parts_c[0];"*";"@")
				$acceptList_c.push(New object:C1471("mimetype";$parts_c[0];"priority";$priority_r;"pattern";$pattern_t))
				
			: ($parts_c.length=2)
				
				$priority_r:=Num:C11($parts_c[1])
				$pattern_t:=Replace string:C233($parts_c[0];"*";"@")
				$acceptList_c.push(New object:C1471("mimetype";$parts_c[0];"priority";$priority_r;"pattern";$pattern_t))
				
		End case 
		
	End for each 
	
	  // sort by priority, when priority is the same value, more precise item has priority
	$acceptList_c.sort("RQ_sortAccept")
	
	  // then execute query
	For each ($item_o;$acceptList_c) Until ($matchedMimeType_t#"")
		
		$pattern_t:=$item_o.pattern
		$matchedMimeType_t:=$candidates_c.find("RQ_findAccept";$pattern_t)
		
	End for each 
	
End if 

$0:=$matchedMimeType_t
