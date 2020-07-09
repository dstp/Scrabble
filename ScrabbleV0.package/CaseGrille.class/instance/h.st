accessing
h
	"la case au dessus ou une case HorsJeu"

	^ h
		ifNil: [ h := self ligne <= 1
				ifTrue: [ self class new
						ligne: 0;
						colonne: self colonne;
						whereIs: self whereIs ]
				ifFalse: [ self whereIs atPoint: self asPoint + (0 @ -1) ] ]