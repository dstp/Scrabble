accessing
casesO
	"
	je retourne les cases de ma grille occupées par un pion (un de mes pions ou un pion en cours de jeu)
	"
	^ self grille select: [ :aC | aC etat = 'O' ]