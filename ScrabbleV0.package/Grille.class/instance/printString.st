printing
printString
	| aStream |
	aStream := WriteStream with: String new.
	aStream cr.
	self lignes
		select: [ :lig | true ]
		thenDo: [ :lig | 
			lig
				inject: aStream
				into: [ :str :aC | 
					str
						nextPutAll:
							(aC isEmpty
								ifTrue: [ '   ' ]
								ifFalse: [ ' {1} ' format: aC pion lettre ]);
						yourself ].
			aStream cr ].
	^ aStream contents