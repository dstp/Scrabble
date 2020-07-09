initialization
initializeCases
	self modele cases
		do: [ :aCase | 
			| aMorph |
			aMorph := MorphCaseGrille new modele: aCase.
			aCase morph: aMorph.
			self addMorph: aMorph showDos ]