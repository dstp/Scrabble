accessing
couleurPour: aInt
	^ self dicoCouleur at: aInt ifAbsent: [ Color black ]