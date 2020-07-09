accessing
nom: aNom
	^ self pions detect: [ :p | p nom = aNom ]