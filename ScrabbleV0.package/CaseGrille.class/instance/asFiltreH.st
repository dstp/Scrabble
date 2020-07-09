converting
asFiltreH
	
	^ self etat = 'O'
		ifTrue: [ self pion nom ]
		ifFalse: [ self class asFiltre: self valH ]