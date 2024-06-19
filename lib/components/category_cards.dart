import 'package:flutter/material.dart';
import 'cards.dart'; // Importe o widget CustomCard

class CategorySection extends StatelessWidget {
  final String categoryTitle;
  final List<CustomCard> cards;

  const CategorySection({Key? key, required this.categoryTitle, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              categoryTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: cards,
          ),
        ],
      ),
    );
  }
}