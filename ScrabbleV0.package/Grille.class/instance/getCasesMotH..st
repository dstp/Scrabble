points
getCasesMotH: casesH
	"
	casesH : collection de cases d'une même ligne 
	J'étends vers la gauche à partir de la première case (et vers la droite à partir de la dernière) tant qu'il y une case avec un pion
	je retourne une nouvelle collection de cases qui comprend toutes les cases de la plus à gauche à la plus à droite. 
	je retourne une collection vide si casesH contient une seule case et sans extension possible
	"

	| c1 c2 |
	c1 := casesH first g.
	[ c1 isNotHorsJeu and: [ c1 isNotEmpty ] ] whileTrue: [ c1 := c1 g ].
	c2 := casesH last d.
	[ c2 isNotHorsJeu and: [ c2 isNotEmpty ] ] whileTrue: [ c2 := c2 d ].
	^ c1 colonne + 1 = (c2 colonne - 1)
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ ((self ligne: c1 ligne) copyFrom: c1 colonne + 1 to: c2 colonne - 1)
				asOrderedCollection ]