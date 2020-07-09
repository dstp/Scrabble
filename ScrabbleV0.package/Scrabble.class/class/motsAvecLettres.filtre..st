lesMots
motsAvecLettres: desLettres filtre: unFiltre
	"
	self motsAvecLettres: 'DECRIT' filtre: '*E'
	"

	| lettres |
	"Transcript
		show: unFiltre;
		cr."
	lettres := (unFiltre copyWithRegex: '\((\w(\|\w)*)\)' matchesReplacedWith: '')
		select: [ :c | c isAlphaNumeric ].
	^ (((self motsAvecLettres: lettres , desLettres) allRegexMatches: (self filtre: unFiltre))
		collect: [ :m | m trimBoth ]) asSet