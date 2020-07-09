accessing
unTirage: aT
	"je renvoie 10 cases ..."

	^ (1 to: 10)
		collect: [ :c | 
			self new
				ligne: 1;
				colonne: c;
				whereIs: aT ]