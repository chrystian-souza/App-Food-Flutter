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
                  final String? cartId = product['cartId'] as String?;
                  final String? imageUrl = product['imageUrl'] as String?;
                  final String? title = product['title'] as String?;
                  final double? price = product['price'] as double?;
                  final String? description = product['description'] as String?;

                  // Logging product details for debugging
                  print('Product ID: $productId');
                  print('cart ID: $cartId');
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
                            color: Colors.grey,
                          ),
                    title: Text(title ?? 'No title'),
                    subtitle: Text(description ?? 'No description'),
                    trailing: GestureDetector(
                      onTap: () {
                        // Verifique se todos os valores são válidos antes de chamar _addToCart
                        if (productId != null &&
                            productId.isNotEmpty &&
                            price != null) {
                          _addToCart(
                            productId,
                            cartId ?? '',
                            title ?? '', // Evite passar null para o título
                            price.toDouble(), // Convertendo para double
                            description ??
                                '', // Evite passar null para a descrição
                            imageUrl ??
                                '', // Evite passar null para a URL da imagem
                            context,
                          );
                        } else {
                          print('productId: $productId');
                          print('Id: $cartId');
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

  void _addToCart(
    String cartId,
    String productId,
    String title,
    double price,
    String description,
    String imageUrl,
    BuildContext context,
  ) {
    _firestoreService
        .addToCart(productId, cartId, title, price, description, imageUrl)
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
