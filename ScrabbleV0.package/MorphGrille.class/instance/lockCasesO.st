accessing
lockCasesO
	^ self modele casesO
		select: [ :c | true ]
		thenDo: [ :c | c morph lock: true ]