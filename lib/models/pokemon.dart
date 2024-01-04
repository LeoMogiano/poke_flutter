
class Pokemon {
  final String name;
  final String description;
  final List<String> types;
  final String imageUrl;

  Pokemon(
      {required this.name,
      required this.description,
      required this.types,
      required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      description: json['description'],
      types: json['types'].cast<String>(),
      imageUrl: json['imageUrl'],
    );
  }

  List<Pokemon> parsePokemonsDetails(
      List<Map<String, dynamic>> pokemonsDetails) {
    return pokemonsDetails.map((details) {
      final pokemonName = details['name'];
      final pokemonDescription =
          details['species']['flavor_text_entries'][0]['flavor_text'];

      // Parse directo para obtener una lista de tipos
      final List<String> pokemonTypes = [];
      if (details['types'] != null) {
        for (var typeEntry in details['types']) {
          final typeName = typeEntry['type']['name'];
          pokemonTypes.add(typeName);
        }
      }

      final pokemonUrl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${details['id']}.png';

      return Pokemon(
        name: pokemonName,
        description: pokemonDescription,
        types: pokemonTypes,
        imageUrl: pokemonUrl,
      );
    }).toList();
  }

  @override
  String toString() {
    return 'Pokemon{name: $name, description: $description, types: $types, imageUrl: $imageUrl}';
  }
}
