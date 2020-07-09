accessing
putPions: desPions
	desPions do: [ :p | p moveTo: self ].
	self pionsSurGrille do: [ :p | p moveTo: self ]