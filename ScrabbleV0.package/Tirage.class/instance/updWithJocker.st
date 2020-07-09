accessing
updWithJocker
	(self pions select: [ :p | p isJocker ]) size = 1
		ifTrue: [ withJocker := false ] .
	^ self