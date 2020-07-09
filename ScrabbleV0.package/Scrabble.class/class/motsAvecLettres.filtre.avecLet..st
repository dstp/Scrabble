private
motsAvecLettres: desLettres filtre: unFiltre avecLet: lettres
	"
	self motsAvecLettres: 'DECRIT' filtre: '*E'
	"

	^ (((self motsAvecLettres: lettres , desLettres)
		allRegexMatches: unFiltre) collect: [ :m | m trimBoth ]) asSet