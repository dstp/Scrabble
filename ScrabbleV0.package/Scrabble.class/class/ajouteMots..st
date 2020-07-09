dico
ajouteMots: unOuDesMots
	unOuDesMots substrings
		select: [ :unMot | unMot isNotEmpty ]
		thenDo: [ :unMot | self dictDesMots at: unMot asUppercase put: true ].
	self dictDesAnagrammes: nil .
	self dictDesMotsKeys: nil.