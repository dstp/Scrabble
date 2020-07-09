menu
unMenuMorph
	| menu smD |
	menu := MenuMorph new.
	smD := MenuMorph new.
	smD add: 'Refile moi mes pions' target: self selector: #getPions.
	smD
		add: 'Joue !'
		target: self modele actif
		selector: #joueAutomate.
	menu add: 'Validation' target: self selector: #validePions.
	smD add: 'Aide ?' target: self selector: #joueAide.
	smD add: 'Scrabble ?' target: self selector: #existeScrabble.
	smD add: 'Undo' target: self selector: #undo.
	menu add: 'Nouvelle Partie' target: self selector: #nouvellePartie.
	menu add: 'Actions' translated subMenu: smD.
	smD := MenuMorph new.
	smD
		add: 'Joueur manuel'
		target: self modele joueur
		selector: #manuel:
		argument: true.
	smD
		add: 'Joueur automatique'
		target: self modele joueur
		selector: #manuel:
		argument: false.
	smD
		add: 'Robot manuel'
		target: self modele robot
		selector: #manuel:
		argument: true.
	smD
		add: 'Robot automatique'
		target: self modele robot
		selector: #manuel:
		argument: false.
	menu add: 'Qui joue ?' translated subMenu: smD.
	smD := MenuMorph new.
	smD
		add: 'Saisir les lettres du joueur'
		target: self
		selector: #getPionsMot:
		argument: joueur.
	smD
		add: 'Saisir les lettres du robot'
		target: self
		selector: #getPionsMot:
		argument: robot.
	smD
		add: 'Changer de tirage joueur'
		target: self
		selector: #changeTirage:
		argument: joueur.
	smD
		add: 'Changer de tirage robot'
		target: self
		selector: #changeTirage:
		argument: robot.
	menu add: 'Tirage' translated subMenu: smD.
	smD := MenuMorph new.
	smD add: 'Ajouter des mots' target: self selector: #ajouteMots.
	smD
		add: 'Retirer des mots'
		target: self modele actif
		selector: #enleveMots.
	smD
		add: 'Sauvegarder le dictionnaire'
		target: Scrabble
		selector: #savDictDesMots.
	menu add: 'Dictionnaire' translated subMenu: smD.
	^ menu