automate
maxPointWith: filtres initVal: anArray d: aBool
	| max maxM maxX maxY maxD |
	max := anArray at: 1.
	maxM := anArray at: 2.
	maxX := anArray at: 3.
	maxY := anArray at: 4.
	maxD := anArray at: 5.
	filtres
		do: [ :ar | 
			(ar at: 4)
				do: [ :m | 
					| nP |
					m isNotEmpty
						ifTrue: [ nP := self points: m trimBoth at: (ar at: 3) @ (ar at: 2) d: aBool.
							nP > max
								ifTrue: [ max := nP.
									maxM := m.
									maxX := ar at: 3.
									maxY := ar at: 2.
									maxD := aBool ] ] ] ].
	^ Array
		with: max
		with: maxM
		with: maxX
		with: maxY
		with: maxD