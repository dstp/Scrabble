automate
joueAide
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
			"(self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
				flashBounds."
			self
				setLesMPionsFor: (maxVal at: 2) trimBoth
				at: (maxVal at: 3) @ (maxVal at: 4)
				d: (maxVal at: 5)
				move: true.
			" je propose et rend la main au joueur "
			^ Array
				with: (maxVal at: 1)
				with: (maxVal at: 2)
				with: (maxVal at: 3)
				with: (maxVal at: 4)
				with: (maxVal at: 5) ]
		ifFalse: [ ^ Array new ]