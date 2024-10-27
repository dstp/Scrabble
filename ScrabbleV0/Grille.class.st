"
Le plateau
"
Class {
	#name : 'Grille',
	#superclass : 'Object',
	#instVars : [
		'grille',
		'nom',
		'morph',
		'lignes',
		'colonnes',
		'jeu'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'converting' }
Grille class >> asByteString: cases [
	"
	je renvoie un ByteString 
	"
	^ cases isEmpty
		ifTrue: [ String new ]
		ifFalse: [ (cases
				inject: (WriteStream with: String new)
				into: [ :s :aCase | 
					s
						nextPutAll: aCase asString;
						yourself ]) contents ]
]

{ #category : 'basic tests' }
Grille class >> verifCasesPionsPoses: cases [
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
]

{ #category : 'basic tests' }
Grille class >> verifPionsPoses: casesMot [
	"
	je vérifie si le mot existe
	"
	^ casesMot isEmpty
		ifTrue: [ false ]
		ifFalse: [ Scrabble existeMot: (self asByteString: casesMot) ]
]

{ #category : 'basic tests' }
Grille class >> verifPionsPoses: casesMot info: aBool [
	"
	je vérifie si le mot existe, aBool provoque l'affichage d'un message d'erreur
	"
	^ casesMot isEmpty
		ifTrue: [ false ]
		ifFalse: [ (Scrabble existeMot: (self asByteString: casesMot))
				ifFalse: [ aBool
						ifTrue: [ UIManager default
								abort: (self asByteString: casesMot) , ' inconnu dans le dictionnaire' ].
					false ]
				ifTrue: [ true ] ]
]

{ #category : 'accessing' }
Grille >> atPoint: aPoint [
	"
	je retourne une case
	"
	
	^ self lig: aPoint y col: aPoint x
]

{ #category : 'no use' }
Grille >> b: aCase [
	" a ByteString "

	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self b: aCase b) ]
]

{ #category : 'no use' }
Grille >> b: aCase with: aOC [
" a Ordered Collection des cases adjacentes avec un pion"
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				b: aCase b
				with:
					(aOC
						add: aCase;
						yourself) ]
]

{ #category : 'accessing' }
Grille >> cases [
	^ self grille 
]

{ #category : 'accessing' }
Grille >> casesAutourO [
	"
	je retourne les cases qui touchent verticalement/horizontalement les cases occupées par mes pions
	si aucune case je retourne la case centrale 
	"

	^ (self grille
		select: [ :aC | aC etat = 'O' and: [ aC pion owner = self ] ]
		thenCollect: [ :aC | aC croix ]) flattened asSet
		ifEmpty: [ Set new
				add: (self atPoint: 8 @ 8);
				yourself ]
]

{ #category : 'accessing' }
Grille >> casesO [
	"
	je retourne les cases de ma grille occupées par un pion (un de mes pions ou un pion en cours de jeu)
	"
	^ self grille select: [ :aC | aC etat = 'O' ]
]

{ #category : 'accessing' }
Grille >> casesPionsDe: aOwner [
	"
	je retourne les cases de ma grille occupées par les pions du joueur aOwner (ses pions n'ont pas été validés)
	"

	^ self grille
		select: [ :aC | aC isNotEmpty and: [ aC pion owner = aOwner ] ]
]

{ #category : 'accessing' }
Grille >> colonne: col [
	^ self colonnes at: col 
]

{ #category : 'accessing' }
Grille >> colonnes [
	^ colonnes
		ifNil: [ colonnes := (1 to: 15)
				collect: [ :idx | self grille select: [ :aC | aC colonne = idx ] ] ]
]

{ #category : 'no use' }
Grille >> d: aCase [
	"
	a ByteString
	"
	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self d: aCase d) ]
]

{ #category : 'no use' }
Grille >> d: aCase with: aOC [
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				d: aCase d
				with:
					(aOC
						add: aCase;
						yourself) ]
]

{ #category : 'no use' }
Grille >> g: aCase [
	"
	a ByteString
	"

	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self g: aCase g) ]
]

{ #category : 'no use' }
Grille >> g: aCase with: aOC [
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				g: aCase g
				with:
					(aOC
						add: aCase;
						yourself) ]
]

{ #category : 'points' }
Grille >> getCasesLesAutresMots: cases [
	"
	cases ou mot : collection de cases formant un mot horizontal ou vertical
	Je retourne une collection de mots othogonaux à chacune des lettres du mot
	"

	^ cases size = 1
		ifTrue: [ | res |
			res := self getCasesMotV: cases.
			res size > 1
				ifTrue: [ self getCasesLesAutresMotsV: cases ]
				ifFalse: [ self getCasesLesAutresMotsH: cases ] ]
		ifFalse: [ cases first colonne = cases last colonne
				ifTrue: [ self getCasesLesAutresMotsV: cases ]
				ifFalse: [ self getCasesLesAutresMotsH: cases ] ]
]

{ #category : 'points' }
Grille >> getCasesLesAutresMotsH: casesH [
	"
	cases ou mot : collection de cases formant un mot, ici horizontal
	Je retourne la collection des mots verticaux à parir de chacune des lettres du mot initial
	"

	^ casesH
		collect: [ :aCase | self getCasesMotV: (Array with: aCase) ]
]

{ #category : 'points' }
Grille >> getCasesLesAutresMotsV: casesV [
	"
	cases ou mot : collection de cases formant un mot, ici vertical
	Je retourne la collection des mots horizontaux à parir de chacune des lettres du mot initial
	"

	^ casesV
		collect: [ :aCase | self getCasesMotH: (Array with: aCase) ]
]

{ #category : 'points' }
Grille >> getCasesMot: cases [
	"
	cases : collection de cases 
	je retourne une nouvelle collection de cases qui comprend les cases initiales complétés des cases qui ont des pions, adjacentes horizontalement ou verticalement
	
	!!!!! si une seule case est posée on choisit de retourner en priorité le mot vertical !!!!!
	"

	| res |
	cases size = 1
		ifTrue: [ res := self getCasesMotV: cases.
			res size > 1
				ifFalse: [ res := self getCasesMotH: cases ] ]
		ifFalse: [ res := cases first colonne = cases last colonne
				ifTrue: [ self getCasesMotV: cases ]
				ifFalse: [ self getCasesMotH: cases ] ].
	^ res
]

{ #category : 'points' }
Grille >> getCasesMotH: casesH [
	"
	casesH : collection de cases d'une même ligne 
	J'étends vers la gauche à partir de la première case (et vers la droite à partir de la dernière) tant qu'il y une case avec un pion
	je retourne une nouvelle collection de cases qui comprend toutes les cases de la plus à gauche à la plus à droite. 
	je retourne une collection vide si casesH contient une seule case et sans extension possible
	"

	| c1 c2 |
	c1 := casesH first g.
	[ c1 isNotHorsJeu and: [ c1 isNotEmpty ] ] whileTrue: [ c1 := c1 g ].
	c2 := casesH last d.
	[ c2 isNotHorsJeu and: [ c2 isNotEmpty ] ] whileTrue: [ c2 := c2 d ].
	^ c1 colonne + 1 = (c2 colonne - 1)
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ ((self ligne: c1 ligne) copyFrom: c1 colonne + 1 to: c2 colonne - 1)
				asOrderedCollection ]
]

{ #category : 'points' }
Grille >> getCasesMotV: casesV [
	"
	casesV : collection de cases d'une même colonne
	J'étends vers le haut à partir de la première case (et vers le bas à partir de la dernière) tant qu'il y une case avec un pion
	je retourne une nouvelle collection de cases qui comprend toutes les cases du plus haut au plus bas. 
	je retourne une collection vide si casesV contient une seule cases et sans extension possible
	"

	| c1 c2 |
	c1 := casesV first h.
	[ c1 isNotHorsJeu and: [ c1 isNotEmpty ] ] whileTrue: [ c1 := c1 h ].
	c2 := casesV last b.
	[ c2 isNotHorsJeu and: [ c2 isNotEmpty ] ] whileTrue: [ c2 := c2 b ].
	^ c1 ligne + 1 = (c2 ligne - 1)
		ifTrue: [ OrderedCollection new ]
		ifFalse: [ ((self colonne: c1 colonne) copyFrom: c1 ligne + 1 to: c2 ligne - 1)
				asOrderedCollection ]
]

{ #category : 'points' }
Grille >> getFiltreMots: lettres d: aBool [
	"
	lettres - a ByteString, les lettres du joueur 
	aBool - vrai pour une analyse horizontale, sinon verticale
	je retourne la liste de tous les mots qui peuvent être posés pour chaque positon 
	leFiltre, nL, nC, listeDesMots
	"

	| methVal methFil filtres allFiltres first precedent suivant |
	first := self jeu joueur pts + self jeu robot pts = 0.
	filtres := Array new.
	precedent := [ :nArray :n | 
	aBool
		ifTrue: [ (self atPoint: n @ nArray) g ]
		ifFalse: [ (self atPoint: nArray @ n) h ] ].
	suivant := [ :nArray :n | 
	aBool
		ifTrue: [ (self atPoint: n @ nArray) d ]
		ifFalse: [ (self atPoint: nArray @ n) b ] ].
	methVal := [ :aC | 
	aBool
		ifTrue: [ aC valH ]
		ifFalse: [ aC valV ] ].
	methFil := [ :aFi | 
	aBool
		ifTrue: [ Scrabble asFiltreH: aFi ]
		ifFalse: [ Scrabble asFiltreV: aFi ] ].
	allFiltres := OrderedCollection new.
	(aBool
		ifTrue: [ self lignes ]
		ifFalse: [ self colonnes ])
		doWithIndex: [ :aArray :nArray | 
			| fil |
			1 to: 14 do: [ :d | 
				| aF k |
				(precedent value: nArray value: d) etat = 'O'
					ifFalse: [ d + 1 to: 15 do: [ :f | 
							k := f.
							[ (suivant value: nArray value: k) etat = 'O' ]
								whileTrue: [ k := k + 1 ].
							filtres ~= (aArray copyFrom: d to: (k max: f))
								ifTrue: [ filtres := aArray copyFrom: d to: (k max: f).
									first
										ifTrue: [ fil := (filtres select: [ :ca | ca asPoint = (8 @ 8) ]) isNotEmpty ]
										ifFalse: [ fil := (filtres
												select: [ :ca | 
													ca etat = 'O'
														or: [ | res |
															res := methVal value: ca.
															res isNotNil and: [ res notEmpty ] ] ]) notEmpty.
											fil := fil
												and: [ (filtres reject: [ :ca | ca etat = 'O' ]) size between: 1 and: 7 ] ].
									aF := methFil value: filtres.
									fil := fil and: [ (aF indexOf: $#) = 0 ].
									fil
										ifTrue: [ | aS |
											aS := Scrabble
												tousLesMots: lettres
												filtre: aF
												avecLets: (filtres select: [ :ca | ca etat = 'O' ]).
											aS notEmpty
												ifTrue: [ allFiltres
														add:
															(Array
																with: aF
																with:
																	(aBool
																		ifTrue: [ nArray ]
																		ifFalse: [ d ])
																with:
																	(aBool
																		ifTrue: [ d ]
																		ifFalse: [ nArray ])
																with: aS) ] ] ] ] ] ] ].
	^ allFiltres
]

{ #category : 'accessing' }
Grille >> grille [
	^ grille ifNil: [ grille := CaseGrille uneGrille: self ]
]

{ #category : 'no use' }
Grille >> h: aCase [
	"
	a ByteString
	"

	^ aCase isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aCase pion lettre , (self h: aCase h) ]
]

{ #category : 'no use' }
Grille >> h: aCase with: aOC [
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				h: aCase h
				with:
					(aOC
						add: aCase;
						yourself) ]
]

{ #category : 'accessing' }
Grille >> jeu [
	^ jeu
]

{ #category : 'accessing' }
Grille >> jeu: anObject [
	jeu := anObject
]

{ #category : 'accessing' }
Grille >> lig: aLig col: aCol [
	^ (self ligne: aLig) at: aCol
]

{ #category : 'accessing' }
Grille >> ligne: aLig [
	^ self lignes at: aLig
]

{ #category : 'accessing' }
Grille >> lignes [
	^ lignes
		ifNil: [ lignes := (1 to: 15)
				collect: [ :idx | self grille select: [ :aC | aC ligne = idx ] ] ]
]

{ #category : 'accessing' }
Grille >> morph [
	^ morph
]

{ #category : 'accessing' }
Grille >> morph: anObject [
	morph := anObject
]

{ #category : 'accessing' }
Grille >> nom [
	^ nom
]

{ #category : 'accessing' }
Grille >> nom: anObject [
	nom := anObject
]

{ #category : 'accessing' }
Grille >> pions [
	^ self jeu pions select: [ :p | p owner = self ]
]

{ #category : 'points' }
Grille >> pointsCasesMot: casesMot [
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
]

{ #category : 'points' }
Grille >> pointsTotal: unJoueur [
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
]

{ #category : 'printing' }
Grille >> printString [
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
]

{ #category : 'initialization' }
Grille >> resetCasesVal [
	self cases
		select: [ :c | true ]
		thenDo: [ :c | 
			c
				valH: nil;
				valV: nil ]
]

{ #category : 'initialization' }
Grille >> setCasesVal [
	self resetCasesVal.
	self casesAutourO
		select: [ :c | c isEmpty ]
		thenDo: [ :c | c setVal ].

]

{ #category : 'accessing' }
Grille >> size [
	^ self casesO size
]
