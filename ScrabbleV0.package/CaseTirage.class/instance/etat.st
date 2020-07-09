accessing
etat
	^ self isEmpty
		ifTrue: [ 'L' ]
		ifFalse: [ 'O' ]