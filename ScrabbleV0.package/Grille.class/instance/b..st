no use
b: aCase
	" a ByteString "

	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self b: aCase b) ]