lesMots
tousLesMots: desLettres de: n filtre: aFiltre
	"
	Retourne un set des mots de n lettres avec desLetrres
	le caractères * joue le rôle de joker à limiter à 3
	self tousLesMots: 'FGEIRA***' de: 7 filtre: '(O|F)......'. 
	13s ...
	"

	| aSet |
	aSet := Set new.
	n = 0
		ifTrue: [ ^ aSet ].
	desLettres
		combinations: n
		atATimeDo: [ :each | 
			aSet
				addAll:
					(self
						motsAvecLettresEtJockers: (self asByteString: each)
						filtre: aFiltre) ].
	^ aSet