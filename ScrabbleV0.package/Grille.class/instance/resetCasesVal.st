initialization
resetCasesVal
	self cases
		select: [ :c | true ]
		thenDo: [ :c | 
			c
				valH: nil;
				valV: nil ]