drawing
afficheScores
	ptJ position: joueur topRight + (10 @ 0).
	ptR position: joueur topRight + (10 @ (MorphCaseGrille myExtent y / 2)).
	self ptJ
		contents:
			(('Score joueur : ' , joueur modele pts asString) asText
				addAttribute:
					(TextFontReference
						toFont:
							(LogicalFont
								familyName: 'Source Sans Pro'
								pointSize: MorphCaseGrille myExtent y / 3))).
	self ptR
		contents:
			(('Score robot   : ' , robot modele pts asString) asText
				addAttribute:
					(TextFontReference
						toFont:
							(LogicalFont
								familyName: 'Source Sans Pro'
								pointSize: MorphCaseGrille myExtent y / 3))).
	^ true