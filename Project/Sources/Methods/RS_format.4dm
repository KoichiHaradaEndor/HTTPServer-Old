//%attributes = {}
/*
* This method performs content negotiation on the
* Accept HTTP request header if its present.
*
* The first object parameter takes
* MIME-TYPE : FORMULA
* element. For instance:
* <code>
* {
*     "text/html" : Formula(MethodReturnsText),
*     "application/json" : Formula(MethodReturnsJson),
*     "default" : Formula(MethodReturns406Status)
* }
* </code>
* Then this method look for the mime type that matches 
* with Accept HTTP request header value.
* If one is found, the correspond formula is called, 
* otherwise default formula is called if it's
* present. The formula takes two parameters which are
* Request, Response object.
*
* When Accept HTTP request header value
* look like this:
* Accept: text/html, application/xhtml+xml, application/xml;q=0.9, * / *;q=0.8
* Then text/html
*
* @param{Object}$1 Object that contains list of 
*/

