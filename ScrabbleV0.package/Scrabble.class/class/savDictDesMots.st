dico
savDictDesMots
	| f |
	f := (FileSystem / '/home/dsp/Documents/Scrabble/dicoSave.txt')
		writeStream.
	self dictDesMots keys sorted
		do: [ :str | 
			f nextPutAll: str asLowercase.
			f lf ].
	f close