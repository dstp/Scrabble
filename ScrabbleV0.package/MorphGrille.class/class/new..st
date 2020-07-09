instance creation
new: aMJeu
	| aG |
	aG := self new.
	aG jeu: aMJeu.
	aG modele: aMJeu modele grille.
	aMJeu modele grille morph: aG.
	aG initializeCases.
	^ aG