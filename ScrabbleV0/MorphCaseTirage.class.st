"
- Gestion différente pour le drag&drop
"
Class {
	#name : 'MorphCaseTirage',
	#superclass : 'Morph',
	#instVars : [
		'dos',
		'modele'
	],
	#classVars : [
		'myExtent'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
MorphCaseTirage class >> couleurPour: aInt [
	^ self dicoCouleur at: aInt ifAbsent: [ Color black ]
]

{ #category : 'accessing' }
MorphCaseTirage class >> dicoCouleur [
	^ {(1
		->
			(Color r: 0.712 g: 0.736 b: 0.736 alpha: 1.0)).
	(2
		->
			(Color
				r: 0.438
				g: 0.979
				b: 0.9570000000000001
				alpha: 1.0)).
	(3
		->
			(Color
				r: 0.089
				g: 0.079
				b: 0.851
				alpha: 1.0)).
	(4
		->
			(Color
				r: 0.986
				g: 0.401
				b: 0.759
				alpha: 1.0)).
	(5
		->
			(Color
				r: 0.891
				g: 0.035
				b: 0.035
				alpha: 1.0))} asDictionary
]

{ #category : 'accessing' }
MorphCaseTirage class >> modele [
	^ CaseTirage
]

{ #category : 'accessing' }
MorphCaseTirage class >> myExtent [
	^ myExtent ifNil: [ myExtent :=  50@44]
]

{ #category : 'accessing' }
MorphCaseTirage class >> myExtent: aPoint [
	myExtent := ((MorphPion formPionsRes at: #M) scaledToSize: aPoint) extent
]

{ #category : 'comparing' }
MorphCaseTirage >> <= aMCase [
	^ self modele <= aMCase modele
]

{ #category : 'change reporting' }
MorphCaseTirage >> addedMorph: aMorphPion [
	"
	"
	aMorphPion showFace .
	aMorphPion position: self position.
	self owner jeu updateModele
		ifTrue: [ aMorphPion modele moveTo: self modele	]
]

{ #category : 'event handling' }
MorphCaseTirage >> click: anEvent [
	"right click"

	self yellowButtonActivity: anEvent shiftPressed
]

{ #category : 'delegate' }
MorphCaseTirage >> colonne [
	^ self modele colonne
]

{ #category : 'accessing' }
MorphCaseTirage >> dos [
	^ dos ifNil: [ dos := self class couleurPour: self modele couleur ]
]

{ #category : 'delegate' }
MorphCaseTirage >> etat [
	^ self modele etat
]

{ #category : 'change reporting' }
MorphCaseTirage >> getMorphPion [
	| p |
	self isNotEmpty
		ifFalse: [ ^ self ].
	p := self modele pion.
	p isJocker
		ifTrue: [ p jocker: ' '.
 ].
 self addMorphFront: p morph showFace 
]

{ #category : 'event handling' }
MorphCaseTirage >> handlesMouseDown: anEvent [
	^ true
]

{ #category : 'initialization' }
MorphCaseTirage >> initialize [
	super initialize .
	self extent: self class myExtent 
]

{ #category : 'testing' }
MorphCaseTirage >> isEmpty [
	^ self modele isEmpty
]

{ #category : 'testing' }
MorphCaseTirage >> isNotEmpty [
	^ self modele isNotEmpty
]

{ #category : 'delegate' }
MorphCaseTirage >> ligne [
	^ self modele ligne
]

{ #category : 'accessing' }
MorphCaseTirage >> modele [
	^ modele
]

{ #category : 'accessing' }
MorphCaseTirage >> modele: anObject [
	modele := anObject
]

{ #category : 'event handling' }
MorphCaseTirage >> mouseDown: anEvent [
	anEvent hand waitForClicksOrDrag: self event: anEvent
]

{ #category : 'delegate' }
MorphCaseTirage >> nom [
	^ self modele nom
]

{ #category : 'printing' }
MorphCaseTirage >> printOn: aStream [
	self modele printOn: aStream
]

{ #category : 'printing' }
MorphCaseTirage >> printString [
	^ self modele printString
]

{ #category : 'drawing' }
MorphCaseTirage >> redraw [
	self extent: self class myExtent .
	(self submorphs isEmpty and: [ self isNotEmpty ])
		ifTrue: [ self getMorphPion ]
]

{ #category : 'submorphs-add/remove' }
MorphCaseTirage >> removedMorph: aMorph [
	self owner jeu updateModele
		ifTrue: [  ]
]

{ #category : 'drawing' }
MorphCaseTirage >> showDos [
	self color: self dos.
]

{ #category : 'dropping/grabbing' }
MorphCaseTirage >> wantsDroppedMorph: aMorph event: anEvent [
	^ self modele etat = 'L' and: [ aMorph class = MorphPion and: [ aMorph modele owner ~= self owner jeu grille modele ] ]
]

{ #category : 'menu' }
MorphCaseTirage >> wantsYellowButtonMenu [
	"Answer true if the receiver wants a yellow button menu"

	^ true
]

{ #category : 'event handling' }
MorphCaseTirage >> yellowButtonActivity: shiftKeyState [
	self wantsYellowButtonMenu
		ifFalse: [ ^ false ].

	(self owner jeu getMenu: shiftKeyState)
		ifNotNil: [ :menu | 
			menu setInvokingView: self.
			menu popUpEvent: self activeHand lastEvent in: self world.
			^ true ].
	^ true
]
