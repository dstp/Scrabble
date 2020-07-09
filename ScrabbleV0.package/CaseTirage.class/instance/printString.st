printing
printString
	^ self isEmpty
		ifTrue: [ '' ]
		ifFalse: [ self pion lettre ]