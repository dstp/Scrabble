printing
printOn: aStream
	self nom printOn: aStream.
	(Scrabble asByteString: self submorphs sorted) printOn: aStream