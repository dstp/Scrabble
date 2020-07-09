printing
printOn: aStream
	"
	printOn: aStream, printString et asString
	"

	aStream nextPutAll: self asPoint asString;
		nextPutAll: (self pion ifNil: [ '' ] ifNotNil: [ self pion asString ])
	""