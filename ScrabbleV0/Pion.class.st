"
Je modèlise un pion du jeu .
Je suis une lettre qui a une valeur .
Je suis soit sur le plateau (une case dans la grille), soit entre les mains d'un joueur (a priori un joueur et le robot), soit dans le sac.
	owner = sac, joueur, robot, grille
	sac -1-> (joueur|robot) -2-> grille -3-> (sac|joueur)
		1 : tirageJoueur, tirageRobot
		2 : drag&drop (joueur ou robor)
		3 : nouvellePartie, reprendJoueur
"
Class {
	#name : 'Pion',
	#superclass : 'Object',
	#instVars : [
		'lettre',
		'valeur',
		'morph',
		'owner',
		'jocker',
		'whereIs'
	],
	#classInstVars : [
		'pions',
		'dictDesLettres'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'scrabble' }
Pion class >> frequencePour: uneLettre [
	^ (self lesLettres at: uneLettre ifAbsent: [ #(0 0) ]) at: 2
]

{ #category : 'accessing' }
Pion class >> getPions [
	| unJeuDePions |
	unJeuDePions := Set new.
	self lesLettres
		keysDo: [ :let | 
			| val |
			val := self valeurPour: let.
			1 to: (self frequencePour: let) do: [ :i | 
				| pion |
				pion := self new
					lettre: let;
					valeur: val.
				unJeuDePions add: pion ] ].
	^ unJeuDePions
]

{ #category : 'scrabble' }
Pion class >> lesLettres [
	dictDesLettres ifNil: [ 
	 	dictDesLettres := {('A' -> #(1 9)).
	('B' -> #(3 2)).
	('C' -> #(3 2)).
	('D' -> #(2 3)).
	('E' -> #(1 15)).
	('F' -> #(4 2)).
	('G' -> #(2 2)).
	('H' -> #(4 2)).
	('I' -> #(1 8)).
	('J' -> #(8 1)).
	('K' -> #(10 1)).
	('L' -> #(1 5)).
	('M' -> #(2 3)).
	('N' -> #(1 6)).
	('O' -> #(1 6)).
	('P' -> #(3 2)).
	('Q' -> #(8 1)).
	('R' -> #(1 6)).
	('S' -> #(1 6)).
	('T' -> #(1 6)).
	('U' -> #(1 6)).
	('V' -> #(4 2)).
	('W' -> #(10 1)).
	('X' -> #(10 1)).
	('Y' -> #(10 1)).
	('Z' -> #(10 1)).
	(' ' -> #(0 2))} asDictionary ] .
	^ dictDesLettres 
]

{ #category : 'accessing' }
Pion class >> nom: aNom [
	^ self pions detect: [ :p | p nom = aNom ]
]

{ #category : 'accessing' }
Pion class >> owner: aOwner [
	^ self pions select: [ :p | p owner = aOwner  ]
]

{ #category : 'accessing' }
Pion class >> pions [
	^ pions ifNil: [ pions := Set new.
			self lesLettres
				keysDo: [ :let | 
					| val |
					val := self valeurPour: let.
					1 to: (self frequencePour: let) do: [ :i | 
						| pion |
						pion := self new
							lettre: let;
							valeur: val.
						pions add: pion ] ]. pions ]
]

{ #category : 'accessing' }
Pion class >> pions: anObject [
	pions := anObject 
]

{ #category : 'accessing' }
Pion class >> unPionJocker [
	^ self new
		lettre: '*';
		valeur: 15
]

{ #category : 'accessing' }
Pion class >> unPionPoint [
	^ self new lettre: '.'; valeur: 15.
]

{ #category : 'scrabble' }
Pion class >> valeurPour: uneLettre [
	^ (self lesLettres at: uneLettre ifAbsent: [ #(0 0)]) at: 1
]

{ #category : 'comparing' }
Pion >> <= aP [
	^ self lettre <= aP lettre
]

{ #category : 'accessing' }
Pion >> grille [ 
	^ self owner jeu grille
]

{ #category : 'testing' }
Pion >> isJocker [
	^ self valeur = 0
]

{ #category : 'accessing' }
Pion >> jocker [
	^ jocker ifNil: [ jocker := ' ' ]
]

{ #category : 'accessing' }
Pion >> jocker: anObject [
	jocker := anObject
]

{ #category : 'accessing' }
Pion >> lettre [
	^ self valeur = 0
		ifTrue: [ self jocker ]
		ifFalse: [ lettre ]
]

{ #category : 'accessing' }
Pion >> lettre: anObject [
	lettre := anObject
]

{ #category : 'accessing' }
Pion >> morph [
	^ morph
]

{ #category : 'accessing' }
Pion >> morph: anObject [
	morph := anObject
]

{ #category : 'accessing' }
Pion >> moveTo: aSaTaCG [
	^ aSaTaCG setUnPion: self
]

{ #category : 'accessing' }
Pion >> nom [
	^ self lettre
]

{ #category : 'accessing' }
Pion >> owner [
	^ owner
]

{ #category : 'accessing' }
Pion >> owner: anObject [

	owner := anObject
]

{ #category : 'printing' }
Pion >> printOn: aStream [
	self lettre printOn: aStream
]

{ #category : 'printing' }
Pion >> printString [
	^ self isJocker ifTrue: ['*'] ifFalse: [ self lettre]
]

{ #category : 'accessing' }
Pion >> sac: aSac [
	owner := aSac.
	whereIs := aSac.
]

{ #category : 'accessing' }
Pion >> valeur [
	^ valeur
]

{ #category : 'accessing' }
Pion >> valeur: anObject [
	valeur := anObject
]

{ #category : 'accessing' }
Pion >> validePos [
	self owner: self whereIs owner.
	^ self
]

{ #category : 'accessing' }
Pion >> whereIs [
	^ whereIs
]

{ #category : 'accessing' }
Pion >> whereIs: aCaS [
	self whereIs pion: nil.
	aCaS pion: self.
	whereIs := aCaS.

]
