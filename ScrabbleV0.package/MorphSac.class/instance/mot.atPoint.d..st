tests
mot: aMot atPoint: aPoint d: aBool
	"Pour les tests on aura besoin de positionner des mots sur la grille"

	| aMPion aCase aDict |
	aDict := Dictionary new.
	aCase := self jeu grille modele atPoint: aPoint.
	aMot
		do: [ :aChar | 
			(aCase isHorsJeu or: [ aCase isNotEmpty ])
				ifTrue: [ UIManager default inform: 'Case indisponible'.
					^ self ].
			aMPion := self getPion: aChar asString.
			aMPion
				ifNotNil: [ 
					aDict at: aCase put: aMPion.
					aCase := aBool
						ifTrue: [ aCase d ]
						ifFalse: [ aCase b ] ]
				ifNil: [ UIManager inform: 'Pion indisponible'.
					^ self ] ].
	aDict associationsDo: [  :ass | 
		ass value modele owner: ass key whereIs.
		ass key morph addMorph: ass value 
		]