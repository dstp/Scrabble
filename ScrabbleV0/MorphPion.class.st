"
Les pions du jeu vue graphique
Mon modèle est un pion
Je suis soit affiché sur le plateau, soit dans la main du joueur.
Les pions de la pioche et de l'ordinateur ne sont pas visualiés.
"
Class {
	#name : 'MorphPion',
	#superclass : 'TransformationMorph',
	#instVars : [
		'modele',
		'face',
		'faceJ'
	],
	#classInstVars : [
		'formPionsRes',
		'formPionsJRes'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'scrabble' }
MorphPion class >> formPion: aNom [
	^ "PNGReadWriter formFromStream: (Base64MimeConverter mimeDecodeToBytes: (self formPionsRes at: aNom asSymbol) readStream)"
	"un autre commentaire"
	self formPionsRes at: aNom asSymbol
]

{ #category : 'scrabble' }
MorphPion class >> formPionJ: aNom [
	^ "PNGReadWriter
		formFromStream: (Base64MimeConverter mimeDecodeToBytes: (self formPionsJRes at: (aNom , 'J') asSymbol) readStream)"
		self formPionsJRes at: (aNom , 'J') asSymbol
]

{ #category : 'scrabble' }
MorphPion class >> formPionsJRes [
	formPionsJRes ifNotNil: [ ^ formPionsJRes ].
	formPionsJRes := IdentityDictionary new.
	(FileSystem / '/home/dsp/Documents/Scrabble/PionsJ') files
		do: [ :imgFile | 
			"| w |"
			"PNGReadWriter
				putForm: (PNGReadWriter formFromStream: imgFile asFileReference readStream)
				onStream: (w := WriteStream on: ByteArray new)."
			formPionsJRes
				at: imgFile basenameWithoutExtension asSymbol
				put: "w contents base64Encoded"  (ImageReadWriter formFromFileNamed: imgFile )].
	^ formPionsJRes
]

{ #category : 'scrabble' }
MorphPion class >> formPionsJRes: nothing [
	formPionsJRes := nothing .

]

{ #category : 'scrabble' }
MorphPion class >> formPionsRes [
	formPionsRes ifNotNil: [ ^ formPionsRes ].
	formPionsRes := IdentityDictionary new.
	(FileSystem / '/home/dsp/Documents/Scrabble/Pions') files
		do: [ :imgFile | 
			"| w |
			PNGReadWriter
				putForm: (PNGReadWriter formFromStream: imgFile asFileReference readStream)
				onStream: (w := WriteStream on: ByteArray new)."
			formPionsRes
				at: imgFile basenameWithoutExtension asSymbol
				put: "w contents base64Encoded " (ImageReadWriter formFromFileNamed: imgFile )].
	^ formPionsRes
]

{ #category : 'scrabble' }
MorphPion class >> getMPionsWith: desPions [
	^ desPions collect: [ :p | 
					| mP |
					mP := self new modele: p.
					p morph: mP.
					mP ]
]

{ #category : 'scrabble' }
MorphPion class >> pionClass [
	^ Pion.
]

{ #category : 'scrabble' }
MorphPion class >> reloadRes [
	formPionsRes := nil.
	formPionsJRes := nil .
	"Hello"
]

{ #category : 'accessing' }
MorphPion >> face [
	^ (self class formPion: self nom)	scaledToSize: MorphCaseGrille myExtent
]

{ #category : 'accessing' }
MorphPion >> face: nothing [
	face := nothing.

]

{ #category : 'accessing' }
MorphPion >> faceJ [
	^ (self class formPionJ: self pion jocker) scaledToSize: MorphCaseGrille myExtent
]

{ #category : 'accessing' }
MorphPion >> faceJ: nothing [
	faceJ := nothing
]

{ #category : 'event handling' }
MorphPion >> handlesMouseDown: anEvent [
	^ true
]

{ #category : 'accessing' }
MorphPion >> modele [
	^ modele
]

{ #category : 'accessing' }
MorphPion >> modele: anObject [
	modele := anObject
]

{ #category : 'event handling' }
MorphPion >> mouseDown: anEvent [
	anEvent hand
		waitForClicksOrDrag: self
		event: anEvent
]

{ #category : 'delegate' }
MorphPion >> nom [
	^ self modele nom
]

{ #category : 'accessing' }
MorphPion >> pion [
	^ modele
]

{ #category : 'accessing' }
MorphPion >> pion: anObject [
	modele := anObject
]

{ #category : 'printing' }
MorphPion >> printOn: aStream [
	self modele printOn: aStream
]

{ #category : 'printing' }
MorphPion >> printString [
	^ self modele printString
]

{ #category : 'accessing' }
MorphPion >> showFace [
	self submorphs isEmpty
		ifTrue: [ self asFlexOf: self face asMorph ]
		ifFalse: [ self firstSubmorph form: self face ].
		^ self
]

{ #category : 'accessing' }
MorphPion >> showFaceJ [
	self submorphs isEmpty
		ifTrue: [ self asFlexOf: self faceJ asMorph ]
		ifFalse: [ self firstSubmorph form: self faceJ ].
		^ self
]

{ #category : 'event handling' }
MorphPion >> startDrag: anEvent [
	self modele owner = self owner owner jeu modele actif
		ifFalse: [ ^ nil ].
	self modele valeur = 0
		ifTrue: [ self modele jocker: ' '.
			self faceJ: nil.
			self showFace ].
	anEvent hand grabMorph: self.
	super startDrag: anEvent
]

{ #category : 'dropping/grabbing' }
MorphPion >> wantsToBeDroppedInto: aMorph [
	^ (aMorph class = MorphCaseGrille
		or: [ aMorph class = MorphCaseTirage	])
		and: [ aMorph modele etat = 'L' ]
]
