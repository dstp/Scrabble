"
Je suis utile uniquement pour créer les images des pions 
exportAsPNG
Les images stockées sous /home/dsp/Documents/Scrabble/Poins/*.png sont exploitées par :
MorphPion class  formPionsRes.
MorphPion  class formPion: nom.
MorphPion face.
MorphPion showFace.
"
Class {
	#name : 'MorphPionGenerate',
	#superclass : 'Morph',
	#classInstVars : [
		'fontLettre',
		'fontValeur',
		'colorLettre',
		'colorValeur',
		'colorPion'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'generate' }
MorphPionGenerate class >> colorLettre [
	colorLettre ifNil: [ self setColorLettre ].
	^ colorLettre
]

{ #category : 'generate' }
MorphPionGenerate class >> colorPion [
	colorPion ifNil: [ self setColorPion ].
	^ colorPion
]

{ #category : 'generate' }
MorphPionGenerate class >> colorSelector: title [
	^ UIManager default chooseColor: Color black title: title
]

{ #category : 'generate' }
MorphPionGenerate class >> colorValeur [
	colorValeur ifNil: [ self setColorValeur ].
	^ colorValeur
]

{ #category : 'generate' }
MorphPionGenerate class >> fontLettre [
	^ fontLettre ifNil: [ fontLettre := self setFontLettre ].

]

{ #category : 'generate' }
MorphPionGenerate class >> fontSelector: aTitle [
	^ UIManager default chooseFont: nil "title: aTitle"
]

{ #category : 'generate' }
MorphPionGenerate class >> fontValeur [
	fontValeur ifNil: [ self setFontValeur ].
	^ fontValeur
]

{ #category : 'generate' }
MorphPionGenerate class >> generateJPNG [
	Pion lesLettres
		keysDo: [ :let | 
			| mPion textLettre  mLettre  |
			mPion := self new
				color: self colorPion;
				toggleCornerRounding.
			textLettre := let asText
				addAttribute: (TextColor color: self colorLettre);
				addAttribute: (TextFontReference toFont: self fontLettre).
			"textValeur := (Pion valeurPour: let) asString asText
				addAttribute: (TextColor color: self colorValeur);
				addAttribute: (TextFontReference toFont: self fontValeur)."
			mLettre := TextMorph new contents: textLettre.
			"mValeur := TextMorph new contents: textValeur."
			mPion addMorphCentered: mLettre.
			"mValeur position: (mPion right - 12) @ (mPion bottom - 18).
			mPion addMorph: mValeur."
			mPion exportAsPNGSilently: 'J.png' ]
]

{ #category : 'generate' }
MorphPionGenerate class >> generatePNG [
	Pion lesLettres
		keysDo: [ :let | 
			| mPion textLettre textValeur mLettre mValeur |
			mPion := self new
				color: self colorPion;
			
				toggleCornerRounding.
			mPion 	extent: mPion width @ mPion width.
			textLettre := let asText
				addAttribute: (TextColor color: self colorLettre);
				addAttribute: (TextFontReference toFont: self fontLettre).
			textValeur := (Pion valeurPour: let) asString asText
				addAttribute: (TextColor color: self colorValeur);
				addAttribute: (TextFontReference toFont: self fontValeur).
			mLettre := TextMorph new contents: textLettre.
			mValeur := TextMorph new contents: textValeur.
			mPion addMorphCentered: mLettre.
			mValeur position: (mPion right - 12) @ (mPion bottom - 18).
			mPion addMorph: mValeur.
			mPion exportAsPNGSilently ]
]

{ #category : 'generate' }
MorphPionGenerate class >> setColorAndFont [
	self setColorPion .
	self setColorLettre .
	self setColorValeur .
	self setFontLettre .
	self setFontValeur .
]

{ #category : 'generate' }
MorphPionGenerate class >> setColorLettre [
	colorLettre := self colorSelector: 'Couleur des lettres'
]

{ #category : 'generate' }
MorphPionGenerate class >> setColorPion [
	colorPion := self colorSelector: 'Couleur des pions'
]

{ #category : 'generate' }
MorphPionGenerate class >> setColorValeur [
	colorValeur := self colorSelector: 'Couleur des valeurs'
]

{ #category : 'generate' }
MorphPionGenerate class >> setFontLettre [
	^ fontLettre := self fontSelector: 'font : lettre des pions'
]

{ #category : 'generate' }
MorphPionGenerate class >> setFontValeur [
	fontValeur := self fontSelector: 'font : valeur des pions'
]

{ #category : 'as yet unclassified' }
MorphPionGenerate >> exportAsPNGSilently [
	| fName |
	fName := self externalFileName , '.png'.
	PNGReadWriter
		putForm: self imageForm
		onFileNamed: fName
]

{ #category : 'as yet unclassified' }
MorphPionGenerate >> exportAsPNGSilently: ext [
	| fName |
	fName := self externalFileName , ext.
	PNGReadWriter putForm: self imageForm onFileNamed: fName
]

{ #category : 'viewer' }
MorphPionGenerate >> externalFileName [
	^ '/home/dsp/Documents/Scrabble/Pions/' , self lastSubmorph asText asString
]
