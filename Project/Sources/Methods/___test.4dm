//%attributes = {}
C_OBJECT:C1216($formula)

Use (Storage:C1525)
	
	Storage:C1525.formulas:=New shared collection:C1527
	
	Use (Storage:C1525.formulas)
		
		Storage:C1525.formulas.push(New shared object:C1526())
		Storage:C1525.formulas[Storage:C1525.formulas.length-1].text:="aaa"
		Storage:C1525.formulas[Storage:C1525.formulas.length-1].rs_get:=Formula:C1597(RS_get )
		
	End use 
	
End use 
