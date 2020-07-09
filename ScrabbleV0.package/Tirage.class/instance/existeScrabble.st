accessing
existeScrabble
	| lettres maxVal res |
	self morph getPions.
	lettres := Scrabble asByteString: self pions.
	lettres ifEmpty: [ ^ self jeu finDePartie ].
	res := Array new.
	(lettres size = 7 and: [ (lettres indexOf: $*) > 0 ])
		ifTrue: [ res := self joueLettres: (lettres copyWithout: $*) ].
	maxVal := self joueLettres: lettres.
	(maxVal isNotEmpty and: [ (maxVal at: 1) > 0 ])
		ifTrue: [ res
				ifNotEmpty: [ (res at: 1) + 15 > (maxVal at: 1)
						ifTrue: [ maxVal := res ] ].
			((maxVal at: 2) trimBoth size >= 7 and: [ (maxVal at: 1) > 55 ])
				ifTrue: [ | ar |
					ar := self
						getLesMPionsFor: (maxVal at: 2) trimBoth
						at: (maxVal at: 3) @ (maxVal at: 4)
						d: (maxVal at: 5).
					(ar at: 1) size = 7
						ifTrue: [ (self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
								flashBounds.
							^ true ] ] ].
	UIManager inform: 'Pas de scrabble'.
	^ false