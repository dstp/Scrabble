accessing
croix
	"
	(aGrille croix: aPoint) = aCase croix 
	"
	^ (Set new
		add: self b;
		add: self h;
		add: self d;
		add: self g;
		yourself) reject: [ :aC | aC isHorsJeu ]