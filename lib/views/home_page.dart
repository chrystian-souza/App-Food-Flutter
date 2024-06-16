import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/views/info_products.dart';
import '../services/firebase_connect.dart';
import '../components/cards.dart';
import '../components/category_cards.dart';
import '../components/carousel_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
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
                    'https://firebasestorage.googleapis.com/v0/b/projeto-final-8ce4c.appspot.com/o/istockphoto-1159174187-2048x2048.jpg?alt=media&token=9aded2a2-de6a-49d6-bee2-6d43d103019a',
                    fit: BoxFit.cover,
                    width: 400,
                    height: 200,
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestoreService.getCategories(),
              builder: (context, snapshot) {
                // Verifica os estados do snapshot
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Obtém os documentos da categoria
                List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryDocs =
                    snapshot.data!.docs;

                if (categoryDocs.isEmpty) {
                  return Text('No categories available');
                }

                // Renderiza a seção de categorias
                return CategorySection(
                  categoryTitle: 'Categories',
                  cards: categoryDocs.map((categoryDoc) {
                    var category = categoryDoc.data();
                    var categoryId = categoryDoc.id;

                    if (category != null &&
                        category.containsKey('imageUrl') &&
                        category.containsKey('title')) {
                      return CustomCard(
                        imageUrl: category['imageUrl'],
                        title: category['title'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InfoProducts(categoryId: categoryId),
                            ),
                          );
                        },
                      );
                    } else {
                      return CustomCard(
                        imageUrl: '',
                        title: '',
                        onTap: () {},
                      );
                    }
                  }).toList(),
                );
              },
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _firestoreService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No products available');
                }

                List<Map<String, dynamic>> products = snapshot.data!;

                return Column(
                  children: [
                    Carousel(
                      carouselTitle: 'Popular Now',
                      imageUrls: products
                          .map((product) => product['imageUrl'])
                          .toList(),
                      titulo: products.first['title'],
                      preco: products.first['price'],
                      info: products.first['description'],
                    ),
                    Carousel(
                      carouselTitle: 'Recommended',
                      imageUrls: products
                          .map((product) => product['imageUrl'])
                          .toList(),
                      titulo: products.first['title'],
                      preco: products.first['price'],
                      info: products.first['description'],
                    ),
                  ],
                );
              },
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
                icon: SizedBox.shrink(),
                label: '' ,
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
