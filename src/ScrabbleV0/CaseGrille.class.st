"
Je modèlise une case .
Mes différents etats : libre occupée squattée nonLibre .
En fonction de mon état je peux demander le changement d'état d'autres cases .
Moi et mes semblables sommes rangées dans une grille (17 x 17) .
Je connais les cases qui sont sur ma ligne et sur ma colonne
et d'autres choses à définir ...

"
Class {
	#name : 'CaseGrille',
	#superclass : 'CaseTirage',
	#instVars : [
		'valH',
		'valV',
		'd',
		'g',
		'h',
		'b'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
CaseGrille class >> asFiltre: ar [
	| str |
	ar ifNil: [ ^ '.' ].
	ar ifEmpty: [ ^ '#' ].
	str := (ar
		inject: (WriteStream with: '(')
		into: [ :ws :ch | 
			ws
				nextPutAll: ch asString;
				nextPutAll: '|';
				yourself ]) contents.
	str at: str size put: $).
	^ str
]

{ #category : 'accessing' }
CaseGrille class >> uneGrille: aG [
	"je renvoie 15*15 cases"

	^ (1 to: 15 * 15)
		collect: [ :n | 
			| str |
			str := n - 1 printStringBase: 15 nDigits: 2.
			self new
				ligne: ('0123456789ABCDEF' indexOf: (str at: 1));
				colonne: ('0123456789ABCDEF' indexOf: (str at: 2));
				whereIs: aG ]
]

{ #category : 'converting' }
CaseGrille >> asFiltreH [
	
	^ self etat = 'O'
		ifTrue: [ self pion nom ]
		ifFalse: [ self class asFiltre: self valH ]
]

{ #category : 'converting' }
CaseGrille >> asFiltreV [
	^ self etat = 'O'
		ifTrue: [ self pion nom ]
		ifFalse: [ self class asFiltre: self valV ]
]

{ #category : 'accessing' }
CaseGrille >> b [
	"la case en dessous ou une case horsJeu"

	^ b
		ifNil: [ b := self ligne >= 15
				ifTrue: [ self class new
						ligne: 16;
						colonne: self colonne;
						whereIs: self whereIs ]
				ifFalse: [ self whereIs atPoint: self asPoint + (0 @ 1) ] ]
]

{ #category : 'bonus' }
CaseGrille >> bonusKey [
	^ self ligne asString , ':' , self colonne asString.
]

{ #category : 'bonus' }
CaseGrille >> bonusLettre [
	^ {('2:6' -> 3).
	('2:10' -> 3).
	('6:2' -> 3).
	('6:6' -> 3).
	('6:10' -> 3).
	('6:14' -> 3).
	('10:2' -> 3).
	('10:6' -> 3).
	('10:10' -> 3).
	('10:14' -> 3).
	('14:6' -> 3).
	('14:10' -> 3).
	('1:4' -> 2).
	('1:12' -> 2).
	('3:7' -> 2).
	('3:9' -> 2).
	('4:1' -> 2).
	('4:8' -> 2).
	('4:15' -> 2).
	('7:3' -> 2).
	('7:7' -> 2).
	('7:9' -> 2).
	('7:13' -> 2).
	('8:4' -> 2).
	('8:12' -> 2).
	('9:3' -> 2).
	('9:7' -> 2).
	('9:9' -> 2).
	('9:13' -> 2).
	('12:1' -> 2).
	('12:8' -> 2).
	('12:15' -> 2).
	('13:7' -> 2).
	('13:9' -> 2).
	('15:4' -> 2).
	('15:12' -> 2)
	
	
	
	
	
	} asDictionary
]

{ #category : 'bonus' }
CaseGrille >> bonusMot [
	^ {('1:1' -> 3).
	('1:8' -> 3).
	('1:15' -> 3).
	('8:1' -> 3).
	('8:15' -> 3).
	('15:1' -> 3).
	('15:8' -> 3).
	('15:15' -> 3).
	('2:2' -> 2).
	('3:3' -> 2).
	('4:4' -> 2).
	('5:5' -> 2).
	('8:8' -> 2).
	('11:11' -> 2).
	('12:12' -> 2).
	('13:13' -> 2).
	('14:14' -> 2).
	('2:14' -> 2).
	('3:13' -> 2).
	('4:12' -> 2).
	('5:11' -> 2).
	('11:5' -> 2).
	('12:4' -> 2).
	('13:3' -> 2).
	('14:2' -> 2)} asDictionary
]

{ #category : 'accessing' }
CaseGrille >> couleur [
	| coul |
	coul := self bonusMot at: self bonusKey ifAbsent: [ 0 ].
	^ coul := coul = 0
		ifTrue: [ self bonusLettre at: self bonusKey ifAbsent: [ 1 ] ]
		ifFalse: [ coul + 2 ]
]

{ #category : 'accessing' }
CaseGrille >> croix [
	"
	(aGrille croix: aPoint) = aCase croix 
	"
	^ (Set new
		add: self b;
		add: self h;
		add: self d;
		add: self g;
		yourself) reject: [ :aC | aC isHorsJeu ]
]

{ #category : 'accessing' }
CaseGrille >> d [
	"la case à droite ou une case horsJeu"

	^ d
		ifNil: [ d := self colonne >= 15
				ifTrue: [ self class new
						colonne: 16;
						ligne: self ligne ;
						whereIs: self whereIs]
				ifFalse: [ d := self whereIs atPoint: self asPoint + (1 @ 0) ] ]
]

{ #category : 'accessing' }
CaseGrille >> firstG [
	"
	je retourne la plus en haut des cases non vide 
	"

	| cg |
	cg := self g.
	[cg isHorsJeu or: [ cg isEmpty ]] whileFalse: [ cg := cg g ].
	^ cg d
]

{ #category : 'accessing' }
CaseGrille >> firstH [
	"
	je retourne la plus en haut des cases non vide 
	"

	| ch |
	ch := self h.
	[ ch isHorsJeu or: [ ch isEmpty ] ] whileFalse: [ ch := ch h ].
	^ ch b
]

{ #category : 'accessing' }
CaseGrille >> g [
	"la case à gauche ou une case horsJeu"

	^ g
		ifNil: [ g := self colonne <= 1
				ifTrue: [ self class new
						colonne: 0;
						ligne: self ligne;
						whereIs: self whereIs ]
				ifFalse: [ self whereIs atPoint: self asPoint + (-1 @ 0) ] ]
]

{ #category : 'accessing' }
CaseGrille >> h [
	"la case au dessus ou une case HorsJeu"

	^ h
		ifNil: [ h := self ligne <= 1
				ifTrue: [ self class new
						ligne: 0;
						colonne: self colonne;
						whereIs: self whereIs ]
				ifFalse: [ self whereIs atPoint: self asPoint + (0 @ -1) ] ]
]

{ #category : 'testing' }
CaseGrille >> isHorsJeu [
	"une case en dehors de la grille"

	^ self isNotHorsJeu not
]

{ #category : 'testing' }
CaseGrille >> isNotHorsJeu [
	"une case en dehors de la grille"

	^ (self ligne between: 1 and: 15) and: [ self colonne between: 1 and: 15  ]
]

{ #category : 'accessing' }
CaseGrille >> lastB [
	"
	je retourne la plus en bas des cases non vide 
	"

	| cb |
	cb := self b.
	[ cb isHorsJeu or: [ cb isEmpty ] ] whileFalse: [ cb := cb b ].
	^ cb h
]

{ #category : 'accessing' }
CaseGrille >> lastD [
	"
	je retourne la plus à droite des cases non vide 
	"

	| cd |
	cd := self d.
	[ cd isHorsJeu or: [ cd isEmpty ] ] whileFalse: [ cd := cd d ].
	^ cd g
]

{ #category : 'accessing' }
CaseGrille >> setVal [
	"
	valH et valV -> nil, ou ensemble de lettres permettant de former des mots dans le sens horizontal et vertical
	"

	self
		setValH;
		setValV.
	^ self
]

{ #category : 'accessing' }
CaseGrille >> setValH [
	"
	J'initialise valH avec un set des lettres permettant de construire des mots dans le sens vertical  
	"

	| oC |
	self valH: nil.
	oC := self whereIs getCasesMotV: (Array with: self).
	oC
		ifNotEmpty: [ | lettres |
			lettres := self setValLettres: oC.
			self valH: lettres ].
	^ valH
]

{ #category : 'accessing' }
CaseGrille >> setValLettres: oC [
	" 
	Je retourne l'ensemble des lettres qui permettent de construire des mots
	"

	| ind |
	ind := oC indexOf: self.
	oC at: ind put: Pion unPionPoint.
	^ (Scrabble
		motsAvecLettresEtJockers: '*'
		filtre: (self jeu class asByteString: oC)) collect: [ :m | m at: ind ]
]

{ #category : 'accessing' }
CaseGrille >> setValV [
	"
	J'initialise valV avec un set des lettres permettant de construire des mots dans le sens horizontal  
	"

	| oC |
	self valV: nil.
	oC := self whereIs getCasesMotH: (Array with: self).
	oC
		ifNotEmpty: [ | lettres |
			lettres := self setValLettres: oC.
			self valV: lettres ].
	^ valV
]

{ #category : 'accessing' }
CaseGrille >> valH [
	^ valH
]

{ #category : 'accessing' }
CaseGrille >> valH: anObject [
	"a Set avec les lettres autorisées pour un mot horizontal"
	valH := anObject
]

{ #category : 'accessing' }
CaseGrille >> valV [
	^ valV
]

{ #category : 'accessing' }
CaseGrille >> valV: anObject [
	"a Set avec les lettres autorisées pour un mot vertical"
	valV := anObject
]
