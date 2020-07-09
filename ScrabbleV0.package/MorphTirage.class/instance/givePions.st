accessing
givePions
	self modele getPions.
	self modele givePions.
	self jeu updateModele: false.
	self redraw.
	self jeu updateModele: true.
	^ self