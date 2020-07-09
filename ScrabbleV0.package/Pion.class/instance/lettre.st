accessing
lettre
	^ self valeur = 0
		ifTrue: [ self jocker ]
		ifFalse: [ lettre ]