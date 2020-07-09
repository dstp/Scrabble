jeuDeScrabble
asByteString: aOC
	^ (aOC
		inject: (WriteStream with: String new)
		into: [ :s :mc | 
			s
				nextPutAll: mc asString;
				yourself ]) contents