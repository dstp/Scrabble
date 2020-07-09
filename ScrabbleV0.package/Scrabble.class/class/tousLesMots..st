lesMots
tousLesMots: desLettres
	"
	Retourne un set de tous les mots de 2 à desLetrres size (ce peut être long)
	self tousLesMots: 'FGEIRA**'
	"

	| aSet |
	aSet := Set new.
	2 to: desLettres size do: [ :n | 
		desLettres
			combinations: n
			atATimeDo:
				[ :each | aSet := aSet union: (self motsAvecLettresEtJockers: (self asByteString: each) filtre: '*') ] ].
	^ aSet