points
pointsTotal: unJoueur
	"
 	retourne les points calculés à partir des pions posés par le joueur
 	pionsPoses : les pions posés sur la grille par le joueur
 	casesMot : le mot formé sur la grille avec pionsPoses (horizontalement ou verticalement)
 	casesLesMots : les mots formés sur la grille en dehors du mot initial (les mots orthogonaux)
 	pionsPoses est vide, on retourne 0
 	pionsPoses comprend un seul pion, on calcule les points du mot horizontal (mot de plus d'une lettre) et du mot vertical (mot de plus d'une lettre).
 	pionsPoses comprend plus d'un pion, on calcule les points du mot horizontal/vertical (si 7 pions posés alors bonus de scrabble) et les points des mots 	verticaux/horizontaux.
	"

	| casesMot pionsPoses casesLesMots pts |
	pts := 0.
	pionsPoses := self casesPionsDe: unJoueur.
	(self class verifCasesPionsPoses: pionsPoses)
		ifFalse: [ ^ pts ].
	pionsPoses size = 7
		ifTrue: [ pts := 50 ].
	casesMot := self getCasesMot: pionsPoses.
	(self class verifPionsPoses: casesMot info: true)
		ifTrue: [ pts := pts + (self pointsCasesMot: casesMot) ]
		ifFalse: [ pts := 0.
			^ pts ].
	casesLesMots := self getCasesLesAutresMots: pionsPoses.
	casesLesMots
		select: [ :unCaseMot | unCaseMot isNotEmpty ]
		thenDo: [ :unCasesMot | 
			(self class verifPionsPoses: unCasesMot info: true)
				ifTrue: [ pts := pts + (self pointsCasesMot: unCasesMot) ]
				ifFalse: [ pts := 0.
					^ pts ] ].
	^ pts