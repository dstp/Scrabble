lesMots
uneLetAvant: unMot
	"retourne un Set"

	^ (self motsAvecLettresEtJockers: '*' filtre: '.' , unMot)
		inject: Set new
		into: [ :aSet :m | 
			aSet
				add: m trimBoth first asString;
				yourself ]