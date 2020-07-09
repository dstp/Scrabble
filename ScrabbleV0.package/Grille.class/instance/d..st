no use
d: aCase
	"
	a ByteString
	"
	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self d: aCase d) ]