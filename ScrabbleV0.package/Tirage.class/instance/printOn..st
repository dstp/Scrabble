printing
printOn: aStream
	aStream
		nextPutAll: self nom;
		nextPutAll: (Scrabble asByteString: self tirage)