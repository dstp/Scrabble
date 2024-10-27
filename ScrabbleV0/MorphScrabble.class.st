"
Le jeu de Scrabble Test UI - Modèle
"
Class {
	#name : 'MorphScrabble',
	#superclass : 'SystemWindow',
	#instVars : [
		'modele',
		'joueur',
		'sac',
		'robot',
		'ptJ',
		'ptR',
		'updateModele',
		'grille',
		'pions',
		'point'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'drawing' }
MorphScrabble >> afficheNbPions [
	self nbPions
		contents:
			((sac modele size + grille modele size + robot modele size
				+ joueur modele size = 102
				ifTrue: [ 'Pions restants : ' , sac modele size asString ]
				ifFalse: [ 'Anomalie de programmation' ]) asText
				addAttribute:
					(TextFontReference
						toFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 12))).
	^ true
]

{ #category : 'drawing' }
MorphScrabble >> afficheScores [
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
]

{ #category : 'menu' }
MorphScrabble >> ajouteMots [
	^ Scrabble
		ajouteMots: (UIManager default request: 'Ajouter les mots : ' initialAnswer: '' title: 'Sasissez les mots séparés par un espace')
]

{ #category : 'menu' }
MorphScrabble >> changeTirage: unJoueur [
	unJoueur givePions.
	^ unJoueur getPions
]

{ #category : 'event handling' }
MorphScrabble >> click: anEvent [
	"right click"

	self yellowButtonActivity: anEvent shiftPressed

	
]

{ #category : 'menu' }
MorphScrabble >> enleveMots [
	^ Scrabble
		enleveMots: (UIManager default request: 'Retirer les mots : ' initialAnswer: '' title: 'Sasissez les mots séparés par un espace')
]

{ #category : 'accessing' }
MorphScrabble >> existeScrabble [
	"self getPions."
	^ self modele actif existeScrabble
]

{ #category : 'accessing' }
MorphScrabble >> first [
	^ self joueur modele pts + self robot modele pts = 0
]

{ #category : 'accessing' }
MorphScrabble >> first2 [
	^ self joueur modele pts + self robot modele pts = 0
]

{ #category : 'menu' }
MorphScrabble >> getMenu: shiftKeyState [
	^  self unMenuMorph 
]

{ #category : 'menu' }
MorphScrabble >> getPions [
	joueur getPions.
	robot getPions.

]

{ #category : 'menu' }
MorphScrabble >> getPionsMot: unJoueur [
	^ unJoueur getPionsMot: (UIManager default request: 'Votre tirage' initialAnswer: '' title: 'Sasissez vos lettres')
]

{ #category : 'accessing' }
MorphScrabble >> grille [
	^ grille
]

{ #category : 'accessing' }
MorphScrabble >> grille: anObject [
	grille := anObject
]

{ #category : 'event handling' }
MorphScrabble >> handlesMouseDown: anEvent [
	^ true
]

{ #category : 'event handling' }
MorphScrabble >> handlesMouseOver: anEvent [
	^ true
]

{ #category : 'accessing' }
MorphScrabble >> info [
	^ info
]

{ #category : 'accessing' }
MorphScrabble >> info: anObject [
	info := anObject
]

{ #category : 'initialization' }
MorphScrabble >> initialize [
	self setLabel: 'Scrabble By Me'.
	super initialize.
	modele := Scrabble newMorph: self.
	sac := MorphSac new: self.
	grille := MorphGrille new: self.
	robot := MorphTirage nom: 'robot' new: self.
	robot modele: self modele robot.
	robot modele morph: robot.
	robot setSubmorphs.
	joueur := MorphTirage nom: 'joueur' new: self.
	joueur modele: self modele joueur.
	joueur modele morph: joueur.
	joueur setSubmorphs.
	ptJ := TextMorph new.
	ptR := TextMorph new.
	pions := MorphPion getMPionsWith: self modele pions.
	sac initializePions.
	grille position: self position + (10 @ 50).
	joueur position: grille bottomLeft + (0 @ 5).
	robot position: grille topRight + (5 @ 0).
	ptJ position: joueur topRight + (10 @ 0).
	ptR position: joueur topRight + (10 @ 18).
	"info := Transcript openLabel: 'Scrabble information'."
	"info position: robot topRight + (100 @ 0)."
	point := TextMorph new .
"	point
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 11);
		textColor: Color white;
		backgroundColor: Color red."
	"toggleCornerRounding."
	self addMorph: grille redraw.
	self addMorph: joueur redraw.
	self addMorph: robot redraw.
	self addMorph: ptJ.
	self addMorph: ptR.
	"self addMorph: info."
	self addMorph: point hide.
	self robot modele manuel: false.
	self joueur modele manuel: true.
	self wantsYellowButtonMenu: true.
	self modele class getDictDesMots.
	self modele class getDictDesAnagrammes.
	self nouvellePartie
]

{ #category : 'accessing' }
MorphScrabble >> joueAide [
	self getPions.
	^ self modele actif joueAide
]

{ #category : 'accessing' }
MorphScrabble >> joueur [
	^ joueur
]

{ #category : 'accessing' }
MorphScrabble >> joueur: anObject [
	joueur := anObject
]

{ #category : 'accessing' }
MorphScrabble >> model [
	^ self modele
]

{ #category : 'accessing' }
MorphScrabble >> modele [
	^ modele
]

{ #category : 'accessing' }
MorphScrabble >> modele: anObject [
	modele := anObject
]

{ #category : 'event handling' }
MorphScrabble >> mouseDown: anEvent [
	anEvent hand waitForClicksOrDrag: self event: anEvent
]

{ #category : 'event handling' }
MorphScrabble >> mouseEnter: anEvent [
	"resout le baigaiement "

	"self basicActivate"
]

{ #category : 'accessing' }
MorphScrabble >> nbPions [
	^ nbPions
]

{ #category : 'accessing' }
MorphScrabble >> nbPions: anObject [
	nbPions := anObject
]

{ #category : 'menu' }
MorphScrabble >> nouvellePartie [
	self point hide.
	self grille modele cases do: [ :c | c pion: nil ].
	self modele pions
		select: [ :p | true ]
		thenDo: [ :p | 
			p isJocker
				ifTrue: [ p jocker: ' ' ].
			p
				owner: self modele sac;
				whereIs: self modele sac ].
	self modele undo: nil.
	self joueur modele pts: 0; withJocker: true.
	self robot modele pts: 0; withJocker: true.
	self sac initializePions.
	self grille modele resetCasesVal.
	self grille unlockCases.
	self getPions.
	self redrawMorph.
	"Transcript clear."
	self refreshWorld.
	self modele actif joue
]

{ #category : 'accessing' }
MorphScrabble >> pions [
	^ pions
]

{ #category : 'accessing' }
MorphScrabble >> pions: anObject [
	pions := anObject
]

{ #category : 'accessing' }
MorphScrabble >> point [
	^ point
]

{ #category : 'accessing' }
MorphScrabble >> point: anObject [
	point := anObject
]

{ #category : 'accessing' }
MorphScrabble >> ptJ [
	^ ptJ
]

{ #category : 'accessing' }
MorphScrabble >> ptJ: anObject [
	ptJ := anObject
]

{ #category : 'accessing' }
MorphScrabble >> ptR [
	^ ptR
]

{ #category : 'accessing' }
MorphScrabble >> ptR: anObject [
	ptR := anObject
]

{ #category : 'drawing' }
MorphScrabble >> redrawMorph [
	self updateModele: false.
	self grille redraw.
	self joueur redraw.
	self robot redraw.
	self afficheScores.
	"self info invalidRect: self info bounds."
	self updateModele: true
]

{ #category : 'accessing' }
MorphScrabble >> robot [
	^ robot
]

{ #category : 'accessing' }
MorphScrabble >> robot: anObject [
	robot := anObject
]

{ #category : 'accessing' }
MorphScrabble >> sac [
	^ sac
]

{ #category : 'accessing' }
MorphScrabble >> sac: anObject [
	sac := anObject
]

{ #category : 'menu' }
MorphScrabble >> unMenuMorph [
	| menu smD |
	menu := MenuMorph new.
	smD := MenuMorph new.
	smD add: 'Refile moi mes pions' target: self selector: #getPions.
	smD
		add: 'Joue !'
		target: self modele actif
		selector: #joueAutomate.
	menu add: 'Validation' target: self selector: #validePions.
	smD add: 'Aide ?' target: self selector: #joueAide.
	smD add: 'Scrabble ?' target: self selector: #existeScrabble.
	smD add: 'Undo' target: self selector: #undo.
	menu add: 'Nouvelle Partie' target: self selector: #nouvellePartie.
	menu add: 'Actions' translated subMenu: smD.
	smD := MenuMorph new.
	smD
		add: 'Joueur manuel'
		target: self modele joueur
		selector: #manuel:
		argument: true.
	smD
		add: 'Joueur automatique'
		target: self modele joueur
		selector: #manuel:
		argument: false.
	smD
		add: 'Robot manuel'
		target: self modele robot
		selector: #manuel:
		argument: true.
	smD
		add: 'Robot automatique'
		target: self modele robot
		selector: #manuel:
		argument: false.
	menu add: 'Qui joue ?' translated subMenu: smD.
	smD := MenuMorph new.
	smD
		add: 'Saisir les lettres du joueur'
		target: self
		selector: #getPionsMot:
		argument: joueur.
	smD
		add: 'Saisir les lettres du robot'
		target: self
		selector: #getPionsMot:
		argument: robot.
	smD
		add: 'Changer de tirage joueur'
		target: self
		selector: #changeTirage:
		argument: joueur.
	smD
		add: 'Changer de tirage robot'
		target: self
		selector: #changeTirage:
		argument: robot.
	menu add: 'Tirage' translated subMenu: smD.
	smD := MenuMorph new.
	smD add: 'Ajouter des mots' target: self selector: #ajouteMots.
	smD
		add: 'Retirer des mots'
		target: self modele actif
		selector: #enleveMots.
	smD
		add: 'Sauvegarder le dictionnaire'
		target: Scrabble
		selector: #savDictDesMots.
	menu add: 'Dictionnaire' translated subMenu: smD.
	^ menu
]

{ #category : 'menu' }
MorphScrabble >> undo [
	self point hide.
	self modele undoJeu
	"self modele actif: self modele actif suivant"
]

{ #category : 'accessing' }
MorphScrabble >> updateModele [
	^ updateModele ifNil: [ updateModele := true ]
]

{ #category : 'accessing' }
MorphScrabble >> updateModele: anObject [
	updateModele := anObject
]

{ #category : 'menu' }
MorphScrabble >> validePions [
	| j cases |
	self modele nbPasses > 1
		ifTrue: [ ^ self modele finDePartie ].
	j := self modele actif.
	cases := self grille casesPionsDe: j.
	cases
		ifEmpty: [ (UIManager default confirm: 'Vous passez votre tour ?')
				ifTrue: [ self modele nbPasses: self modele nbPasses + 1.
					j joueSuite ] ]
		ifNotEmpty: [ (j mesCases: cases)
				ifFalse: [ ^ self ]
				ifTrue: [ | max maxM maxX maxY maxD casesMot |
					casesMot := self grille modele getCasesMot: cases.
					max := self grille modele pointsTotal: j .
					max > 0
						ifTrue: [ maxM := Grille asByteString: casesMot.
							maxX := casesMot first colonne.
							maxY := casesMot first ligne.
							maxD := casesMot first ligne = casesMot last ligne.
							j
								joueFin:
									(Array
										with: max
										with: maxM
										with: maxX
										with: maxY
										with: maxD).
							j joueSuite ] ] ]
]

{ #category : 'menu actions' }
MorphScrabble >> wantsYellowButtonMenu [
	"Answer true if the receiver wants a yellow button menu"

	^ true
]

{ #category : 'event handling' }
MorphScrabble >> yellowButtonActivity: shiftKeyState [
	self wantsYellowButtonMenu
		ifFalse: [ ^ false ].

	(self getMenu: shiftKeyState)
		ifNotNil: [ :menu | 
			menu setInvokingView: self.
			menu popUpEvent: self activeHand lastEvent in: self world.
			^ true ].
	^ true
]
