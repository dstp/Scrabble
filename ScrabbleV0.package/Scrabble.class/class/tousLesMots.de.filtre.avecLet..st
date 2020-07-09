private
tousLesMots: desLettres de: n filtre: aFiltre avecLet: what
	"
	je suis appele par grille.getFiltre:d: plusieurs fois avec les memes valeurs de n et filtre 
	la methode et les suivantes sont modifiées pour ne pas refaire inutilement des calculs
		motsAvecLettresEtJockers:filtre:avecLet
			motsAvecLettres:filtre:avecLet:
				lettres := (unFiltre copyWithRegex: '\((\w(\|\w)*)\)' matchesReplacedWith: '') select: [ :c | c isAlphaNumeric ] est calculé dans grille.getFiltre:d:
				de même filtre := Scrabble asFiltre: unFiltre
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
						filtre: aFiltre
						avecLet: what)	"aSet := aSet union:" ].
	^ aSet