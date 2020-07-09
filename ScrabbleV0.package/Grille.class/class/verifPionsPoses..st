basic tests
verifPionsPoses: casesMot
	"
	je vérifie si le mot existe
	"
	^ casesMot isEmpty
		ifTrue: [ false ]
		ifFalse: [ Scrabble existeMot: (self asByteString: casesMot) ]