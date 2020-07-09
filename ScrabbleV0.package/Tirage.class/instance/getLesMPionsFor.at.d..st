automate
getLesMPionsFor: unMot at: aPoint d: aBool
	"
	retourne les cases de la grille et les pions du joueur
	Array with: casesO with: pionsO
	"

	| aCase idx	"infinite" casesO pionsO cases |
	
	cases := OrderedCollection new.
	casesO := OrderedCollection new.
	pionsO := OrderedCollection new.
	idx := 1.
	"infinite := 1."
	aCase := self jeu grille atPoint: aPoint.
	[ true ]
		whileTrue: [ | aStr |
			"infinite := infinite + 1.
			infinite > 50
				ifTrue: [ UIManager default abort: 'Je boucle' ]."
			aCase isHorsJeu
				ifTrue: [ ^ Array new ].
			aCase isNotEmpty
				ifTrue: [ aCase pion lettre ~= (unMot at: idx) asString
						ifTrue: [ ^ Array new ]
						ifFalse: [ idx := idx + 1.
							idx > unMot size
								ifTrue: [ ^ Array with: casesO with: pionsO ]
								ifFalse: [ aCase := aBool
										ifTrue: [ aCase d ]
										ifFalse: [ aCase b ] ] ] ]
				ifFalse: [ | casePion |
					aStr := (unMot at: idx) asString.
					casePion := self getCasePionFor: aStr hors: cases.
					casePion
						ifNotNil: [ casesO add: aCase.
							pionsO add: casePion pion.
							cases add: casePion.
							idx := idx + 1.
							idx > unMot size
								ifTrue: [ ^ Array with: casesO with: pionsO ]
								ifFalse: [ aCase := aBool
										ifTrue: [ aCase d ]
										ifFalse: [ aCase b ] ] ]
						ifNil: [ ^ Array new ] ] ]