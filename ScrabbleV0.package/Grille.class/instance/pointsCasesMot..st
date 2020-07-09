points
pointsCasesMot: casesMot
	"
	casesMot: un mot
	je calcule et retourne les points :
	 	si le pion ne m'appatiens pas
			pour une case lettre compte double ou lettre compte triple on multiplie la valeur du pion sur la case
			pour une case mot compte double ou mot compte triple on multiplie la valeur du mot 
		rappel : case couleur = 1, 2 ou 3 pour valoriser la lettre (pion posé)
					case couleur = 4 ou 5 pour valoriser le mot 
	pour les pions déjà sur la grille, donc qui m'appartiennent, on prend la valeur des pions
	"

	| pts xL xM |
	pts := 0.
	xM := 1.	"multiplicateur appliqué au mot"
	xL := 1.	"multiplicateur appliqué à la lettre"
	casesMot
		do: [ :aCM | 
			aCM pion owner ~= self
				ifTrue: [ xL := aCM couleur < 4
						ifTrue: [ aCM couleur ]
						ifFalse: [ 1 ].
					xM := xM
						*
							(aCM couleur > 3
								ifTrue: [ aCM couleur - 2 ]
								ifFalse: [ 1 ]) ]
				ifFalse: [ xL := 1 ].
			pts := pts + (aCM pion valeur * xL) ].
	^ pts * xM