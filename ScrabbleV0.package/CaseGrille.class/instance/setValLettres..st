accessing
setValLettres: oC
	" 
	Je retourne l'ensemble des lettres qui permettent de construire des mots
	"

	| ind |
	ind := oC indexOf: self.
	oC at: ind put: Pion unPionPoint.
	^ (Scrabble
		motsAvecLettresEtJockers: '*'
		filtre: (self jeu class asByteString: oC)) collect: [ :m | m at: ind ]