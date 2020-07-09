Je modèlise un pion du jeu .
Je suis une lettre qui a une valeur .
Je suis soit sur le plateau (une case dans la grille), soit entre les mains d'un joueur (a priori un joueur et le robot), soit dans le sac.
	owner = sac, joueur, robot, grille
	sac -1-> (joueur|robot) -2-> grille -3-> (sac|joueur)
		1 : tirageJoueur, tirageRobot
		2 : drag&drop (joueur ou robor)
		3 : nouvellePartie, reprendJoueur