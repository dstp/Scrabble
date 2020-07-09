accessing
pionsSurGrille
	^ self pions select: [ :p | p whereIs owner ~= self ]