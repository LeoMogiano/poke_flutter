import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
/* import 'package:flutter_dotenv/flutter_dotenv.dart'; */
import 'package:examen_server/models/models.dart';

class PokeService extends ChangeNotifier {
  /* final String _baseUrl = dotenv.env['BASE_URL'] ?? ''; */

  List<Pokemon> pokemones = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PokeService() {
    fetchPokemons();
  }

  Future<List<Pokemon>> fetchPokemons() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final results = data['results'] as List? ?? [];

        for (var result in results) {
          final pokemonDetailsResponse =
              await http.get(Uri.parse(result['url']));
          if (pokemonDetailsResponse.statusCode == 200) {
            final pokemonDetails = json.decode(pokemonDetailsResponse.body);

            final pokemonName = result['name'];

            final speciesUrl = pokemonDetails['species']['url'];
            final speciesResponse = await http.get(Uri.parse(speciesUrl));

            if (speciesResponse.statusCode == 200) {
              final speciesData = json.decode(speciesResponse.body);
              final flavorTextEntries = speciesData['flavor_text_entries'];

              final pokemonDescription = flavorTextEntries.firstWhere((entry) {
                final language = entry['language']['name'];
                return language == 'es';
              })['flavor_text'];
              
              final pokemonTypes = <String>[
                for (var typeEntry in pokemonDetails['types'] ?? [])
                  typeEntry['type']['name']
              ];

              final pokemonUrl =
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${result['url'].split('/').lastWhere((element) => (element as String).isNotEmpty, orElse: () => '')}.png';

              pokemones.add(Pokemon(
                name: pokemonName,
                description: pokemonDescription,
                types: pokemonTypes,
                imageUrl: pokemonUrl,
              ));
            }
          }
        }
        return pokemones;
      } else {
        throw Exception('Failed to load Pokémon');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
