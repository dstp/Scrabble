printing
printString
	^ self isJocker ifTrue: ['*'] ifFalse: [ self lettre]