converting
asByteString: cases
	"
	je renvoie un ByteString 
	"
	^ cases isEmpty
		ifTrue: [ String new ]
		ifFalse: [ (cases
				inject: (WriteStream with: String new)
				into: [ :s :aCase | 
					s
						nextPutAll: aCase asString;
						yourself ]) contents ]