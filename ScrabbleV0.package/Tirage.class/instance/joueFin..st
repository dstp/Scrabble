automate
joueFin: maxVal
	| cases pt |
	"self class info: maxVal."
	pt := self jeu morph point.
	pt
		position:
			(self jeu grille atPoint: (maxVal at: 3) @ (maxVal at: 4)) morph
				position.
	pt
		contents:
			((maxVal at: 1) asString asText
				addAttribute:
					(TextFontReference
						toFont:
							(LogicalFont
								familyName: 'Source Sans Pro'
								pointSize: MorphCaseGrille myExtent y / 3))).	"MorphCase myExtent y / 3"
	pt
		textColor: Color black;
		backgroundColor: Color white.
	pt show.
	self pts: self pts + (maxVal at: 1).
	cases := self jeu grille casesPionsDe: self.
	self jeu
		undo:
			(Array
				with: (cases collect: [ :c | c asPoint ])
				with: self
				with: (Scrabble asByteString: self pions)
				with: (maxVal at: 1)).
	cases select: [ :c | true ] thenDo: [ :c | c pion validePos ].
	self jeu grille setCasesVal.
	"self jeu morph redrawMorph."
	self getPions.
	"self jeu morph redrawMorph."
	self morph world ifNotNil: [ self morph world runStepMethods ].
	self jeu morph redrawMorph.
	self jeu morph refreshWorld.
	self jeu nbPasses: 0