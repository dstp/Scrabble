dico
existeMot: unMot
	^ self dictDesMots
		at: unMot trimBoth asUppercase
		ifAbsent: [  false ]