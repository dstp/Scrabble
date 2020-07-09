basic tests
verifCasesPionsPoses: cases
	"
	je vérifie si toutes les cases sont sur la même ligne/colonne
	"
	^ cases  isEmpty
		ifTrue: [ false ]
		ifFalse: [ cases  size = 1
				ifTrue: [ true ]
				ifFalse: [ cases  first colonne = cases  last colonne
						ifTrue: [ | c |
							c := cases  first colonne.
							(cases  select: [ :p | p colonne = c ]) size
								= cases  size ]
						ifFalse: [ | l |
							l := cases  first ligne.
							(cases  select: [ :p | p ligne = l ]) size
								= cases  size ] ] ]