generate
generateJPNG
	Pion lesLettres
		keysDo: [ :let | 
			| mPion textLettre  mLettre  |
			mPion := self new
				color: self colorPion;
				toggleCornerRounding.
			textLettre := let asText
				addAttribute: (TextColor color: self colorLettre);
				addAttribute: (TextFontReference toFont: self fontLettre).
			"textValeur := (Pion valeurPour: let) asString asText
				addAttribute: (TextColor color: self colorValeur);
				addAttribute: (TextFontReference toFont: self fontValeur)."
			mLettre := TextMorph new contents: textLettre.
			"mValeur := TextMorph new contents: textValeur."
			mPion addMorphCentered: mLettre.
			"mValeur position: (mPion right - 12) @ (mPion bottom - 18).
			mPion addMorph: mValeur."
			mPion exportAsPNGSilently: 'J.png' ]