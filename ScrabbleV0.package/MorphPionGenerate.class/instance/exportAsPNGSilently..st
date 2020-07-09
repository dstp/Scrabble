as yet unclassified
exportAsPNGSilently: ext
	| fName |
	fName := self externalFileName , ext.
	PNGReadWriter putForm: self imageForm onFileNamed: fName