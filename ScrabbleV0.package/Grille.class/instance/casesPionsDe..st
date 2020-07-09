accessing
casesPionsDe: aOwner
	"
	je retourne les cases de ma grille occupées par les pions du joueur aOwner (ses pions n'ont pas été validés)
	"

	^ self grille
		select: [ :aC | aC isNotEmpty and: [ aC pion owner = aOwner ] ]