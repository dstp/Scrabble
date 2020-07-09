scrabble
getMPionsWith: desPions
	^ desPions collect: [ :p | 
					| mP |
					mP := self new modele: p.
					p morph: mP.
					mP ]