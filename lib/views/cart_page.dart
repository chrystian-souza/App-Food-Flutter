import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_connect.dart';

class CartPage extends StatelessWidget {
  final FirestoreService _firestoreService;

  CartPage({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _firestoreService.getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found in cart'));
          }

          var cartProducts = snapshot.data!;
          double total = 0;

          cartProducts.forEach((product) {
            double price = double.parse(product['price']);
            int quantity = product['quantity'];
            total += price * quantity;
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    var product = cartProducts[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Image.network(
                          product['imageUrl'],
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                        title: Text(product['productName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: \$${product['price']}'),
                            Text('Quantity: ${product['quantity']}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _firestoreService.removeFromCart(product['productId']);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implementar lógica de checkout aqui
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Purchase completed'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Checkout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
