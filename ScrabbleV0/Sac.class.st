"
Je possède tous les pions
"
Class {
	#name : 'Sac',
	#superclass : 'Object',
	#instVars : [
		'morph',
		'jeu'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
Sac >> getPionsMot: unMot [
	"
	A revoir, pourquoi ces valeurs nil ?
	"

	^ unMot asUppercase
		inject: OrderedCollection new
		into: [ :aOC :let | 
			| lstP |
			lstP := (self jeu pionsOwner: self) asArray
				select: [ :p | 
					let = $*
						ifTrue: [ p isJocker ]
						ifFalse: [ p lettre first = let ] ].
			lstP isEmpty
				ifTrue: [ aOC ]
				ifFalse: [ aOC
						add:
							(lstP first
								owner: nil";
								whereIs: nil");
						yourself ] ]
]

{ #category : 'accessing' }
Sac >> getPionsN: n withJ: aBool [
	| desP |
	desP := (self jeu pionsOwner: self) asArray.
	aBool
		ifTrue: [ | desJ |
			desJ := desP select: [ :p | p isJocker ].
			desJ size > 1
				ifTrue: [ desP := desP reject: [ :p | p = desJ first ] ] ]
		ifFalse: [ desP := desP reject: [ :p | p isJocker ] ].
	^ desP shuffle copyFrom: 1 to: (n min: desP size)
]

{ #category : 'initialization' }
Sac >> initializePions [
	self jeu pions
		do: [ :p | 
			p
				sac: self ]
]

{ #category : 'accessing' }
Sac >> jeu [
	^ jeu
]

{ #category : 'accessing' }
Sac >> jeu: anObject [
	jeu := anObject
]

{ #category : 'accessing' }
Sac >> morph [
	^ morph
]

{ #category : 'accessing' }
Sac >> morph: anObject [
	morph := anObject
]

{ #category : 'accessing' }
Sac >> owner [
	^ self
]

{ #category : 'accessing' }
Sac >> pion: anObject [
	"ne fait rien"
]

{ #category : 'accessing' }
Sac >> pions [
	^ self jeu pionsOwner: self 
]

{ #category : 'accessing' }
Sac >> setUnPion: aP [
	aP owner: self.
	aP whereIs: self.
]

{ #category : 'accessing' }
Sac >> size [
	^ self pions size
]

{ #category : 'accessing' }
Sac >> whereIs [
	^ self
]
