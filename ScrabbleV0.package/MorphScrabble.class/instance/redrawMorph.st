drawing
redrawMorph
	self updateModele: false.
	self grille redraw.
	self joueur redraw.
	self robot redraw.
	self afficheScores.
	"self info invalidRect: self info bounds."
	self updateModele: true