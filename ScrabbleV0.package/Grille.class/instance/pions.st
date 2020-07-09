accessing
pions
	^ self jeu pions select: [ :p | p owner = self ]