dropping/grabbing
wantsToBeDroppedInto: aMorph
	^ (aMorph class = MorphCaseGrille
		or: [ aMorph class = MorphCaseTirage	])
		and: [ aMorph modele etat = 'L' ]