accessing
grille
	^ grille ifNil: [ grille := CaseGrille uneGrille: self ]