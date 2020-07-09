points
getCasesLesAutresMotsH: casesH
	"
	cases ou mot : collection de cases formant un mot, ici horizontal
	Je retourne la collection des mots verticaux à parir de chacune des lettres du mot initial
	"

	^ casesH
		collect: [ :aCase | self getCasesMotV: (Array with: aCase) ]