accessing
getPionsMot: unMot
	self modele givePions.
	self modele getPionsMot: unMot.
	self jeu updateModele: false.
	self redraw.
	self jeu updateModele: true.
	^ self