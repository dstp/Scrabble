accessing
unlockCases
	^ self modele cases select: [ :c | true ] thenDo: [ :c | c morph lock: false ]