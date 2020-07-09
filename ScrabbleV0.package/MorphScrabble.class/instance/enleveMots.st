menu
enleveMots
	^ Scrabble
		enleveMots: (UIManager default request: 'Retirer les mots : ' initialAnswer: '' title: 'Sasissez les mots séparés par un espace')