initialization
setBounds
	| x y |
	x := MorphCaseTirage myExtent x.
	y := MorphCaseTirage myExtent y.
	x := 15 * (x + 2) + 8.
	y := 15 * (y + 2) + 8.
	self
		bounds: (0.0 @ 0.0 corner: x @ y);
		color:
			(Color
				r: 0.017
				g: 0.135
				b: 0.005
				alpha: 1.0)