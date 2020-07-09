accessing
pionsOwner: aOwner

	^ self pions select: [ :p | p owner = aOwner ]