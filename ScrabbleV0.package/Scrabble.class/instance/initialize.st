initialization
initialize
	grille := Grille new jeu: self.
	sac := Sac new jeu: self.
	joueur := Tirage new jeu: self.
	joueur nom: 'Joueur'.
	robot := Tirage new jeu: self.
	robot nom: 'Robot'.
	pions := Pion getPions.
	sac initializePions