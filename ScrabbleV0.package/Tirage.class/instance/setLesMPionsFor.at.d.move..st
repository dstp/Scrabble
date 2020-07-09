automate
setLesMPionsFor: unMot at: aPoint d: aBool move: aBoolAct
	| cases pions res jock |
	res := self getLesMPionsFor: unMot at: aPoint d: aBool.
	res isEmpty
		ifTrue: [ ^ self ].
	cases := res at: 1.
	pions := res at: 2.
	"optimatiser le placement du jocker"
	jock := pions detect: [ :p | p isJocker ] ifNone: [ nil ].
	jock
		ifNotNil: [ | pionJ maxP maxPions |
			pionJ := pions select: [ :p | p ~= jock and: [ p lettre = jock lettre ] ].
			pionJ
				ifNotEmpty: [ | pionsBis nP |
					maxPions := pions copy.
					cases with: pions do: [ :aCase :pion | pion moveTo: aCase ].
					maxP := self jeu grille pointsTotal: self.
					self unsetLesPions.
					pionJ
						do: [ :p | 
							pionsBis := pions copy swap: (pions indexOf: jock) with: (pions indexOf: p).
							cases with: pionsBis do: [ :aCase :pion | pion moveTo: aCase ].
							nP := self jeu grille pointsTotal: self.
							nP > maxP
								ifTrue: [ maxP := nP.
									maxPions := pionsBis ].
							self unsetLesPions ].
					pions := maxPions ] ].
	cases
		with: pions
		do: [ :aCase :pion | 
			aBoolAct
				ifTrue: [ aCase morph addMorph: pion morph ]
				ifFalse: [ pion moveTo: aCase ] ]