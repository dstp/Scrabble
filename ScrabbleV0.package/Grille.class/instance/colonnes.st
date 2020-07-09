accessing
colonnes
	^ colonnes
		ifNil: [ colonnes := (1 to: 15)
				collect: [ :idx | self grille select: [ :aC | aC colonne = idx ] ] ]