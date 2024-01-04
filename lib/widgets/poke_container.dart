import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokeContainer extends StatelessWidget {
   const PokeContainer({
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

  static const Map<String, Color> typeColors = {
    'fire': Colors.red,
    'water': Colors.blue,
    'grass': Colors.green,
    'electric': Colors.yellow,
    'poison': Colors.purple,
    'flying': Colors.blueGrey,
    'bug': Colors.lightGreen,
    
  };

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      width: size.width * 0.4,
      height: size.height * 0.25,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.fromBorderSide(
          types.map( (type) => BorderSide(color: typeColors[type] ?? Colors.grey, width: 2)).first,
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
          /* Text(description, style: GoogleFonts.pressStart2p(fontSize: 6)), */
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
}


