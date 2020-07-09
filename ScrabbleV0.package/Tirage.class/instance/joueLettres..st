automate
joueLettres: lettres
	| filtres maxVal first |
	first := self jeu joueur pts + self jeu robot pts = 0.
	lettres ifEmpty: [ ^ Array new ].
	filtres := self jeu grille getFiltreMots: lettres d: true.
	maxVal := self
		maxPointWith: filtres
		initVal:
			(Array
				with: 0
				with: ''
				with: 0
				with: 0
				with: true)
		d: true.
	first
		ifFalse: [ filtres := self jeu grille getFiltreMots: lettres d: false.
			maxVal := self maxPointWith: filtres initVal: maxVal d: false ].
	^ (maxVal at: 1) > 0
		ifTrue: [ Array
				with: (maxVal at: 1)
				with: (maxVal at: 2)
				with: (maxVal at: 3)
				with: (maxVal at: 4)
				with: (maxVal at: 5) ]
		ifFalse: [ Array new ]