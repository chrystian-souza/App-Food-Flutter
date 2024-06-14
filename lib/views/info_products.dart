import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_connect.dart';

class InfoProducts extends StatelessWidget {
  final String categoryId;
  final FirestoreService _firestoreService = FirestoreService();

  InfoProducts({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Adicione aqui a funcionalidade de favoritar o produto
            },
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _firestoreService.getProductsByCategoryId(categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found'));
            }

            var products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return ListTile(
                    leading: Image.network(
                      product['imageUrl'],
                      fit: BoxFit.cover,
                      width: 200,
                      height: 400,
                    ),
                    title: Text(product['title']),
                    subtitle: Text(product['description']),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        // Adicione aqui a funcionalidade de adicionar ao carrinho
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
