initialization
setBounds
	| x y |
	x := MorphCaseTirage myExtent x + 2.
	y := MorphCaseTirage myExtent y + 2.
	self
		bounds:
			(self nom = 'robot'
				ifTrue: [ (15 * x) @ 0.0 corner: (16 * x + 8) @ (10 * y + 8) ]
				ifFalse: [ 0.0 @ (15 * y) corner: (10 * x + 8) @ (y + (15 * y + 8)) ])