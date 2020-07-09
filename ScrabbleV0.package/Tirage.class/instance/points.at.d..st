automate
points: aMot at: aPoint d: aBool
	"on me propose de poser aMot sur la grille en partant de aPoint vers la droite (aBool = true) ou vers le bas"

	| p |
	p := 0.
	"setPions"
	self
		setLesMPionsFor: aMot
		at: aPoint
		d: aBool
		move: false.
	p := self jeu grille pointsTotal: self.
	self unsetLesPions.
	^ p