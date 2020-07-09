accessing
uneGrille: aG
	"je renvoie 15*15 cases"

	^ (1 to: 15 * 15)
		collect: [ :n | 
			| str |
			str := n - 1 printStringBase: 15 nDigits: 2.
			self new
				ligne: ('0123456789ABCDEF' indexOf: (str at: 1));
				colonne: ('0123456789ABCDEF' indexOf: (str at: 2));
				whereIs: aG ]