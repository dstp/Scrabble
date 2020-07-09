accessing
owner: aOwner
	^ self pions select: [ :p | p owner = aOwner  ]