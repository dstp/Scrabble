"
Un joueur
"
Class {
	#name : 'Tirage',
	#superclass : 'Object',
	#instVars : [
		'tirage',
		'nom',
		'morph',
		'jeu',
		'pts',
		'manuel',
		'withJocker'
	],
	#classInstVars : [
		'joueurs'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'utility' }
Tirage class >> info: maxVal [
			Transcript
				show: (maxVal at: 1) asString;
				show: ' points avec : ';
				show: (maxVal at: 2);
				show: ' (';
				show: (maxVal at: 3) asString;
				show: ' ';
				show: (maxVal at: 4) asString;
				show: ' ) ';
				show:
					((maxVal at: 5)
						ifTrue: [ 'Horizontal' ]
						ifFalse: [ 'Vertical' ]);
				cr;
				flush.
]

{ #category : 'accessing' }
Tirage class >> joueurs [
	^ joueurs ifNil: [ joueurs := Dictionary new ]
]

{ #category : 'accessing' }
Tirage class >> joueurs: anObject [
	joueurs := anObject
]

{ #category : 'instance creation' }
Tirage class >> new: aNom [
	^ self joueurs at: aNom ifPresent: [ :v | v ] ifAbsentPut: [ self new nom: aNom ]
]

{ #category : 'accessing' }
Tirage class >> nom: aNom [
	^ self joueurs at: aNom ifAbsent: [ nil ]
]

{ #category : 'accessing' }
Tirage >> cases [
	^ self tirage
]

{ #category : 'accessing' }
Tirage >> casesO [
	^ self tirage  select: [ :aC | aC etat = 'O' ]
]

{ #category : 'accessing' }
Tirage >> colonne: c [
	^ self tirage at: c.
]

{ #category : 'accessing' }
Tirage >> existeScrabble [
	| lettres maxVal res |
	self morph getPions.
	lettres := Scrabble asByteString: self pions.
	lettres ifEmpty: [ ^ self jeu finDePartie ].
	res := Array new.
	(lettres size = 7 and: [ (lettres indexOf: $*) > 0 ])
		ifTrue: [ res := self joueLettres: (lettres copyWithout: $*) ].
	maxVal := self joueLettres: lettres.
	(maxVal isNotEmpty and: [ (maxVal at: 1) > 0 ])
		ifTrue: [ res
				ifNotEmpty: [ (res at: 1) + 15 > (maxVal at: 1)
						ifTrue: [ maxVal := res ] ].
			((maxVal at: 2) trimBoth size >= 7 and: [ (maxVal at: 1) > 55 ])
				ifTrue: [ | ar |
					ar := self
						getLesMPionsFor: (maxVal at: 2) trimBoth
						at: (maxVal at: 3) @ (maxVal at: 4)
						d: (maxVal at: 5).
					(ar at: 1) size = 7
						ifTrue: [ (self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
								flashBounds.
							^ true ] ] ].
	UIManager inform: 'Pas de scrabble'.
	^ false
]

{ #category : 'accessing' }
Tirage >> firstCaseL [
	^ self tirage detect: [  :c | c etat = 'L' ]
]

{ #category : 'automate' }
Tirage >> getCasePionFor: aStr hors: cases [
	| aCase |
	aCase := (self tirage reject: [ :c | (cases indexOf: c) > 0 ]) detect: [ :c | c isNotEmpty and: [ c pion isJocker not and: [ c pion lettre = aStr ] ] ] ifNone: [ nil ].
	^ aCase
		ifNil: [ aCase := self tirage detect: [ :c | c isNotEmpty and: [ c pion isJocker ] ] ifNone: [ nil ].
			aCase
				ifNil: [ nil ]
				ifNotNil: [ aCase pion jocker: aStr.
					aCase ] ]
		ifNotNil: [ aCase ]
]

{ #category : 'automate' }
Tirage >> getLesMPionsFor: unMot at: aPoint d: aBool [
	"
	retourne les cases de la grille et les pions du joueur
	Array with: casesO with: pionsO
	"

	| aCase idx	"infinite" casesO pionsO cases |
	
	cases := OrderedCollection new.
	casesO := OrderedCollection new.
	pionsO := OrderedCollection new.
	idx := 1.
	"infinite := 1."
	aCase := self jeu grille atPoint: aPoint.
	[ true ]
		whileTrue: [ | aStr |
			"infinite := infinite + 1.
			infinite > 50
				ifTrue: [ UIManager default abort: 'Je boucle' ]."
			aCase isHorsJeu
				ifTrue: [ ^ Array new ].
			aCase isNotEmpty
				ifTrue: [ aCase pion lettre ~= (unMot at: idx) asString
						ifTrue: [ ^ Array new ]
						ifFalse: [ idx := idx + 1.
							idx > unMot size
								ifTrue: [ ^ Array with: casesO with: pionsO ]
								ifFalse: [ aCase := aBool
										ifTrue: [ aCase d ]
										ifFalse: [ aCase b ] ] ] ]
				ifFalse: [ | casePion |
					aStr := (unMot at: idx) asString.
					casePion := self getCasePionFor: aStr hors: cases.
					casePion
						ifNotNil: [ casesO add: aCase.
							pionsO add: casePion pion.
							cases add: casePion.
							idx := idx + 1.
							idx > unMot size
								ifTrue: [ ^ Array with: casesO with: pionsO ]
								ifFalse: [ aCase := aBool
										ifTrue: [ aCase d ]
										ifFalse: [ aCase b ] ] ]
						ifNil: [ ^ Array new ] ] ]
]

{ #category : 'accessing' }
Tirage >> getPions [
	"self unsetAndSetLesPions."

	self putPions: self getPionsFromSac.
	self updWithJocker .
	^ self pions
]

{ #category : 'accessing' }
Tirage >> getPionsFromSac [
	^ self jeu sac getPionsN: 7 - self pions size withJ: self withJocker

]

{ #category : 'accessing' }
Tirage >> getPionsMot: unMot [
	self putPions: (self jeu sac getPionsMot: unMot).
	^ self pions
]

{ #category : 'accessing' }
Tirage >> givePions [
	self tirage select: [ :c | c isNotEmpty ] thenDo: [ :c | c pion moveTo: self jeu sac ].
	^ self

]

{ #category : 'initialization' }
Tirage >> initialize [
	tirage := CaseTirage unTirage: self.
	^ self
]

{ #category : 'accessing' }
Tirage >> jeu [
	^ jeu
]

{ #category : 'accessing' }
Tirage >> jeu: anObject [
	jeu := anObject
]

{ #category : 'automate' }
Tirage >> joue [
	manuel
		ifTrue: [ ^ self ]
		ifFalse: [ ^ self joueAutomate ]
]

{ #category : 'automate' }
Tirage >> joueAide [
	| lettres maxVal res |
	self morph getPions.
	lettres := Scrabble asByteString: self pions.
	lettres ifEmpty: [ ^ self jeu finDePartie ].
	res := Array new.
	(lettres size = 7 and: [ (lettres indexOf: $*) > 0 ])
		ifTrue: [ res := self joueLettres: (lettres copyWithout: $*) ].
	maxVal := self joueLettres: lettres.
	(maxVal isNotEmpty and: [ (maxVal at: 1) > 0 ])
		ifTrue: [ res
				ifNotEmpty: [ (res at: 1) + 15 > (maxVal at: 1)
						ifTrue: [ maxVal := res ] ].
			"(self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
				flashBounds."
			self
				setLesMPionsFor: (maxVal at: 2) trimBoth
				at: (maxVal at: 3) @ (maxVal at: 4)
				d: (maxVal at: 5)
				move: true.
			" je propose et rend la main au joueur "
			^ Array
				with: (maxVal at: 1)
				with: (maxVal at: 2)
				with: (maxVal at: 3)
				with: (maxVal at: 4)
				with: (maxVal at: 5) ]
		ifFalse: [ ^ Array new ]
]

{ #category : 'automate' }
Tirage >> joueAutomate [

	Cursor wait showWhile: [ self joueAutomate2 ]
]

{ #category : 'automate' }
Tirage >> joueAutomate2 [
	| lettres maxVal res |
	self morph getPions.
	lettres := Scrabble asByteString: self pions.
	lettres ifEmpty: [ ^ self jeu finDePartie ].
	res := Array new.
	(lettres size = 7 and: [ (lettres indexOf: $*) > 0 ])
		ifTrue: [ res := self joueLettres: (lettres copyWithout: $*) ].
	maxVal := self joueLettres: lettres.
	(maxVal isNotEmpty and: [ (maxVal at: 1) > 0 ])
		ifTrue: [ res
				ifNotEmpty: [ (res at: 1) + 15 > (maxVal at: 1)
						ifTrue: [ maxVal := res ] ].
			"(self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
				flashBounds."
			self
				setLesMPionsFor: (maxVal at: 2) trimBoth
				at: (maxVal at: 3) @ (maxVal at: 4)
				d: (maxVal at: 5)
				move: true.
			" je termine et passe la main au joueur suivant "
			self joueFin: maxVal ]
		ifFalse: [ self jeu nbPasses: self jeu nbPasses + 1 ].
	self joueSuite
]

{ #category : 'automate' }
Tirage >> joueFin: maxVal [
	| cases pt |
	"self class info: maxVal."
	pt := self jeu morph point.
	pt
		position:
			(self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
				position.
	pt
		contents:
			((maxVal at: 1) asString asText
				addAttribute:
					(TextFontReference
						toFont:
							(LogicalFont
								familyName: 'Source Sans Pro'
								pointSize: MorphCaseGrille myExtent y / 3))).	"MorphCase myExtent y / 3"
	pt
		textColor: Color black;
		backgroundColor: Color white.
	pt show.
	self pts: self pts + (maxVal at: 1).
	cases := self jeu grille casesPionsDe: self.
	self jeu
		undo:
			(Array
				with: (cases collect: [ :c | c asPoint ])
				with: self
				with: (Scrabble asByteString: self pions)
				with: (maxVal at: 1)).
	cases select: [ :c | true ] thenDo: [ :c | c pion validePos ].
	self jeu grille setCasesVal.
	"self jeu morph redrawMorph."
	self getPions.
	"self jeu morph redrawMorph."
	self morph world ifNotNil: [ self morph world runStepMethods ].
	self jeu morph redrawMorph.
	self jeu morph refreshWorld.
	self jeu nbPasses: 0
]

{ #category : 'automate' }
Tirage >> joueLettres: lettres [
	| filtres maxVal first |
	first := self jeu joueur pts + self jeu robot pts = 0.
	lettres ifEmpty: [ ^ Array new ].
	filtres := self jeu grille getFiltreMots: lettres d: true.
	maxVal := self
		maxPointWith: filtres
		initVal:
			(Array
				with: 0
				with: ''
				with: 0
				with: 0
				with: true)
		d: true.
	first
		ifFalse: [ filtres := self jeu grille getFiltreMots: lettres d: false.
			maxVal := self maxPointWith: filtres initVal: maxVal d: false ].
	^ (maxVal at: 1) > 0
		ifTrue: [ Array
				with: (maxVal at: 1)
				with: (maxVal at: 2)
				with: (maxVal at: 3)
				with: (maxVal at: 4)
				with: (maxVal at: 5) ]
		ifFalse: [ Array new ]
]

{ #category : 'automate' }
Tirage >> joueSuite [
	^ ((Scrabble asByteString: self pions) isEmpty or: [ self jeu nbPasses > 1 ])
		ifTrue: [ self jeu finDePartie ]
		ifFalse: [ self jeu actif: self jeu actif suivant.
			self jeu actif joue ]
]

{ #category : 'accessing' }
Tirage >> manuel [
	^ manuel
]

{ #category : 'accessing' }
Tirage >> manuel: anObject [
	manuel := anObject
]

{ #category : 'automate' }
Tirage >> maxPointWith: filtres initVal: anArray d: aBool [
	| max maxM maxX maxY maxD |
	max := anArray at: 1.
	maxM := anArray at: 2.
	maxX := anArray at: 3.
	maxY := anArray at: 4.
	maxD := anArray at: 5.
	filtres
		do: [ :ar | 
			(ar at: 4)
				do: [ :m | 
					| nP |
					m isNotEmpty
						ifTrue: [ nP := self points: m trimBoth at: (ar at: 3) @ (ar at: 2) d: aBool.
							nP > max
								ifTrue: [ max := nP.
									maxM := m.
									maxX := ar at: 3.
									maxY := ar at: 2.
									maxD := aBool ] ] ] ].
	^ Array
		with: max
		with: maxM
		with: maxX
		with: maxY
		with: maxD
]

{ #category : 'accessing' }
Tirage >> mesCases: cases [
	"IU me propose les cases"

	^ (self jeu grille casesAutourO intersection: cases) isEmpty
		ifTrue: [ UIManager default abort: 'La position est incorrecte'.
			false ] ifFalse: [ true ]
	
]

{ #category : 'accessing' }
Tirage >> morph [
	^ morph
]

{ #category : 'accessing' }
Tirage >> morph: anObject [
	morph := anObject
]

{ #category : 'accessing' }
Tirage >> nom [
	^ nom
]

{ #category : 'accessing' }
Tirage >> nom: anObject [
	nom := anObject
]

{ #category : 'accessing' }
Tirage >> pions [
	^ self jeu pionsOwner: self 
]

{ #category : 'accessing' }
Tirage >> pionsSurGrille [
	^ self pions select: [ :p | p whereIs owner ~= self ]
]

{ #category : 'automate' }
Tirage >> points: aMot at: aPoint d: aBool [
	"on me propose de poser aMot sur la grille en partant de aPoint vers la droite (aBool = true) ou vers le bas"

	| p |
	p := 0.
	"setPions"
	self
		setLesMPionsFor: aMot
		at: aPoint
		d: aBool
		move: false.
	p := self jeu grille pointsTotal: self.
	self unsetLesPions.
	^ p
]

{ #category : 'printing' }
Tirage >> printOn: aStream [
	aStream
		nextPutAll: self nom;
		nextPutAll: (Scrabble asByteString: self tirage)
]

{ #category : 'accessing' }
Tirage >> pts [
	^ pts ifNil: [ pts := 0. pts]
]

{ #category : 'accessing' }
Tirage >> pts: anObject [
	pts := anObject
]

{ #category : 'accessing' }
Tirage >> putPions: desPions [
	desPions do: [ :p | p moveTo: self ].
	self pionsSurGrille do: [ :p | p moveTo: self ]
]

{ #category : 'automate' }
Tirage >> setLesMPionsFor: unMot at: aPoint d: aBool move: aBoolAct [
	| cases pions res jock |
	res := self getLesMPionsFor: unMot at: aPoint d: aBool.
	res isEmpty
		ifTrue: [ ^ self ].
	cases := res at: 1.
	pions := res at: 2.
	"optimatiser le placement du jocker"
	jock := pions detect: [ :p | p isJocker ] ifNone: [ nil ].
	jock
		ifNotNil: [ | pionJ maxP maxPions |
			pionJ := pions select: [ :p | p ~= jock and: [ p lettre = jock lettre ] ].
			pionJ
				ifNotEmpty: [ | pionsBis nP |
					maxPions := pions copy.
					cases with: pions do: [ :aCase :pion | pion moveTo: aCase ].
					maxP := self jeu grille pointsTotal: self.
					self unsetLesPions.
					pionJ
						do: [ :p | 
							pionsBis := pions copy swap: (pions indexOf: jock) with: (pions indexOf: p).
							cases with: pionsBis do: [ :aCase :pion | pion moveTo: aCase ].
							nP := self jeu grille pointsTotal: self.
							nP > maxP
								ifTrue: [ maxP := nP.
									maxPions := pionsBis ].
							self unsetLesPions ].
					pions := maxPions ] ].
	cases
		with: pions
		do: [ :aCase :pion | 
			aBoolAct
				ifTrue: [ aCase morph addMorph: pion morph ]
				ifFalse: [ pion moveTo: aCase ] ]
]

{ #category : 'accessing' }
Tirage >> setUnPion: aP [
	aP owner: self.
	self firstCaseL setUnPion: aP.
	^ self
]

{ #category : 'accessing' }
Tirage >> size [
	^ self casesO size
]

{ #category : 'accessing' }
Tirage >> suivant [
	^ self jeu robot = self
				ifTrue: [ ^ self jeu joueur  ]
				ifFalse: [ ^ self jeu robot  ] 
]

{ #category : 'accessing' }
Tirage >> tirage [
	^ tirage ifNil: [ tirage := CaseTirage unTirage: self ]
]

{ #category : 'accessing' }
Tirage >> tirage: anObject [
	tirage := anObject
]

{ #category : 'automate' }
Tirage >> unsetLesPions [
	(self jeu grille casesPionsDe: self)
		select: [ :c | true ]
		thenDo: [ :c | c pion moveTo: self ]
]

{ #category : 'accessing' }
Tirage >> updWithJocker [
	(self pions select: [ :p | p isJocker ]) size = 1
		ifTrue: [ withJocker := false ] .
	^ self
]

{ #category : 'accessing' }
Tirage >> withJocker [
	^withJocker ifNil: [ withJocker := true ]

]

{ #category : 'accessing' }
Tirage >> withJocker: anObject [
	withJocker := anObject
]
