accessing
getPionsN: n withJ: aBool
	| desP |
	desP := (self jeu pionsOwner: self) asArray.
	aBool
		ifTrue: [ | desJ |
			desJ := desP select: [ :p | p isJocker ].
			desJ size > 1
				ifTrue: [ desP := desP reject: [ :p | p = desJ first ] ] ]
		ifFalse: [ desP := desP reject: [ :p | p isJocker ] ].
	^ desP shuffle copyFrom: 1 to: (n min: desP size)