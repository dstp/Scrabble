initialization
initializePions
	self jeu pions
		do: [ :p | 
			p
				sac: self ]