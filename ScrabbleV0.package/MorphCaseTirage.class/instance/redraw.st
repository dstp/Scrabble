drawing
redraw
	self extent: self class myExtent .
	(self submorphs isEmpty and: [ self isNotEmpty ])
		ifTrue: [ self getMorphPion ]