#include 'protheus.ch'
#include 'topconn.ch'

CLASS FWCORM

	METHOD Create() CONSTRUCTOR
	METHOD Seek() //msseek
	METHOD GetField() // posicione
	METHOD SetField() // insert/update

ENDCLASS

METHOD Create() CLASS FWCORM

Return SELF

METHOD Seek(cAlias,cSeek,nIndex) CLASS FWCORM

	Local bError := {||}
	Local lRet := .F.

	Default cAlias := ""
	Default cSeek := ""
	Default nIndex := 1

	// Necessário tratamento por meio do Begin Sequence
	// pois nem sempre o objeto/array _REMNANT existirá dentro de oXML
	bError := ErrorBlock( {|oError| GetError(oError)})
	BEGIN SEQUENCE

		DbSelectArea(cAlias)
		(cAlias)->(DbSetOrder(nIndex))
		(cAlias)->(MsSeek(xFilial(cAlias)+cSeek))

	END SEQUENCE
	ErrorBlock(bError) // restaura tratamento de erro PadRão do sistema

Return lRet

Static Function GetEror()
	Break
Return()