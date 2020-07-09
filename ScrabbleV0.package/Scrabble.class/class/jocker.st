initialization
jocker
	"
	Scrabble jocker .
	-> A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z
	"

	^ '|' join: ((0 to: 25) collect: [ :i | ($A asciiValue + i) asCharacter asString ])