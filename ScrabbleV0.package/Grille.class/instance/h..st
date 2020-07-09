no use
h: aCase
	"
	a ByteString
	"

	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self h: aCase h) ]