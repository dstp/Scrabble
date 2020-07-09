dropping/grabbing
wantsDroppedMorph: aMorph event: anEvent
	^ self modele etat = 'L' and: [ aMorph class = MorphPion and: [ aMorph modele owner ~= self owner jeu grille modele ] ]