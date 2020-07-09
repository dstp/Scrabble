private
motsAvecLettresEtJockers: desLettres filtre: unFiltre avecLet: what
	"
	generer lettres et pour chaque appeler motsAvecLettres2: lettres filtre: unFiltre
	retourne un Set
	accepte plusieurs jockers (à limiter à 4 pour 30 secondes de traitement)
	self motsAvecLettresEtJockers: '**' filtre: 'A*(E|I)*'.
	"

	| lettres n |
	lettres := desLettres copyReplaceAll: '*' with: ''.
	n := lettres size.
	n to: desLettres size - 1 do: [ :i | lettres := self prodString: lettres avec: self jocker ].
	^ (lettres substrings: '|')
		inject: Set new
		into: [ :aSet :text | 
			aSet
				union: (self motsAvecLettres: text filtre: unFiltre avecLet: what) ]