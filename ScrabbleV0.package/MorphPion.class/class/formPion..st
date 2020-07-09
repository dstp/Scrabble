scrabble
formPion: aNom
	^ "PNGReadWriter formFromStream: (Base64MimeConverter mimeDecodeToBytes: (self formPionsRes at: aNom asSymbol) readStream)"
	"un autre commentaire"
	self formPionsRes at: aNom asSymbol