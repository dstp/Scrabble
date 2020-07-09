menu
ajouteMots
	^ Scrabble
		ajouteMots: (UIManager default request: 'Ajouter les mots : ' initialAnswer: '' title: 'Sasissez les mots séparés par un espace')