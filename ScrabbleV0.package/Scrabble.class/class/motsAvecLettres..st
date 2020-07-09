lesMots
motsAvecLettres: desLettres
	"retourne un ByteString avec les mots séparés par des espaces"

	^ self getDictDesAnagrammes at: (self motAsCle: desLettres) ifAbsent: [ '' ]