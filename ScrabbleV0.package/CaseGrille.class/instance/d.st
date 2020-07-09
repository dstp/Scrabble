accessing
d
	"la case à droite ou une case horsJeu"

	^ d
		ifNil: [ d := self colonne >= 15
				ifTrue: [ self class new
						colonne: 16;
						ligne: self ligne ;
						whereIs: self whereIs]
				ifFalse: [ d := self whereIs atPoint: self asPoint + (1 @ 0) ] ]