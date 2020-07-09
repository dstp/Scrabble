drawing
redraw
	self setBounds.
	self position: self jeu position + (10 @ 50).
	self submorphs sorted
		do: [ :m | 
			| aPoint |
			m redraw.
			aPoint := m modele ligne @ m modele colonne.
			m
				left: self left + 5 + ((aPoint y - 1) * (m width + 2));
				top: self top + 5 + ((aPoint x - 1) * (m height + 2)).
			self addMorphFront: m ].
	self
		submorphsDo: [ :m | 
			m
				removeAllMorphs;
				getMorphPion ]