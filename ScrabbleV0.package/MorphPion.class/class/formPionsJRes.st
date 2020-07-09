scrabble
formPionsJRes
	formPionsJRes ifNotNil: [ ^ formPionsJRes ].
	formPionsJRes := IdentityDictionary new.
	(FileSystem / '/home/dsp/Documents/Scrabble/PionsJ') files
		do: [ :imgFile | 
			"| w |"
			"PNGReadWriter
				putForm: (PNGReadWriter formFromStream: imgFile asFileReference readStream)
				onStream: (w := WriteStream on: ByteArray new)."
			formPionsJRes
				at: imgFile basenameWithoutExtension asSymbol
				put: "w contents base64Encoded"  (ImageReadWriter formFromFileNamed: imgFile )].
	^ formPionsJRes