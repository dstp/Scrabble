jeuDeScrabble
filtre: unMasque
	" * => (\w*|)
	  . => \w
	  A => A
	 self filtre: 'AB..E*' => ' AB\w\wE(\w*|) ' 
	"

	| temp |
	temp := unMasque trimBoth copyReplaceAll: '*' with: '\w*'.
	temp := temp copyReplaceAll: '.' with: '\w'.
	^ self sepAsString , temp , self sepAsString