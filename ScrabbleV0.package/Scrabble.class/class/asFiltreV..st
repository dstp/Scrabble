jeuDeScrabble
asFiltreV: aOC
	^ (aOC
				inject: (WriteStream with: String new)
				into: [ :s :mc | 
					s
						nextPutAll: mc asFiltreV;
						yourself ]) contents 