change reporting
getMorphPion
	| p |
	self isNotEmpty
		ifFalse: [ ^ self ].
	p := self modele pion.
	p isJocker
		ifTrue: [ self addMorphFront: self modele pion morph showFaceJ ]
		ifFalse: [ self addMorphFront: self modele pion morph showFace ]