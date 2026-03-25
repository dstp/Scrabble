"
Je représente la vue graphique d'une case
Suivant l'état de mon modèle (la case) j'accepte ou pas qu'un pion soit déposé (addMorph).
J'affiche  l'image du pion, sinon l'image associée à la case.
(Mot * 3, mot * 2, lettre * 3 ou lettre * 2) ou sinon la couleur (Bleu foncé, bleu clai, rouge foncé ou rouge clair)
Et d'autres choses à définir. 
"
Class {
	#name : 'MorphCaseGrille',
	#superclass : 'MorphCaseTirage',
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'accessing' }
MorphCaseGrille class >> modele [
	^ CaseGrille
]

{ #category : 'comparing' }
MorphCaseGrille >> <= another [
	^ self modele <= another modele
]

{ #category : 'change reporting' }
MorphCaseGrille >> addedMorph: aMorph [
	aMorph modele isJocker
		ifTrue: [ aMorph modele jocker = ' '
				ifTrue: [ aMorph modele
						jocker:
							(self theme
								chooseDropListIn: self currentWorld
								text: 'Quelle lettre ?' translated
								title: 'Choisir'
								list: (($A to: $Z) collect: [ :c | c asString ])) ].
			aMorph
				faceJ: nil;
				showFaceJ ]
		ifFalse: [ aMorph showFace ].
	aMorph position: self position.
	self owner jeu updateModele
		ifTrue: [ aMorph modele moveTo: self modele]
]

{ #category : 'delegate' }
MorphCaseGrille >> couleur [
	^ self modele couleur
]

{ #category : 'change reporting' }
MorphCaseGrille >> getMorphPion [
	| p |
	self isNotEmpty
		ifFalse: [ ^ self ].
	p := self modele pion.
	p isJocker
		ifTrue: [ self addMorphFront: self modele pion morph showFaceJ ]
		ifFalse: [ self addMorphFront: self modele pion morph showFace ]
]

{ #category : 'submorphs-add/remove' }
MorphCaseGrille >> removedMorph: aMorph [
	aMorph modele valeur = 0
		ifTrue: [ "aMorph modele jocker: ' '."
			aMorph faceJ: nil.
			aMorph showFace ].
	super removedMorph: aMorph
]
