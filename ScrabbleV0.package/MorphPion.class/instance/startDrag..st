event handling
startDrag: anEvent
	self modele owner = self owner owner jeu modele actif
		ifFalse: [ ^ nil ].
	self modele valeur = 0
		ifTrue: [ self modele jocker: ' '.
			self faceJ: nil.
			self showFace ].
	anEvent hand grabMorph: self.
	super startDrag: anEvent