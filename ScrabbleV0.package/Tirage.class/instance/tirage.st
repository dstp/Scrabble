accessing
tirage
	^ tirage ifNil: [ tirage := CaseTirage unTirage: self ]