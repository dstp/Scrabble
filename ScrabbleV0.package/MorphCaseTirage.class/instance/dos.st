accessing
dos
	^ dos ifNil: [ dos := self class couleurPour: self modele couleur ]