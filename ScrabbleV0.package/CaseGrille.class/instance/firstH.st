accessing
firstH
	"
	je retourne la plus en haut des cases non vide 
	"

	| ch |
	ch := self h.
	[ ch isHorsJeu or: [ ch isEmpty ] ] whileFalse: [ ch := ch h ].
	^ ch b