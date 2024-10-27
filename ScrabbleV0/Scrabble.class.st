"
Jeu avec les mots
listeDesMots: un ByteString avec les mots encadrés avec un séparateur (Scrabble sepAsChar).
dictDesAnagrammes: un Dictionary avec comme clé les mots triés , et comme valeur un ByteString avec les anagrammes correspondants séparés d'un séparateur.
listeDesCles; un ByteString avec les clés du dictionnaire encadrées avec un séparateur.

Scrabble motsAvecLettresEtJockers: 'GR**ATI' filtre: '..(E|I)*'.
-> 'EMIGRANT GRINCAIT ERIGEAIT AGITERAS AGITEREZ AGITERAI BRIGUAIT GRISANTE GRISATRE TRIANGLE GRILLAIT ERIGEANT GUITARES GRIMPAIT AGIOTERA GRIPPAIT GREFFAIT GRIFFAIT TREPIGNA EMIGRAIT'
"
Class {
	#name : 'Scrabble',
	#superclass : 'Object',
	#instVars : [
		'grille',
		'sac',
		'pions',
		'morph',
		'joueur',
		'robot',
		'actif',
		'nbPasses',
		'undo'
	],
	#classInstVars : [
		'dictDesAnagrammes',
		'dictDesMots',
		'dictDesMotsKeys'
	],
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'dico' }
Scrabble class >> ajouteMots: unOuDesMots [
	unOuDesMots substrings
		select: [ :unMot | unMot isNotEmpty ]
		thenDo: [ :unMot | self dictDesMots at: unMot asUppercase put: true ].
	self dictDesAnagrammes: nil .
	self dictDesMotsKeys: nil.
]

{ #category : 'jeuDeScrabble' }
Scrabble class >> asByteString: aOC [
	^ (aOC
		inject: (WriteStream with: String new)
		into: [ :s :mc | 
			s
				nextPutAll: mc asString;
				yourself ]) contents
]

{ #category : 'jeuDeScrabble' }
Scrabble class >> asFiltreH: aOC [
	^ (aOC
				inject: (WriteStream with: String new)
				into: [ :s :mc | 
					s
						nextPutAll: mc asFiltreH;
						yourself ]) contents
]

{ #category : 'jeuDeScrabble' }
Scrabble class >> asFiltreV: aOC [
	^ (aOC
				inject: (WriteStream with: String new)
				into: [ :s :mc | 
					s
						nextPutAll: mc asFiltreV;
						yourself ]) contents 
]

{ #category : 'jeuDeScrabble' }
Scrabble class >> asSizeFiltre: aF [
	^ (aF copyWithRegex: '\((\w(\|\w)*)\)' matchesReplacedWith: '.') howManyMatch: '..............'
]

{ #category : 'accessing' }
Scrabble class >> dictDesAnagrammes [
	^ dictDesAnagrammes
]

{ #category : 'accessing' }
Scrabble class >> dictDesAnagrammes: anObject [
	^ dictDesAnagrammes := anObject
]

{ #category : 'dico' }
Scrabble class >> dictDesMots [
	dictDesMots ifNil: [ self getDictDesMots ].
	^ dictDesMots
]

{ #category : 'dico' }
Scrabble class >> dictDesMots: anObject [
	dictDesMots := anObject
]

{ #category : 'dico' }
Scrabble class >> dictDesMotsKeys [
	^ dictDesMotsKeys ifNil: [ dictDesMotsKeys := self getDictDesMots keys asOrderedCollection sort]
]

{ #category : 'accessing' }
Scrabble class >> dictDesMotsKeys: anObject [
	dictDesMotsKeys := anObject
]

{ #category : 'dico' }
Scrabble class >> enleveMots: unOuDesMots [
	unOuDesMots substrings
		select: [ :unMot | unMot isNotEmpty ]
		thenDo: [ :unMot | self dictDesMots removeKey: unMot asUppercase ifAbsent: [ nil ] ].
		self dictDesAnagrammes: nil .
	self dictDesMotsKeys: nil.
]

{ #category : 'dico' }
Scrabble class >> existeMot: unMot [
	^ self dictDesMots
		at: unMot trimBoth asUppercase
		ifAbsent: [  false ]
]

{ #category : 'jeuDeScrabble' }
Scrabble class >> filtre: unMasque [
	" * => (\w*|)
	  . => \w
	  A => A
	 self filtre: 'AB..E*' => ' AB\w\wE(\w*|) ' 
	"

	| temp |
	temp := unMasque trimBoth copyReplaceAll: '*' with: '\w*'.
	temp := temp copyReplaceAll: '.' with: '\w'.
	^ self sepAsString , temp , self sepAsString
]

{ #category : 'initialization' }
Scrabble class >> getDictDesAnagrammes [
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
]

{ #category : 'dico' }
Scrabble class >> getDictDesMots [
	dictDesMots
		ifNil: [ | f |
			f := (FileSystem / '/home/dsp/Documents/Scrabble/dicoSave.txt')
				readStream.
			dictDesMots := Dictionary new.
			[ f atEnd ]
				whileFalse: [ | str |
					str := f nextLine.
					dictDesMots at: str asUppercase put: true ].
			f close ].
	^ dictDesMots
]

{ #category : 'initialization' }
Scrabble class >> jocker [
	"
	Scrabble jocker .
	-> A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z
	"

	^ '|' join: ((0 to: 25) collect: [ :i | ($A asciiValue + i) asCharacter asString ])
]

{ #category : 'lesMots' }
Scrabble class >> motAsCle: unMot [
	^ unMot trimBoth asUppercase sorted asSymbol
]

{ #category : 'lesMots' }
Scrabble class >> motsAvecLettres: desLettres [
	"retourne un ByteString avec les mots séparés par des espaces"

	^ self getDictDesAnagrammes at: (self motAsCle: desLettres) ifAbsent: [ '' ]
]

{ #category : 'lesMots' }
Scrabble class >> motsAvecLettres: desLettres filtre: unFiltre [
	"
	self motsAvecLettres: 'DECRIT' filtre: '*E'
	"

	| lettres |
	"Transcript
		show: unFiltre;
		cr."
	lettres := (unFiltre copyWithRegex: '\((\w(\|\w)*)\)' matchesReplacedWith: '')
		select: [ :c | c isAlphaNumeric ].
	^ (((self motsAvecLettres: lettres , desLettres) allRegexMatches: (self filtre: unFiltre))
		collect: [ :m | m trimBoth ]) asSet
]

{ #category : 'private' }
Scrabble class >> motsAvecLettres: desLettres filtre: unFiltre avecLet: lettres [
	"
	self motsAvecLettres: 'DECRIT' filtre: '*E'
	"

	^ (((self motsAvecLettres: lettres , desLettres)
		allRegexMatches: unFiltre) collect: [ :m | m trimBoth ]) asSet
]

{ #category : 'lesMots' }
Scrabble class >> motsAvecLettresEtJockers: desLettres filtre: unFiltre [
	"
	generer lettres et pour chaque appeler motsAvecLettres2: lettres filtre: unFiltre
	retourne un Set
	accepte plusieurs jockers (à limiter à 4 pour 30 secondes de traitement)
	self motsAvecLettresEtJockers2: '**' filtre: 'A*(E|I)*'.
	"

	| lettres n |
	lettres := desLettres copyReplaceAll: '*' with: ''.
	n := lettres size.
	n to: desLettres size - 1 do: [ :i | lettres := self prodString: lettres avec: self jocker ].
	^ (lettres substrings: '|')
		inject: Set new
		into: [ :aSet :text | aSet union: (self motsAvecLettres: text filtre: unFiltre) ]
]

{ #category : 'private' }
Scrabble class >> motsAvecLettresEtJockers: desLettres filtre: unFiltre avecLet: what [
	"
	generer lettres et pour chaque appeler motsAvecLettres2: lettres filtre: unFiltre
	retourne un Set
	accepte plusieurs jockers (à limiter à 4 pour 30 secondes de traitement)
	self motsAvecLettresEtJockers: '**' filtre: 'A*(E|I)*'.
	"

	| lettres n |
	lettres := desLettres copyReplaceAll: '*' with: ''.
	n := lettres size.
	n to: desLettres size - 1 do: [ :i | lettres := self prodString: lettres avec: self jocker ].
	^ (lettres substrings: '|')
		inject: Set new
		into: [ :aSet :text | 
			aSet
				union: (self motsAvecLettres: text filtre: unFiltre avecLet: what) ]
]

{ #category : 'lesMots' }
Scrabble class >> motsAvecPrefix: unPrefix [
	"retourne un ByteString avec les mots séparés par des espaces"

	^ self dictDesMots keys select: [ :k | unPrefix , '*' match: k ] thenCollect: [ :k | k ]
]

{ #category : 'lesMots' }
Scrabble class >> motsAvecPrefixFast: unPrefix [
	"retourne un ByteString avec les mots séparés par des espaces"

	"ici on utilise une SortedCollection"

	^ ' '
		join:
			(self dictDesMotsKeys
				select: [ :k | k >= unPrefix asUppercase and: [ k < (unPrefix asUppercase , 'ZZZ') ] ]
				thenCollect: [ :k | k ])
]

{ #category : 'lesMots' }
Scrabble class >> motsDe2LettresAvecRajouts [
	^ ((self dictDesMots keys
		select: [ :k | k size = 2 ]
		thenCollect: [ :k | k ]) sort
		inject: (WriteStream with: String new)
		into: [ :ws :m | 
			ws
				nextPutAll: (self asByteString: (self uneLetAvant: m)) sort;
				space;
				nextPutAll: m;
				space;
				nextPutAll: (self asByteString: (self uneLetApres: m)) sort;
				cr;
				yourself ]) contents
]

{ #category : 'lesMots' }
Scrabble class >> motsDe: n avecLettre: aLet [
	| reg |
	reg := ('\w*' , aLet , '\w*') asRegex.
	(self dictDesMots keys
		select: [ :k | k size <= n and: [ reg matches: k ] ]
		thenCollect: [ :k | k ]) sort
		do: [ :m | 
			Transcript
				show: m;
				cr ]
]

{ #category : 'lesMots' }
Scrabble class >> motsDe: n avecLettres: let [
	| res |
	res := OrderedCollection new.
	let
		permutationsDo: [ :each | 
			| reg |
			reg := ('\w*' , ('\w*' join: each asArray) , '\w*') asRegex.
			res addAll: (self dictDesMots keys select: [ :k | k size = n and: [ reg matches: k ] ] thenCollect: [ :k | k ]) sort ].
	^ res
	"do: [ :m | 
			Transcript
				show: m;
				cr ]"
]

{ #category : 'initialization' }
Scrabble class >> newMorph: aM [
	| aS |
	aS := self new.
	aS morph: aM.
	^ aS
]

{ #category : 'lesMots' }
Scrabble class >> prodString: str01 avec: str02 [
	"
	'A|B' 'C|D|E' -> 'AC|AD|AE|BC|BD|BE'
	'AB|AC' 'XY' -> 'ABX|ABY|ACX|ACY'
	"

	| ar2 |
	str01 = ''
		ifTrue: [ ^ str02 ].
	str02 = ''
		ifTrue: [ ^ str01 ].
	ar2 := str02 findBetweenSubstrings: '|'.
	^ ((str01 findBetweenSubstrings: '|')
		inject: (WriteStream with: String new)
		into: [ :r :a | 
			ar2
				inject: r
				into: [ :r2 :b | 
					r2
						nextPutAll: a;
						nextPutAll: b;
						nextPutAll: '|';
						yourself ] ]) contents
]

{ #category : 'travail' }
Scrabble class >> raz [
	dictDesAnagrammes := nil.
	dictDesMots := nil.
	^ self
]

{ #category : 'dico' }
Scrabble class >> savDictDesMots [
	| f |
	f := (FileSystem / '/home/dsp/Documents/Scrabble/dicoSave.txt')
		writeStream.
	self dictDesMots keys sorted
		do: [ :str | 
			f nextPutAll: str asLowercase.
			f lf ].
	f close
]

{ #category : 'accessing' }
Scrabble class >> sepAsString [
	^ ' '
]

{ #category : 'lesMots' }
Scrabble class >> tousLesMots: desLettres [
	"
	Retourne un set de tous les mots de 2 à desLetrres size (ce peut être long)
	self tousLesMots: 'FGEIRA**'
	"

	| aSet |
	aSet := Set new.
	2 to: desLettres size do: [ :n | 
		desLettres
			combinations: n
			atATimeDo:
				[ :each | aSet := aSet union: (self motsAvecLettresEtJockers: (self asByteString: each) filtre: '*') ] ].
	^ aSet
]

{ #category : 'lesMots' }
Scrabble class >> tousLesMots: desLettres de: n [
	"
	Retourne un set des mots de n lettres avec desLetrres
	le caractères * joue le rôle de joker, les jockers au delà de 3 sont ignorés.
	self tousLesMots: 'FGEIRA**' de: 8. 
	30 ms ...
	"

	| aSet |
	aSet := Set new.
	n = 0
		ifTrue: [ ^ aSet ].
	desLettres
		combinations: n
		atATimeDo:
			[ :each | aSet := aSet union: (self motsAvecLettresEtJockers: (self asByteString: each) filtre: '*') ].
	^ aSet
]

{ #category : 'lesMots' }
Scrabble class >> tousLesMots: desLettres de: n filtre: aFiltre [
	"
	Retourne un set des mots de n lettres avec desLetrres
	le caractères * joue le rôle de joker à limiter à 3
	self tousLesMots: 'FGEIRA***' de: 7 filtre: '(O|F)......'. 
	13s ...
	"

	| aSet |
	aSet := Set new.
	n = 0
		ifTrue: [ ^ aSet ].
	desLettres
		combinations: n
		atATimeDo: [ :each | 
			aSet
				addAll:
					(self
						motsAvecLettresEtJockers: (self asByteString: each)
						filtre: aFiltre) ].
	^ aSet
]

{ #category : 'private' }
Scrabble class >> tousLesMots: desLettres de: n filtre: aFiltre avecLet: what [
	"
	je suis appele par grille.getFiltre:d: plusieurs fois avec les memes valeurs de n et filtre 
	la methode et les suivantes sont modifiées pour ne pas refaire inutilement des calculs
		motsAvecLettresEtJockers:filtre:avecLet
			motsAvecLettres:filtre:avecLet:
				lettres := (unFiltre copyWithRegex: '\((\w(\|\w)*)\)' matchesReplacedWith: '') select: [ :c | c isAlphaNumeric ] est calculé dans grille.getFiltre:d:
				de même filtre := Scrabble asFiltre: unFiltre
	"

	| aSet |
	aSet := Set new.
	n = 0
		ifTrue: [ ^ aSet ].
	desLettres
		combinations: n
		atATimeDo: [ :each | 
			aSet
				addAll:
					(self
						motsAvecLettresEtJockers: (self asByteString: each)
						filtre: aFiltre
						avecLet: what)	"aSet := aSet union:" ].
	^ aSet
]

{ #category : 'private' }
Scrabble class >> tousLesMots: desLettres filtre: aFiltre avecLets: aOC [
	"
	"

	| aSet n filtre lets |
	aSet := Set new.
	n := self asSizeFiltre: aFiltre.
	n = 0
		ifTrue: [ ^ aSet ].
	filtre := self filtre: aFiltre.
	lets := self asByteString: aOC.
	^ self tousLesMots: desLettres  de: n filtre: filtre  avecLet: lets . 

]

{ #category : 'lesMots' }
Scrabble class >> uneLetApres: unMot [
	"retourne un Set"

	^ (self motsAvecLettresEtJockers: '*' filtre: unMot , '.')
		inject: Set new
		into: [ :aSet :m | 
			aSet
				add: m trimBoth last asString;
				yourself ]
]

{ #category : 'lesMots' }
Scrabble class >> uneLetAvant: unMot [
	"retourne un Set"

	^ (self motsAvecLettresEtJockers: '*' filtre: '.' , unMot)
		inject: Set new
		into: [ :aSet :m | 
			aSet
				add: m trimBoth first asString;
				yourself ]
]

{ #category : 'accessing' }
Scrabble >> actif [
	^ actif ifNil: [ actif := self joueur ]
]

{ #category : 'accessing' }
Scrabble >> actif: anObject [
	actif := anObject.

]

{ #category : 'menu' }
Scrabble >> finDePartie [
	self joueur pions
		ifEmpty: [ | nP undoArr |
			nP := (self robot pions asArray collect: [ :p | p valeur ]) reduce: [ :a :b | a + b ].
			self joueur pts: self joueur pts + nP .
			undoArr := self undo.
			undoArr at: 4 put: (undoArr at: 4) + nP .
			self undo: undoArr.
			].
	self robot pions
		ifEmpty: [ | nP undoArr |
			nP := (self joueur pions asArray collect: [ :p | p valeur ]) reduce: [ :a :b | a + b ].
			self robot pts: self robot pts + nP .
			undoArr := self undo.
			undoArr at: 4 put: (undoArr at: 4) + nP .
			self undo: undoArr.].
	self morph afficheScores
]

{ #category : 'accessing' }
Scrabble >> grille [
	^ grille
]

{ #category : 'accessing' }
Scrabble >> grille: anObject [
	grille := anObject
]

{ #category : 'menu' }
Scrabble >> initialExtent [
	^ 1600 @ 900
]

{ #category : 'initialization' }
Scrabble >> initialize [
	grille := Grille new jeu: self.
	sac := Sac new jeu: self.
	joueur := Tirage new jeu: self.
	joueur nom: 'Joueur'.
	robot := Tirage new jeu: self.
	robot nom: 'Robot'.
	pions := Pion getPions.
	sac initializePions
]

{ #category : 'accessing' }
Scrabble >> joueur [
	^ joueur
]

{ #category : 'accessing' }
Scrabble >> joueur: anObject [
	joueur := anObject
]

{ #category : 'accessing' }
Scrabble >> morph [
	^ morph
]

{ #category : 'accessing' }
Scrabble >> morph: anObject [
	morph := anObject
]

{ #category : 'accessing' }
Scrabble >> nbPasses [
	^ nbPasses ifNil: [ nbPasses := 0 ]
]

{ #category : 'accessing' }
Scrabble >> nbPasses: anObject [
	nbPasses := anObject
]

{ #category : 'accessing' }
Scrabble >> pions [
	^ pions
]

{ #category : 'accessing' }
Scrabble >> pions: anObject [
	pions := anObject
]

{ #category : 'accessing' }
Scrabble >> pionsOwner: aOwner [

	^ self pions select: [ :p | p owner = aOwner ]
]

{ #category : 'accessing' }
Scrabble >> robot [
	^ robot
]

{ #category : 'accessing' }
Scrabble >> robot: anObject [
	robot := anObject
]

{ #category : 'accessing' }
Scrabble >> sac [
	^ sac
]

{ #category : 'accessing' }
Scrabble >> sac: anObject [
	sac := anObject
]

{ #category : 'accessing' }
Scrabble >> undo [
	undo ifNil: [ undo := Stack new ].
	^ undo ifEmpty: [ nil ] ifNotEmpty: [ undo pop ]
]

{ #category : 'accessing' }
Scrabble >> undo: anObject [
	anObject
		ifNil: [ undo := Stack new ]
		ifNotNil: [ undo ifNil: [ undo := Stack new ] . undo push: anObject ] 
]

{ #category : 'accessing' }
Scrabble >> undoJeu [
	"il peut y avoir des problèmes notamment dans l'affichage"

	| undoArr unJ |
	self joueur getPions .
	self robot getPions .
	undoArr := self undo.
	undoArr ifNil: [ ^ self ].
	unJ := undoArr at: 2.
	self actif: unJ.
	(undoArr at: 1)
		do: [ :aP | 
			(self grille atPoint: aP) pion moveTo: sac.
			(self grille atPoint: aP) morph removeAllMorphs ].
	unJ morph getPionsMot: (undoArr at: 3) trimBoth.
	unJ pts: unJ pts - (undoArr at: 4).
	self morph redrawMorph.
	self grille setCasesVal.
	^ self
]
