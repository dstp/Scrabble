menu
validePions
	| j cases |
	self modele nbPasses > 1
		ifTrue: [ ^ self modele finDePartie ].
	j := self modele actif.
	cases := self grille casesPionsDe: j.
	cases
		ifEmpty: [ (UIManager default confirm: 'Vous passez votre tour ?')
				ifTrue: [ self modele nbPasses: self modele nbPasses + 1.
					j joueSuite ] ]
		ifNotEmpty: [ (j mesCases: cases)
				ifFalse: [ ^ self ]
				ifTrue: [ | max maxM maxX maxY maxD casesMot |
					casesMot := self grille modele getCasesMot: cases.
					max := self grille modele pointsTotal: j .
					max > 0
						ifTrue: [ maxM := Grille asByteString: casesMot.
							maxX := casesMot first colonne.
							maxY := casesMot first ligne.
							maxD := casesMot first ligne = casesMot last ligne.
							j
								joueFin:
									(Array
										with: max
										with: maxM
										with: maxX
										with: maxY
										with: maxD).
							j joueSuite ] ] ]