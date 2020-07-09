menu
getPionsMot: unJoueur
	^ unJoueur getPionsMot: (UIManager default request: 'Votre tirage' initialAnswer: '' title: 'Sasissez vos lettres')