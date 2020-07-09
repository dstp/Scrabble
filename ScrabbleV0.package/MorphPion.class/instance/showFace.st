accessing
showFace
	self submorphs isEmpty
		ifTrue: [ self asFlexOf: self face asMorph ]
		ifFalse: [ self firstSubmorph form: self face ].
		^ self