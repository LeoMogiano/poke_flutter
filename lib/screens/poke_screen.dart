import 'package:examen_server/services/poke_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokeScreen extends StatelessWidget {
  const PokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final pokeService = Provider.of<PokeService>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Poke API',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              ( pokeService.isLoading )
              ? const CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: pokeService.pokemones.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(pokeService.pokemones[index].imageUrl),
                      title: Text(pokeService.pokemones[index].name),
                      subtitle: Text(pokeService.pokemones[index].description),
                      trailing: Text(pokeService.pokemones[index].types.toString()),
                    );
                  }
              )
            ],
          ),
        ));
  }
}
