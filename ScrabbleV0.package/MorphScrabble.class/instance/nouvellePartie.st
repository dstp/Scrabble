menu
nouvellePartie
	self point hide.
	self grille modele cases do: [ :c | c pion: nil ].
	self modele pions
		select: [ :p | true ]
		thenDo: [ :p | 
			p isJocker
				ifTrue: [ p jocker: ' ' ].
			p
				owner: self modele sac;
				whereIs: self modele sac ].
	self modele undo: nil.
	self joueur modele pts: 0; withJocker: true.
	self robot modele pts: 0; withJocker: true.
	self sac initializePions.
	self grille modele resetCasesVal.
	self grille unlockCases.
	self getPions.
	self redrawMorph.
	"Transcript clear."
	self refreshWorld.
	self modele actif joue