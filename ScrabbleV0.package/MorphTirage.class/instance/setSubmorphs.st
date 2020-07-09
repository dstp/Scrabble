accessing
setSubmorphs
	self modele tirage 
		do: [ :aCase | 
			| aMorph |
			aMorph := MorphCaseTirage new modele: aCase.
			aCase morph: aMorph.
			self addMorph: aMorph showDos ].
		^ self