change reporting
addedMorph: aMorph
	aMorph modele isJocker
		ifTrue: [ aMorph modele jocker = ' '
				ifTrue: [ aMorph modele
						jocker:
							(self theme
								chooseDropListIn: self currentWorld
								text: 'Quelle lettre ?' translated
								title: 'Choisir'
								list: (($A to: $Z) collect: [ :c | c asString ])) ].
			aMorph
				faceJ: nil;
				showFaceJ ]
		ifFalse: [ aMorph showFace ].
	aMorph position: self position.
	self owner jeu updateModele
		ifTrue: [ aMorph modele moveTo: self modele]