no use
b: aCase with: aOC
" a Ordered Collection des cases adjacentes avec un pion"
	^ aCase isEmpty
		ifTrue: [ aOC ]
		ifFalse: [ self
				b: aCase b
				with:
					(aOC
						add: aCase;
						yourself) ]