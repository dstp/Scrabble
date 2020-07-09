basic tests
verifPionsPoses: casesMot info: aBool
	"
	je vérifie si le mot existe, aBool provoque l'affichage d'un message d'erreur
	"
	^ casesMot isEmpty
		ifTrue: [ false ]
		ifFalse: [ (Scrabble existeMot: (self asByteString: casesMot))
				ifFalse: [ aBool
						ifTrue: [ UIManager default
								abort: (self asByteString: casesMot) , ' inconnu dans le dictionnaire' ].
					false ]
				ifTrue: [ true ] ]