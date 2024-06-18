import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(String, String, String, double, String, String, BuildContext)
      onAddToCart;
  final Function(String, String, double, String, String, BuildContext)
      onAddToFavorites;

  ProductListItem({
    required this.product,
    required this.onAddToCart,
    required this.onAddToFavorites,
  });

  @override
  Widget build(BuildContext context) {
    final String productId = product['productId'];
    final String? cartId = product['cartId'];
    final String? imageUrl = product['imageUrl'];
    final String? title = product['title'];
    final double? price = product['price'];
    final String? description = product['description'];

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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              if (productId.isNotEmpty && price != null) {
                onAddToCart(
                  productId,
                  cartId ?? '',
                  title ?? '',
                  price.toDouble(),
                  description ?? '',
                  imageUrl ?? '',
                  context,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product data is invalid.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              if (productId.isNotEmpty && price != null) {
                onAddToFavorites(
                  productId,
                  title ?? '',
                  price.toDouble(),
                  description ?? '',
                  imageUrl ?? '',
                  context,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product data is invalid.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
