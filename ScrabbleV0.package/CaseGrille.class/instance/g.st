accessing
g
	"la case à gauche ou une case horsJeu"

	^ g
		ifNil: [ g := self colonne <= 1
				ifTrue: [ self class new
						colonne: 0;
						ligne: self ligne;
						whereIs: self whereIs ]
				ifFalse: [ self whereIs atPoint: self asPoint + (-1 @ 0) ] ]