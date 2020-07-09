accessing
setValH
	"
	J'initialise valH avec un set des lettres permettant de construire des mots dans le sens vertical  
	"

	| oC |
	self valH: nil.
	oC := self whereIs getCasesMotV: (Array with: self).
	oC
		ifNotEmpty: [ | lettres |
			lettres := self setValLettres: oC.
			self valH: lettres ].
	^ valH