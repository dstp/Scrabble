accessing
getPions
	self modele getPions.
	self jeu updateModele: false.
	self redraw.
	self jeu updateModele: true.
	^ self