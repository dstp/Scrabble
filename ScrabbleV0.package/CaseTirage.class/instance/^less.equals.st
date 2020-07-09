accessing
<= aCase
	^ self ligne < aCase ligne
		or: [ self ligne = aCase ligne
				and: [ self colonne < aCase colonne ] ]