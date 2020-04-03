//%attributes = {"invisible":true,"preemptive":"capable"}
/**
* This method is used to populate Link HTTP header.
* When multiple element is given, they are joined with
* comma. When it is called multiple times, the latter 
* will be appended to the former.
*
* The first parameter is object type which consists of
* {
*     "rel-value":"uri"
* }
*
* For instance, the following code:
* {@code
*     res.links({
*         "prev":"https://example.com/page/1",
*         "next":"https://example.com/page/3",
*     })
* }
* will populate follow header:
* Link: <https://example.com/page/1>; rel="prev",
* <https://example.com/page/3>; rel="next"
*
* @param {Object} $1 Link header content
* @return {Object} $0 Response object
*/

C_OBJECT:C1216($1;$links_o)
C_OBJECT:C1216($0)

C_TEXT:C284($relKey_t;$uri_t)

$links_o:=$1

For each ($relKey_t;$links_o)
	
	$uri_t:=$links_o[$relKey_t]
	This:C1470.append("Link";"<"+$uri_t+">; rel=\""+$relKey_t+\"")
	
End for each 

$0:=This:C1470
