converting
asFiltreV
	^ self etat = 'O'
		ifTrue: [ self pion nom ]
		ifFalse: [ self class asFiltre: self valV ]