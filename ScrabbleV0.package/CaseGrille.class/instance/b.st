accessing
b
	"la case en dessous ou une case horsJeu"

	^ b
		ifNil: [ b := self ligne >= 15
				ifTrue: [ self class new
						ligne: 16;
						colonne: self colonne;
						whereIs: self whereIs ]
				ifFalse: [ self whereIs atPoint: self asPoint + (0 @ 1) ] ]