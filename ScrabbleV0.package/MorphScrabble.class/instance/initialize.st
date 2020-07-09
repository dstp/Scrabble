initialization
initialize
	self setLabel: 'Scrabble By Me'.
	super initialize.
	modele := Scrabble newMorph: self.
	sac := MorphSac new: self.
	grille := MorphGrille new: self.
	robot := MorphTirage nom: 'robot' new: self.
	robot modele: self modele robot.
	robot modele morph: robot.
	robot setSubmorphs.
	joueur := MorphTirage nom: 'joueur' new: self.
	joueur modele: self modele joueur.
	joueur modele morph: joueur.
	joueur setSubmorphs.
	ptJ := TextMorph new.
	ptR := TextMorph new.
	pions := MorphPion getMPionsWith: self modele pions.
	sac initializePions.
	grille position: self position + (10 @ 50).
	joueur position: grille bottomLeft + (0 @ 5).
	robot position: grille topRight + (5 @ 0).
	ptJ position: joueur topRight + (10 @ 0).
	ptR position: joueur topRight + (10 @ 18).
	"info := Transcript openLabel: 'Scrabble information'."
	"info position: robot topRight + (100 @ 0)."
	point := TextMorph new .
"	point
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 11);
		textColor: Color white;
		backgroundColor: Color red."
	"toggleCornerRounding."
	self addMorph: grille redraw.
	self addMorph: joueur redraw.
	self addMorph: robot redraw.
	self addMorph: ptJ.
	self addMorph: ptR.
	"self addMorph: info."
	self addMorph: point hide.
	self robot modele manuel: false.
	self joueur modele manuel: true.
	self wantsYellowButtonMenu: true.
	self modele class getDictDesMots.
	self modele class getDictDesAnagrammes.
	self nouvellePartie