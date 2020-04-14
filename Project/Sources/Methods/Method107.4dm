//%attributes = {}
C_OBJECT:C1216($o)

$o:=new Hmac ("what do ya want for nothing?";"Jefe";SHA512 digest:K66:5)


ALERT:C41($o.hexDigest())
