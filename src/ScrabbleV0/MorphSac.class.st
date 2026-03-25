"
un sac
"
Class {
	#name : 'MorphSac',
	#superclass : 'Morph',
	#instVars : [
		'jeu',
		'modele'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'instance creation' }
MorphSac class >> new: aMJeu [
	| aSac |
	aSac := self new.
	aSac jeu: aMJeu.
	aSac modele: aMJeu modele sac.
	aMJeu modele sac morph: aSac.
	^ aSac
]

{ #category : 'tests' }
MorphSac >> getPion: aLet [
	"Pour les tests on aura besoin de positionner des pions sur la grille"

	^ self jeu pions
		detect: [ :mp | mp nom = aLet and: [ mp modele owner = self modele ] ] ifNone: [ nil ]
]

{ #category : 'initialization' }
MorphSac >> initializePions [
	self jeu pions
		do: [ :p | 
			p pion isJocker
				ifTrue: [ p pion jocker: ' ' ].
			self addMorph: p ]
]

{ #category : 'accessing' }
MorphSac >> jeu [
	^ jeu
]

{ #category : 'accessing' }
MorphSac >> jeu: anObject [
	jeu := anObject
]

{ #category : 'accessing' }
MorphSac >> modele [
	^ modele
]

{ #category : 'accessing' }
MorphSac >> modele: anObject [
	modele := anObject
]

{ #category : 'tests' }
MorphSac >> mot: aMot atPoint: aPoint d: aBool [
	"Pour les tests on aura besoin de positionner des mots sur la grille"

	| aMPion aCase aDict |
	aDict := Dictionary new.
	aCase := self jeu grille modele atPoint: aPoint.
	aMot
		do: [ :aChar | 
			(aCase isHorsJeu or: [ aCase isNotEmpty ])
				ifTrue: [ UIManager default inform: 'Case indisponible'.
					^ self ].
			aMPion := self getPion: aChar asString.
			aMPion
				ifNotNil: [ 
					aDict at: aCase put: aMPion.
					aCase := aBool
						ifTrue: [ aCase d ]
						ifFalse: [ aCase b ] ]
				ifNil: [ UIManager inform: 'Pion indisponible'.
					^ self ] ].
	aDict associationsDo: [  :ass | 
		ass value modele owner: ass key whereIs.
		ass key morph addMorph: ass value 
		]
]

{ #category : 'delegate' }
MorphSac >> pions [
	^ self modele pions
]
