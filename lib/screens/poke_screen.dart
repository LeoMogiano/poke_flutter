import 'package:examen_server/services/poke_service.dart';
import 'package:examen_server/widgets/poke_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokeScreen extends StatelessWidget {
  const PokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokeService = Provider.of<PokeService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PokeMonk',
          style: GoogleFonts.pressStart2p(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
          child: (pokeService.isLoading)
              ? const CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: (pokeService.pokemones.length / 2).ceil(),
                  itemBuilder: (BuildContext context, int index) {
                    final startIndex = index * 2;
                    final endIndex = startIndex + 2;
                    final pokemonsToShow =
                        pokeService.pokemones.sublist(startIndex, endIndex);

                    return Row(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      
                      children: pokemonsToShow
                          .map(
                            (pokemon) => Expanded(
                              child: PokeContainer(
                                size: MediaQuery.of(context).size,
                                name: pokemon.name,
                                description: pokemon.description,
                                imageUrl: pokemon.imageUrl,
                                types: pokemon.types,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
        ),
      ),
    );
  }
}