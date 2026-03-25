"
- 7 MorphCases pour le joueur
"
Class {
	#name : 'MorphTirage',
	#superclass : 'Morph',
	#instVars : [
		'nom',
		'modele',
		'jeu',
		'pts'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
MorphTirage class >> nom: aNom new: aMJeu [
	| aT |
	aT := self new
		nom: aNom;
		setBounds;
		jeu: aMJeu.
	^ aT
]

{ #category : 'accessing' }
MorphTirage >> getPion: aLet [
	"Pour les tests on aura besoin de positionner des pions sur la grille"

	^ self jeu pions
		detect: [ :mp | mp nom = aLet and: [ mp modele owner = self modele ] ]
		ifNone: [ nil ]
]

{ #category : 'accessing' }
MorphTirage >> getPions [
	self modele getPions.
	self jeu updateModele: false.
	self redraw.
	self jeu updateModele: true.
	^ self
]

{ #category : 'accessing' }
MorphTirage >> getPionsMot: unMot [
	self modele givePions.
	self modele getPionsMot: unMot.
	self jeu updateModele: false.
	self redraw.
	self jeu updateModele: true.
	^ self
]

{ #category : 'accessing' }
MorphTirage >> givePions [
	self modele getPions.
	self modele givePions.
	self jeu updateModele: false.
	self redraw.
	self jeu updateModele: true.
	^ self
]

{ #category : 'initialization' }
MorphTirage >> initialize [
	super initialize.
	self
		color:
			(Color
				r: 0.017
				g: 0.135
				b: 0.005
				alpha: 1.0).
	
]

{ #category : 'accessing' }
MorphTirage >> jeu [
	^ jeu
]

{ #category : 'accessing' }
MorphTirage >> jeu: anObject [
	jeu := anObject
]

{ #category : 'accessing' }
MorphTirage >> modele [
	^ modele
]

{ #category : 'accessing' }
MorphTirage >> modele: anObject [
	modele := anObject
]

{ #category : 'initialization' }
MorphTirage >> mot: aMot atPoint: aPoint d: aBool [
	"Pour les tests on aura besoin de positionner des mots sur la grille"

	| aMPion aCase |
	aCase := self jeu grille modele atPoint: aPoint.
	aMot
		do: [ :aChar | 
			(aCase isHorsJeu or: [ aCase isNotEmpty ])
				ifTrue: [ UIManager default inform: 'Case indisponible'.
					^ self ].
			aMPion := self getPion: aChar asString.
			aMPion
				ifNotNil: [ aMPion modele owner: aCase whereIs.
					aCase morph addMorph: aMPion.
					aCase := aBool
						ifTrue: [ aCase d ]
						ifFalse: [ aCase b ] ]
				ifNil: [ UIManager inform: 'Pion indisponible'.
					^ self ] ]
]

{ #category : 'accessing' }
MorphTirage >> nom [
	^ nom
]

{ #category : 'accessing' }
MorphTirage >> nom: anObject [
	nom := anObject
]

{ #category : 'printing' }
MorphTirage >> printOn: aStream [
	self nom printOn: aStream.
	(Scrabble asByteString: self submorphs sorted) printOn: aStream
]

{ #category : 'accessing' }
MorphTirage >> pts [
	^ self modele pts
]

{ #category : 'accessing' }
MorphTirage >> pts: anObject [
	self modele pts: anObject
]

{ #category : 'drawing' }
MorphTirage >> redraw [
	self setBounds.
	self nom = 'joueur'
		ifTrue: [self position: self jeu grille bottomLeft + (0 @ 5) ]
		ifFalse: [ self position: self jeu grille topRight + (5 @ 0) ] .
	self submorphs sorted
		do: [ :m | 
			| aPoint |
			m redraw.
			aPoint := 1 @ m modele colonne.
			self nom = 'joueur'
				ifTrue: [ m
						left: self left + 5 + ((aPoint y - 1) * (m width + 2));
						top: self top + 5 + ((aPoint x - 1) * (m height + 2)) ]
				ifFalse: [ m
						left: self left + 5 + ((aPoint x - 1) * (m width + 2));
						top: self top + 5 + ((aPoint y - 1) * (m height + 2)) ].
			self addMorphFront: m ].
	self
		submorphsDo: [ :m | 
			m
				removeAllMorphs;
				getMorphPion ]
]

{ #category : 'initialization' }
MorphTirage >> setBounds [
	| x y |
	x := MorphCaseTirage myExtent x + 2.
	y := MorphCaseTirage myExtent y + 2.
	self
		bounds:
			(self nom = 'robot'
				ifTrue: [ (15 * x) @ 0.0 corner: (16 * x + 8) @ (10 * y + 8) ]
				ifFalse: [ 0.0 @ (15 * y) corner: (10 * x + 8) @ (y + (15 * y + 8)) ])
]

{ #category : 'accessing' }
MorphTirage >> setSubmorphs [
	self modele tirage 
		do: [ :aCase | 
			| aMorph |
			aMorph := MorphCaseTirage new modele: aCase.
			aCase morph: aMorph.
			self addMorph: aMorph showDos ].
		^ self
]
