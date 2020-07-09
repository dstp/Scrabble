points
getCasesMot: cases
	"
	cases : collection de cases 
	je retourne une nouvelle collection de cases qui comprend les cases initiales complétés des cases qui ont des pions, adjacentes horizontalement ou verticalement
	
	!!!!! si une seule case est posée on choisit de retourner en priorité le mot vertical !!!!!
	"

	| res |
	cases size = 1
		ifTrue: [ res := self getCasesMotV: cases.
			res size > 1
				ifFalse: [ res := self getCasesMotH: cases ] ]
		ifFalse: [ res := cases first colonne = cases last colonne
				ifTrue: [ self getCasesMotV: cases ]
				ifFalse: [ self getCasesMotH: cases ] ].
	^ res