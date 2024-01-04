import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokeContainer extends StatelessWidget {
   PokeContainer({
    super.key,
    required this.size,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.types,
  });

  final Size size;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> types;

  final Map<String, Color> typeColors = {
    'fire': Colors.red,
    'water': Colors.blue,
    'grass': Colors.green,
    'electric': Colors.yellow,
    'poison': Colors.purple,
    // Agrega más tipos y colores según sea necesario
  };

  Widget _buildTypeText(String type) {
    Color backgroundColor = typeColors[type] ?? Colors.grey;
    Color textColor = Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      width: size.width * 0.4,
      height: size.height * 0.25,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.fromBorderSide(
          BorderSide(
            width: 5,
            color: Colors.blue,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, width: 100),
          Text(
            name,
            style: GoogleFonts.pressStart2p(fontSize: 16),
          ),
          Text(description, style: GoogleFonts.pressStart2p(fontSize: 3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: types.map((type) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildTypeText(type),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
