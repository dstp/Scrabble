lesMots
motsAvecPrefix: unPrefix
	"retourne un ByteString avec les mots séparés par des espaces"

	^ self dictDesMots keys select: [ :k | unPrefix , '*' match: k ] thenCollect: [ :k | k ]