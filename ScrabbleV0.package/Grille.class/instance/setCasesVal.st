initialization
setCasesVal
	self resetCasesVal.
	self casesAutourO
		select: [ :c | c isEmpty ]
		thenDo: [ :c | c setVal ].
