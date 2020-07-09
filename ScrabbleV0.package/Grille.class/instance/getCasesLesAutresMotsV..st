points
getCasesLesAutresMotsV: casesV
	"
	cases ou mot : collection de cases formant un mot, ici vertical
	Je retourne la collection des mots horizontaux à parir de chacune des lettres du mot initial
	"

	^ casesV
		collect: [ :aCase | self getCasesMotH: (Array with: aCase) ]