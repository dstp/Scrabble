points
getCasesMotV: casesV
	"
	casesV : collection de cases d'une même colonne
	J'étends vers le haut à partir de la première case (et vers le bas à partir de la dernière) tant qu'il y une case avec un pion
	je retourne une nouvelle collection de cases qui comprend toutes les cases du plus haut au plus bas. 
	je retourne une collection vide si casesV contient une seule cases et sans extension possible
	"

	| c1 c2 |
	c1 := casesV first h.
	[ c1 isNotHorsJeu and: [ c1 isNotEmpty ] ] whileTrue: [ c1 := c1 h ].
	c2 := casesV last b.
	[ c2 isNotHorsJeu and: [ c2 isNotEmpty ] ] whileTrue: [ c2 := c2 b ].
	^ c1 ligne + 1 = (c2 ligne - 1)
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ ((self colonne: c1 colonne) copyFrom: c1 ligne + 1 to: c2 ligne - 1)
				asOrderedCollection ]