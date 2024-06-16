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
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Implementar funcionalidade de favoritar o produto
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

                  // Verifica se todos os campos necessários estão presentes e não são nulos
                  final String? productId = product['productId'] as String?;
                  final String? imageUrl = product['imageUrl'] as String?;
                  final String? title = product['title'] as String?;
                  final String? price = product['price'] as String?;
                  final String? description = product['description'] as String?;

                  // Logging product details for debugging
                  print('Product ID: $productId');
                  print('Image URL: $imageUrl');
                  print('Title: $title');
                  print('Price: $price');
                  print('Description: $description');

                  return ListTile(
                    leading: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            color:
                                Colors.grey), // Placeholder if imageUrl is null
                    title: Text(title ?? 'No title'),
                    subtitle: Text(description ?? 'No description'),
                    trailing: GestureDetector(
                      onTap: () {
                        // Verifique se todos os valores são válidos antes de chamar _addToCart
                        if (productId != null && productId.isNotEmpty) {
                          _firestoreService
                              .addToCart(
                            productId,
                            title ?? '', // Evite passar null para o título
                            price ?? '', // Evite passar null para o preço
                            description ??
                                '', // Evite passar null para a descrição
                            imageUrl ??
                                '', // Evite passar null para a URL da imagem
                          )
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Product added to cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Failed to add product to cart: $error'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          });
                        } else {
                          print('Invalid product data:');
                          print('productId: $productId');
                          print('imageUrl: $imageUrl');
                          print('title: $title');
                          print('price: $price');
                          print('description: $description');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Product data is invalid.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Icon(Icons.add_shopping_cart),
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

  // Método  para adicionar produto ao carrinho
  void addToCart(String productId, BuildContext context) {
   
    String imageUrl = '';
    String title = ''; 
    String price = ''; 
    String description = ''; 
    _firestoreService
        .addToCart(productId, title, price, description, imageUrl)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added to cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to cart: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
