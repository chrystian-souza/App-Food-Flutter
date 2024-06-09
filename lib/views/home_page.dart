import 'package:flutter/material.dart';
import '../components/carousel_home.dart';
import '../components/category_cards.dart';
import '../components/cards.dart';

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
        backgroundColor: Colors.white,
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
        child: Column(
          children: [
            Center(
              child: Card(
                elevation: 4,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://conteudo.imguol.com.br/c/noticias/f6/2022/07/21/hellmanns-escolhe-sao-paulo-para-lancar-sua-primeira-hamburgueria-1658432069335_v2_4x3.jpg',
                    fit: BoxFit.cover,
                    width: 400,
                    height: 200,
                  ),
                ),
              ),
            ),
            CategorySection(
              categoryTitle: 'Categories',
              cards: [
                CustomCard(
                  imageUrl: 'https://conteudo.imguol.com.br/c/noticias/f6/2022/07/21/hellmanns-escolhe-sao-paulo-para-lancar-sua-primeira-hamburgueria-1658432069335_v2_4x3.jpg',
                  title: 'Burger ',
                ),
                CustomCard(
                  imageUrl: 'https://conteudo.imguol.com.br/c/noticias/f6/2022/07/21/hellmanns-escolhe-sao-paulo-para-lancar-sua-primeira-hamburgueria-1658432069335_v2_4x3.jpg',
                  title: 'Pizza ',
                ),
                CustomCard(
                  imageUrl: 'https://conteudo.imguol.com.br/c/noticias/f6/2022/07/21/hellmanns-escolhe-sao-paulo-para-lancar-sua-primeira-hamburgueria-1658432069335_v2_4x3.jpg',
                  title: 'Sushi ',
                ),
              ],
            ),
            Carousel(
              carousel: 'Popular Now',
              titulo: 'Beef Burguer',
              imageUrls: [
                'https://conteudo.imguol.com.br/c/noticias/f6/2022/07/21/hellmanns-escolhe-sao-paulo-para-lancar-sua-primeira-hamburgueria-1658432069335_v2_4x3.jpg'
              ],
              preco: '19.90',
              info: 'Mcdi',
            ),
            Carousel(
              carousel: 'Recommended',
              titulo: 'Beef Burguer',
              imageUrls: [
                'https://conteudo.imguol.com.br/c/noticias/f6/2022/07/21/hellmanns-escolhe-sao-paulo-para-lancar-sua-primeira-hamburgueria-1658432069335_v2_4x3.jpg'
              ],
              preco: '19.90',
              info: 'Mcdi',
            ),
          ],
        ),
      ),
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
