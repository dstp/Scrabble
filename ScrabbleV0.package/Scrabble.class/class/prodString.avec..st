lesMots
prodString: str01 avec: str02
	"
	'A|B' 'C|D|E' -> 'AC|AD|AE|BC|BD|BE'
	'AB|AC' 'XY' -> 'ABX|ABY|ACX|ACY'
	"

	| ar2 |
	str01 = ''
		ifTrue: [ ^ str02 ].
	str02 = ''
		ifTrue: [ ^ str01 ].
	ar2 := str02 findBetweenSubstrings: '|'.
	^ ((str01 findBetweenSubstrings: '|')
		inject: (WriteStream with: String new)
		into: [ :r :a | 
			ar2
				inject: r
				into: [ :r2 :b | 
					r2
						nextPutAll: a;
						nextPutAll: b;
						nextPutAll: '|';
						yourself ] ]) contents