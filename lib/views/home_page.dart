import 'package:flutter/material.dart';
import 'carousel_home.dart';
import 'category_cards.dart';
import 'cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(Icons.fastfood),
                  SizedBox(width: 8),
                  Text(
                    'Need',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Food',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        CategorySection(
          categoryTitle: 'Categories',
          cards: [
            CustomCard(
                imageUrl: 'https://source.unsplash.com/200x200/?Burger',
                title: 'Burger '),
            CustomCard(
                imageUrl: 'https://source.unsplash.com/200x200/?Pizza',
                title: 'Pizza '),
            CustomCard(
                imageUrl: 'https://source.unsplash.com/200x200/?Sushi',
                title: 'Sushi '),
          ],
        ),
        CategorySection(
          categoryTitle: 'Recommended',
          cards: [
            CustomCard(
                imageUrl: 'https://source.unsplash.com/200x200/?Burger',
                title: 'Burger '),
            CustomCard(
                imageUrl: 'https://source.unsplash.com/200x200/?Pizza',
                title: 'Pizza '),
            CustomCard(
                imageUrl: 'https://source.unsplash.com/200x200/?Sushi',
                title: 'Sushi '),
          ],
        ),
        Carousel(),
        Carousel(),
      ])),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, color: Colors.black),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline, color: Colors.black),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Placeholder for central button
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined, color: Colors.black),
                label: 'Pesan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, color: Colors.black),
                label: 'Saya',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
          Center(
            heightFactor: 0.1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 4),
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: FloatingActionButton(
                      onPressed: () => _onItemTapped(2),
                      elevation: 20,
                      hoverColor: Colors.black,
                      // Remove default shadow
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _pageTitle = [
  'Home',
  'Wishlist',
  'Cart',
  'Pesan',
  'Saya',
];
