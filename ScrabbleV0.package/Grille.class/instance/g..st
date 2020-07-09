no use
g: aCase
	"
	a ByteString
	"

	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self g: aCase g) ]