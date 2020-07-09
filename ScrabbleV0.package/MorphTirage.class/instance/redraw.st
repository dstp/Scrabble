drawing
redraw
	self setBounds.
	self nom = 'joueur'
		ifTrue: [self position: self jeu grille bottomLeft + (0 @ 5) ]
		ifFalse: [ self position: self jeu grille topRight + (5 @ 0) ] .
	self submorphs sorted
		do: [ :m | 
			| aPoint |
			m redraw.
			aPoint := 1 @ m modele colonne.
			self nom = 'joueur'
				ifTrue: [ m
						left: self left + 5 + ((aPoint y - 1) * (m width + 2));
						top: self top + 5 + ((aPoint x - 1) * (m height + 2)) ]
				ifFalse: [ m
						left: self left + 5 + ((aPoint x - 1) * (m width + 2));
						top: self top + 5 + ((aPoint y - 1) * (m height + 2)) ].
			self addMorphFront: m ].
	self
		submorphsDo: [ :m | 
			m
				removeAllMorphs;
				getMorphPion ]