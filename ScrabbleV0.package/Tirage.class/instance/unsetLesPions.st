automate
unsetLesPions
	(self jeu grille casesPionsDe: self)
		select: [ :c | true ]
		thenDo: [ :c | c pion moveTo: self ]