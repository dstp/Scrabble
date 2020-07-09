accessing
firstG
	"
	je retourne la plus en haut des cases non vide 
	"

	| cg |
	cg := self g.
	[cg isHorsJeu or: [ cg isEmpty ]] whileFalse: [ cg := cg g ].
	^ cg d