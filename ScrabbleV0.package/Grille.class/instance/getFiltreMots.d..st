points
getFiltreMots: lettres d: aBool
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