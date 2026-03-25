"
Les cases d'un tirage
- pas de bnus 
"
Class {
	#name : 'CaseTirage',
	#superclass : 'Object',
	#instVars : [
		'pion',
		'morph',
		'ligne',
		'colonne',
		'whereIs'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
CaseTirage class >> unTirage: aT [
	"je renvoie 10 cases ..."

	^ (1 to: 10)
		collect: [ :c | 
			self new
				ligne: 1;
				colonne: c;
				whereIs: aT ]
]

{ #category : 'accessing' }
CaseTirage >> <= aCase [
	^ self ligne < aCase ligne
		or: [ self ligne = aCase ligne
				and: [ self colonne < aCase colonne ] ]
]

{ #category : 'converting' }
CaseTirage >> asPoint [
	^ (self colonne) @ (self ligne)
]

{ #category : 'accessing' }
CaseTirage >> colonne [
	^ colonne
]

{ #category : 'accessing' }
CaseTirage >> colonne: anObject [
	colonne := anObject
]

{ #category : 'accessing' }
CaseTirage >> couleur [
	^ 1
]

{ #category : 'accessing' }
CaseTirage >> etat [
	^ self isEmpty
		ifTrue: [ 'L' ]
		ifFalse: [ 'O' ]
]

{ #category : 'testing' }
CaseTirage >> isEmpty [
	^ pion ifNil: [  true ] ifNotNil: [ false ]
]

{ #category : 'testing' }
CaseTirage >> isNotEmpty [
	^ pion ifNil: [ false ] ifNotNil: [ true ]
]

{ #category : 'accessing' }
CaseTirage >> jeu [
	^ self whereIs jeu
]

{ #category : 'accessing' }
CaseTirage >> ligne [
	^ ligne
]

{ #category : 'accessing' }
CaseTirage >> ligne: anObject [
	ligne := anObject
]

{ #category : 'accessing' }
CaseTirage >> max: aCase [
	^ self max: aCase
]

{ #category : 'accessing' }
CaseTirage >> min: aCase [
	^ self min: aCase
]

{ #category : 'accessing' }
CaseTirage >> morph [
	^ morph
]

{ #category : 'accessing' }
CaseTirage >> morph: anObject [
	morph := anObject
]

{ #category : 'accessing' }
CaseTirage >> nom [
	^ self ligne asString , ':' , self colonne asString
]

{ #category : 'accessing' }
CaseTirage >> owner [
	^ self whereIs
]

{ #category : 'accessing' }
CaseTirage >> pion [
	^ pion
]

{ #category : 'accessing' }
CaseTirage >> pion: anObject [
	pion := anObject.

]

{ #category : 'printing' }
CaseTirage >> printOn: aStream [
	"
	printOn: aStream, printString et asString
	"

	aStream nextPutAll: self asPoint asString;
		nextPutAll: (self pion ifNil: [ '' ] ifNotNil: [ self pion asString ])
	""
]

{ #category : 'printing' }
CaseTirage >> printString [
	^ self isEmpty
		ifTrue: [ '' ]
		ifFalse: [ self pion lettre ]
]

{ #category : 'accessing' }
CaseTirage >> setUnPion: aP [
	aP whereIs: self
]

{ #category : 'accessing' }
CaseTirage >> whereIs [
	^ whereIs
]

{ #category : 'accessing' }
CaseTirage >> whereIs: anObject [
	whereIs := anObject
]
