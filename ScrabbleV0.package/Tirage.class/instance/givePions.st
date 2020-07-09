accessing
givePions
	self tirage select: [ :c | c isNotEmpty ] thenDo: [ :c | c pion moveTo: self jeu sac ].
	^ self
