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
        final results = data['results'] as List;

        for (var result in results) {
          final pokemonDetailsResponse =
              await http.get(Uri.parse(result['url']));
          if (pokemonDetailsResponse.statusCode == 200) {
            final pokemonDetails = json.decode(pokemonDetailsResponse.body);
            final pokemonName = result['name'];
            final pokemonDescription = pokemonDetails['species']
                ['flavor_text_entries'][0]['flavor_text'];
            final pokemonTypes = <String>[for (var typeEntry in pokemonDetails['types']) typeEntry['type']['name']];
            final pokemonUrl =
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${result['url'].split('/').last}.png';

            pokemones.add(Pokemon(
              name: pokemonName,
              description: pokemonDescription,
              types: pokemonTypes,
              imageUrl: pokemonUrl,
            ));
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
