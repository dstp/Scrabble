scrabble
formPionJ: aNom
	^ "PNGReadWriter
		formFromStream: (Base64MimeConverter mimeDecodeToBytes: (self formPionsJRes at: (aNom , 'J') asSymbol) readStream)"
		self formPionsJRes at: (aNom , 'J') asSymbol