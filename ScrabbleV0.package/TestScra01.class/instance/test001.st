tests
test001
	ms joueur getPionsMot: 'MAXIMUM'.
	ms joueur modele joueAutomate.
	self
		assert: ms joueur modele pts
		equals: 108.
	ms undo.
	self
		assert: ms joueur modele pts
		equals: 0.
	