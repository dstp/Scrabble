change reporting
getMorphPion
	| p |
	self isNotEmpty
		ifFalse: [ ^ self ].
	p := self modele pion.
	p isJocker
		ifTrue: [ p jocker: ' '.
 ].
 self addMorphFront: p morph showFace 