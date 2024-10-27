"
Des tests
"
Class {
	#name : 'TestScra01',
	#superclass : 'TestScra',
	#classInstVars : [
		'ms'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
TestScra01 class >> resources [
	^ Array with: TestResourceScrabble 
]

{ #category : 'tests' }
TestScra01 >> test001 [
	ms joueur getPionsMot: 'MAXIMUM'.
	ms joueur modele joueAutomate.
	self
		assert: ms joueur modele pts
		equals: 108.
	ms undo.
	self
		assert: ms joueur modele pts
		equals: 0.
	
]

{ #category : 'tests' }
TestScra01 >> test002 [
	ms joueur getPionsMot: 'MAXIMUM'.
	ms joueur modele joueAutomate.
	self
		assert: ms joueur modele pts
		equals: 108.

]

{ #category : 'tests' }
TestScra01 >> test003 [

]

{ #category : 'tests' }
TestScra01 >> test004 [
	ms inspect
]
