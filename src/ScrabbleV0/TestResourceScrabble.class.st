"
test sur les test
"
Class {
	#name : 'TestResourceScrabble',
	#superclass : 'TestResource',
	#instVars : [
		'ms'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
TestResourceScrabble >> ms [
	^ ms
]

{ #category : 'accessing' }
TestResourceScrabble >> ms: anObject [
	ms := anObject
]

{ #category : 'initialization' }
TestResourceScrabble >> setUp [
	super setUp.
	ms ifNil: [ms := MorphScrabble new ].
]
