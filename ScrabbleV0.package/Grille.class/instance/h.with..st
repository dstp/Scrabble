no use
h: aCase with: aOC
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				h: aCase h
				with:
					(aOC
						add: aCase;
						yourself) ]