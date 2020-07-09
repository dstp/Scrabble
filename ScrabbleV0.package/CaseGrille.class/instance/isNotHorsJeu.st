testing
isNotHorsJeu
	"une case en dehors de la grille"

	^ (self ligne between: 1 and: 15) and: [ self colonne between: 1 and: 15  ]