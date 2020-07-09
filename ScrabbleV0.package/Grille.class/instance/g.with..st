no use
g: aCase with: aOC
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				g: aCase g
				with:
					(aOC
						add: aCase;
						yourself) ]