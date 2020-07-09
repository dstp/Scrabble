initialization
initializePions
	self jeu pions
		do: [ :p | 
			p pion isJocker
				ifTrue: [ p pion jocker: ' ' ].
			self addMorph: p ]