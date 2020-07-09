initialization
getDictDesAnagrammes
	dictDesAnagrammes
		ifNil: [ dictDesAnagrammes := (self getDictDesMots keys)
				inject: Dictionary new
				into: [ :id :str | 
					id
						at: str sorted asSymbol
							ifPresent: [ :v | id at: str sorted asSymbol put: v , self sepAsString , str , self sepAsString ]
							ifAbsentPut: [ self sepAsString , str , self sepAsString ];
						yourself ] ].
	^ dictDesAnagrammes