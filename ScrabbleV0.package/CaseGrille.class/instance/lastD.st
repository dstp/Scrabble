accessing
lastD
	"
	je retourne la plus à droite des cases non vide 
	"

	| cd |
	cd := self d.
	[ cd isHorsJeu or: [ cd isEmpty ] ] whileFalse: [ cd := cd d ].
	^ cd g