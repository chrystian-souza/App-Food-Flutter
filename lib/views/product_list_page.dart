import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/product_list_item.dart';
import 'package:flutter_application_1/services/firebase_connect.dart';

class ListProducts extends StatelessWidget {
  final String categoryId;
  final FirestoreService _firestoreService = FirestoreService();

  ListProducts({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
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
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];

              // Logging product details for debugging
              print('Product ID: ${product['productId']}');
              print('cart ID: ${product['cartId']}');
              print('Image URL: ${product['imageUrl']}');
              print('Title: ${product['title']}');
              print('Price: ${product['price']}');
              print('Description: ${product['description']}');

              return ProductListItem(
                product: product,
                onAddToCart: _addToCart,
                onAddToFavorites: _addToFavorites,
              );
            },
          );
        },
      ),
    );
  }

  void _addToCart(
    String productId,
    String cartId,
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

  void _addToFavorites(
    String productId,
    String title,
    double price,
    String description,
    String imageUrl,
    BuildContext context,
  ) {
    _firestoreService
        .addToFavorites(productId, title, price, description, imageUrl)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added to favorites'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to favorites: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}

