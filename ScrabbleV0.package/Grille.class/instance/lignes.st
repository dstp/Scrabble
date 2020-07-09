accessing
lignes
	^ lignes
		ifNil: [ lignes := (1 to: 15)
				collect: [ :idx | self grille select: [ :aC | aC ligne = idx ] ] ]