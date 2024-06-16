import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getProductsByCategoryId(String categoryId) {
    return _db
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }



  Stream<List<Map<String, dynamic>>> getCartItems() {
    return _db
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await _db.collection('cart').doc(productId).delete();
      print('Produto removido do carrinho com sucesso');
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategories() {
    return _db.collection('categories').snapshots();
  }

  Stream<List<Map<String, dynamic>>> getProducts() {
    return _db
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  Future<void> addToCartt(String productId) async {
    try {
      // Recuperar o produto pela ID
      DocumentSnapshot productSnapshot =
          await _db.collection('products').doc(productId).get();

      if (productSnapshot.exists) {
        // Dados do produto
        Map<String, dynamic> productData =
            productSnapshot.data() as Map<String, dynamic>;

        // Criar um novo item de carrinho
        Map<String, dynamic> cartData = {
          'productId': productId,
          'title': productData['title'],
          'price': productData['price'],
          'description': productData['description'],
          'imageUrl': productData['imageUrl'],
          'quantity': 1, // Quantidade inicial no carrinho
        };

        // Adicionar o item ao carrinho
        await _db.collection('cart').add(cartData);

        print('Produto adicionado ao carrinho com sucesso');
      } else {
        print('Produto não encontrado');
      }
    } catch (e) {
      print('Erro ao adicionar produto ao carrinho: $e');
    }
  }

  Future<void> addToCart(String productId, String title, String price, String description, String imageUrl) async {
  try {
    // Criar um novo item de carrinho
    Map<String, dynamic> cartData = {
      'productId': productId,
      'title': title,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': 1, // Quantidade inicial no carrinho
      'timestamp': FieldValue.serverTimestamp(), // Adiciona um campo de timestamp opcionalmente
    };

    // Adicionar o item ao carrinho
    await _db.collection('cart').add(cartData);

    print('Produto adicionado ao carrinho com sucesso');
  } catch (e) {
    print('Erro ao adicionar produto ao carrinho: $e');
    throw Exception('Failed to add to cart: $e');
  }
}
}
