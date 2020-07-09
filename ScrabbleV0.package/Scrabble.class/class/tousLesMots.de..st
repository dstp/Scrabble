lesMots
tousLesMots: desLettres de: n
	"
	Retourne un set des mots de n lettres avec desLetrres
	le caractères * joue le rôle de joker, les jockers au delà de 3 sont ignorés.
	self tousLesMots: 'FGEIRA**' de: 8. 
	30 ms ...
	"

	| aSet |
	aSet := Set new.
	n = 0
		ifTrue: [ ^ aSet ].
	desLettres
		combinations: n
		atATimeDo:
			[ :each | aSet := aSet union: (self motsAvecLettresEtJockers: (self asByteString: each) filtre: '*') ].
	^ aSet