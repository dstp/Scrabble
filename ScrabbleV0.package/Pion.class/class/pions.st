accessing
pions
	^ pions ifNil: [ pions := Set new.
			self lesLettres
				keysDo: [ :let | 
					| val |
					val := self valeurPour: let.
					1 to: (self frequencePour: let) do: [ :i | 
						| pion |
						pion := self new
							lettre: let;
							valeur: val.
						pions add: pion ] ]. pions ]