accessing
casesAutourO
	"
	je retourne les cases qui touchent verticalement/horizontalement les cases occupées par mes pions
	si aucune case je retourne la case centrale 
	"

	^ (self grille
		select: [ :aC | aC etat = 'O' and: [ aC pion owner = self ] ]
		thenCollect: [ :aC | aC croix ]) flattened asSet
		ifEmpty: [ Set new
				add: (self atPoint: 8 @ 8);
				yourself ]