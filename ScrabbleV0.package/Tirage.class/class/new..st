instance creation
new: aNom
	^ self joueurs at: aNom ifPresent: [ :v | v ] ifAbsentPut: [ self new nom: aNom ]