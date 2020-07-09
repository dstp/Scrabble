accessing
mesCases: cases
	"IU me propose les cases"

	^ (self jeu grille casesAutourO intersection: cases) isEmpty
		ifTrue: [ UIManager default abort: 'La position est incorrecte'.
			false ] ifFalse: [ true ]
	