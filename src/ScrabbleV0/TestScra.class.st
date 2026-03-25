"
Des tests

"
Class {
	#name : 'TestScra',
	#superclass : 'TestCase',
	#instVars : [
		'ms'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'initialization' }
TestScra >> setUp [
	ms := TestResourceScrabble current ms.
	ms joueur modele manuel: true.
	ms robot modele manuel: true.
]

{ #category : 'initialization' }
TestScra >> tearDown [
	ms ifNotNil: [ ms delete ].
]
