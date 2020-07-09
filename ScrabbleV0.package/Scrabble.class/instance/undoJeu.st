accessing
undoJeu
	"il peut y avoir des problèmes notamment dans l'affichage"

	| undoArr unJ |
	self joueur getPions .
	self robot getPions .
	undoArr := self undo.
	undoArr ifNil: [ ^ self ].
	unJ := undoArr at: 2.
	self actif: unJ.
	(undoArr at: 1)
		do: [ :aP | 
			(self grille atPoint: aP) pion moveTo: sac.
			(self grille atPoint: aP) morph removeAllMorphs ].
	unJ morph getPionsMot: (undoArr at: 3) trimBoth.
	unJ pts: unJ pts - (undoArr at: 4).
	self morph redrawMorph.
	self grille setCasesVal.
	^ self