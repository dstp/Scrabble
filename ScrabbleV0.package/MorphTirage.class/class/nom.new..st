accessing
nom: aNom new: aMJeu
	| aT |
	aT := self new
		nom: aNom;
		setBounds;
		jeu: aMJeu.
	^ aT