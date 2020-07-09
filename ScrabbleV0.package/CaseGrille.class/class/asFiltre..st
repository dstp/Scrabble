accessing
asFiltre: ar
	| str |
	ar ifNil: [ ^ '.' ].
	ar ifEmpty: [ ^ '#' ].
	str := (ar
		inject: (WriteStream with: '(')
		into: [ :ws :ch | 
			ws
				nextPutAll: ch asString;
				nextPutAll: '|';
				yourself ]) contents.
	str at: str size put: $).
	^ str