dico
getDictDesMots
	dictDesMots
		ifNil: [ | f |
			f := (FileSystem / '/home/dsp/Documents/Scrabble/dicoSave.txt')
				readStream.
			dictDesMots := Dictionary new.
			[ f atEnd ]
				whileFalse: [ | str |
					str := f nextLine.
					dictDesMots at: str asUppercase put: true ].
			f close ].
	^ dictDesMots