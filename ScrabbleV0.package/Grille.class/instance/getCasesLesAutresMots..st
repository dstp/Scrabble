points
getCasesLesAutresMots: cases
	"
	cases ou mot : collection de cases formant un mot horizontal ou vertical
	Je retourne une collection de mots othogonaux à chacune des lettres du mot
	"

	^ cases size = 1
		ifTrue: [ | res |
			res := self getCasesMotV: cases.
			res size > 1
				ifTrue: [ self getCasesLesAutresMotsV: cases ]
				ifFalse: [ self getCasesLesAutresMotsH: cases ] ]
		ifFalse: [ cases first colonne = cases last colonne
				ifTrue: [ self getCasesLesAutresMotsV: cases ]
				ifFalse: [ self getCasesLesAutresMotsH: cases ] ]