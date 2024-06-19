import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_connect.dart';

class FavoritesPage extends StatelessWidget {
  final FirestoreService _firestoreService;

  FavoritesPage({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _firestoreService.getFavoriteItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite products found'));
          }

          var favoriteProducts = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              var product = favoriteProducts[index];           
              String favoriteId = product['favoriteId']; 
              String title = product['title'] ?? '';
              double price = product['price'] ?? 0.0;
              String description = product['description'] ?? '';
              String imageUrl = product['imageUrl'] ?? '';

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  title: Text(title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${price.toStringAsFixed(2)}'),
                      Text('Description: $description'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _firestoreService.removeFromFavorites(favoriteId).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Product removed from favorites'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to remove product from favorites: $error'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
