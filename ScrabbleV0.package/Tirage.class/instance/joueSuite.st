automate
joueSuite
	^ ((Scrabble asByteString: self pions) isEmpty or: [ self jeu nbPasses > 1 ])
		ifTrue: [ self jeu finDePartie ]
		ifFalse: [ self jeu actif: self jeu actif suivant.
			self jeu actif joue ]