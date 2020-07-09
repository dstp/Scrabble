drawing
afficheNbPions
	self nbPions
		contents:
			((sac modele size + grille modele size + robot modele size
				+ joueur modele size = 102
				ifTrue: [ 'Pions restants : ' , sac modele size asString ]
				ifFalse: [ 'Anomalie de programmation' ]) asText
				addAttribute:
					(TextFontReference
						toFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 12))).
	^ true