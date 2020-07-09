scrabble
formPionsRes
	formPionsRes ifNotNil: [ ^ formPionsRes ].
	formPionsRes := IdentityDictionary new.
	(FileSystem / '/home/dsp/Documents/Scrabble/Pions') files
		do: [ :imgFile | 
			"| w |
			PNGReadWriter
				putForm: (PNGReadWriter formFromStream: imgFile asFileReference readStream)
				onStream: (w := WriteStream on: ByteArray new)."
			formPionsRes
				at: imgFile basenameWithoutExtension asSymbol
				put: "w contents base64Encoded " (ImageReadWriter formFromFileNamed: imgFile )].
	^ formPionsRes