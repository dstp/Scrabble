accessing
casesO
	^ self tirage  select: [ :aC | aC etat = 'O' ]