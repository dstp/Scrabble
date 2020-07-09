jeuDeScrabble
asSizeFiltre: aF
	^ (aF copyWithRegex: '\((\w(\|\w)*)\)' matchesReplacedWith: '.') howManyMatch: '..............'