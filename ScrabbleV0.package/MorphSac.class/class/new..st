instance creation
new: aMJeu
	| aSac |
	aSac := self new.
	aSac jeu: aMJeu.
	aSac modele: aMJeu modele sac.
	aMJeu modele sac morph: aSac.
	^ aSac