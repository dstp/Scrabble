no use
d: aCase with: aOC
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				d: aCase d
				with:
					(aOC
						add: aCase;
						yourself) ]