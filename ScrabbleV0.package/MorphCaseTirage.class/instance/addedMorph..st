change reporting
addedMorph: aMorphPion
	"
	"
	aMorphPion showFace .
	aMorphPion position: self position.
	self owner jeu updateModele
		ifTrue: [ aMorphPion modele moveTo: self modele	]