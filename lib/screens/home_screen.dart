import 'package:examen_server/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //screen size

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        
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

            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PokeScreen()));
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
  }
}
