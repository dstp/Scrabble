jeuDeScrabble
asFiltreH: aOC
	^ (aOC
				inject: (WriteStream with: String new)
				into: [ :s :mc | 
					s
						nextPutAll: mc asFiltreH;
						yourself ]) contents