//%attributes = {"invisible":true}
/*
* Request object may contain:
*
* <h3>Request.body</h3>
* Contains object type key-value pairs or collection that was
* submitted in request body. By defualt, it is undefined,
* and is populated when the request's Content-Type header
* value is either application/x-www-form-urlencoded or
* application/json.
* Note that each value is a collection type since there may be
* duplicate "name" entry.
*
* <h3>Request.cookies</h3>
* This property is a object that contains cookies sent in the
* request header. The structure of the object is:
*     {
*         "cookieName" : "cookieValue", ...
*     }
* If no cookies are sent, it defaults to {}.
*
* <h3>Request.hostname</h3>
* Contains hostname derived from the Host HTTP header.
*
* <h3>Request.method</h3>
* Contains HTTP method of the request.
*
* <h3>Request.path</h3>
* Contains the path part of the request URI.
*
* <h3>Request.protocol</h3>
* Contains the request protocol, either "http" or "https".
*
*
*/
