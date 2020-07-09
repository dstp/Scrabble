accessing
lastB
	"
	je retourne la plus en bas des cases non vide 
	"

	| cb |
	cb := self b.
	[ cb isHorsJeu or: [ cb isEmpty ] ] whileFalse: [ cb := cb b ].
	^ cb h