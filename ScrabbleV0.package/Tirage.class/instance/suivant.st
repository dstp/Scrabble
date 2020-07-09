accessing
suivant
	^ self jeu robot = self
				ifTrue: [ ^ self jeu joueur  ]
				ifFalse: [ ^ self jeu robot  ] 