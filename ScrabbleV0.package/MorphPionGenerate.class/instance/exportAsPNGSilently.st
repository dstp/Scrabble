as yet unclassified
exportAsPNGSilently
	| fName |
	fName := self externalFileName , '.png'.
	PNGReadWriter
		putForm: self imageForm
		onFileNamed: fName