"
Le plateau du jeu
- 15 x 15 MorphCases
- 7 MorphCases pour le joueur
"
Class {
	#name : 'MorphGrille',
	#superclass : 'Morph',
	#instVars : [
		'modele',
		'jeu'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'instance creation' }
MorphGrille class >> new: aMJeu [
	| aG |
	aG := self new.
	aG jeu: aMJeu.
	aG modele: aMJeu modele grille.
	aMJeu modele grille morph: aG.
	aG initializeCases.
	^ aG
]

{ #category : 'accessing' }
MorphGrille >> atPoint: aPoint [
	^ (self modele atPoint: aPoint) morph
]

{ #category : 'accessing' }
MorphGrille >> casesPionsDe: anOwner [
	^ self modele casesPionsDe: anOwner
]

{ #category : 'initialization' }
MorphGrille >> initialize [
	super initialize.
	self setBounds
]

{ #category : 'initialization' }
MorphGrille >> initializeCases [
	self modele cases
		do: [ :aCase | 
			| aMorph |
			aMorph := MorphCaseGrille new modele: aCase.
			aCase morph: aMorph.
			self addMorph: aMorph showDos ]
]

{ #category : 'accessing' }
MorphGrille >> jeu [
	^ jeu
]

{ #category : 'accessing' }
MorphGrille >> jeu: anObject [
	jeu := anObject
]

{ #category : 'accessing' }
MorphGrille >> lockCasesO [
	^ self modele casesO
		select: [ :c | true ]
		thenDo: [ :c | c morph lock: true ]
]

{ #category : 'accessing' }
MorphGrille >> modele [
	^ modele
]

{ #category : 'accessing' }
MorphGrille >> modele: anObject [
	modele := anObject
]

{ #category : 'drawing' }
MorphGrille >> redraw [
	self setBounds.
	self position: self jeu position + (10 @ 50).
	self submorphs sorted
		do: [ :m | 
			| aPoint |
			m redraw.
			aPoint := m modele ligne @ m modele colonne.
			m
				left: self left + 5 + ((aPoint y - 1) * (m width + 2));
				top: self top + 5 + ((aPoint x - 1) * (m height + 2)).
			self addMorphFront: m ].
	self
		submorphsDo: [ :m | 
			m
				removeAllMorphs;
				getMorphPion ]
]

{ #category : 'initialization' }
MorphGrille >> setBounds [
	| x y |
	x := MorphCaseTirage myExtent x.
	y := MorphCaseTirage myExtent y.
	x := 15 * (x + 2) + 8.
	y := 15 * (y + 2) + 8.
	self
		bounds: (0.0 @ 0.0 corner: x @ y);
		color:
			(Color
				r: 0.017
				g: 0.135
				b: 0.005
				alpha: 1.0)
]

{ #category : 'accessing' }
MorphGrille >> unlockCases [
	^ self modele cases select: [ :c | true ] thenDo: [ :c | c morph lock: false ]
]
