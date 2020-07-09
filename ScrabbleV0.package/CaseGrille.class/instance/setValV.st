accessing
setValV
	"
	J'initialise valV avec un set des lettres permettant de construire des mots dans le sens horizontal  
	"

	| oC |
	self valV: nil.
	oC := self whereIs getCasesMotH: (Array with: self).
	oC
		ifNotEmpty: [ | lettres |
			lettres := self setValLettres: oC.
			self valV: lettres ].
	^ valV