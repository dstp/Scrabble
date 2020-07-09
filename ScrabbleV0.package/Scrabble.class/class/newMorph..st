initialization
newMorph: aM
	| aS |
	aS := self new.
	aS morph: aM.
	^ aS