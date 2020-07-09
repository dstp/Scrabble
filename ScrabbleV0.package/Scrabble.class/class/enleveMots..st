dico
enleveMots: unOuDesMots
	unOuDesMots substrings
		select: [ :unMot | unMot isNotEmpty ]
		thenDo: [ :unMot | self dictDesMots removeKey: unMot asUppercase ifAbsent: [ nil ] ].
		self dictDesAnagrammes: nil .
	self dictDesMotsKeys: nil.