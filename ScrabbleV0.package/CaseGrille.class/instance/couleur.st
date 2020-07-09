accessing
couleur
	| coul |
	coul := self bonusMot at: self bonusKey ifAbsent: [ 0 ].
	^ coul := coul = 0
		ifTrue: [ self bonusLettre at: self bonusKey ifAbsent: [ 1 ] ]
		ifFalse: [ coul + 2 ]