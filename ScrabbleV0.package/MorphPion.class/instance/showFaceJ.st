accessing
showFaceJ
	self submorphs isEmpty
		ifTrue: [ self asFlexOf: self faceJ asMorph ]
		ifFalse: [ self firstSubmorph form: self faceJ ].
		^ self