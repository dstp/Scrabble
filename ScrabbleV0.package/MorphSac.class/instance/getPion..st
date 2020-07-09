tests
getPion: aLet
	"Pour les tests on aura besoin de positionner des pions sur la grille"

	^ self jeu pions
		detect: [ :mp | mp nom = aLet and: [ mp modele owner = self modele ] ] ifNone: [ nil ]