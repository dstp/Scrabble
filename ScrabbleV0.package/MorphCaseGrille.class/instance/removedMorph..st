submorphs-add/remove
removedMorph: aMorph
	aMorph modele valeur = 0
		ifTrue: [ "aMorph modele jocker: ' '."
			aMorph faceJ: nil.
			aMorph showFace ].
	super removedMorph: aMorph