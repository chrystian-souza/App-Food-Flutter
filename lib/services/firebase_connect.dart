import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getProductsByCategoryId(
      String categoryId) {
    return _db
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  Stream<List<Map<String, dynamic>>> getCartItems() {
    return _db.collection('cart').snapshots().map((snapshot) {
      // Mapeia cada documento do snapshot para um mapa de dados
      return snapshot.docs.map((doc) {
        var data = doc.data(); // Obtém os dados do documento
        data['cartId'] = doc
            .id; // Adiciona a chave primária (ID do documento) ao mapa de dados
        return data; // Retorna o mapa de dados atualizado
      }).toList(); // Converte o Iterable para uma lista
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategories() {
    return _db.collection('categories').snapshots();
  }

  Stream<List<Map<String, dynamic>>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
  }

  Future<void> addToCart(String productId, String cartId, String title,
      double price, String description, String imageUrl) async {
    try {
      // Criar um novo item de carrinho
      Map<String, dynamic> cartData = {
        'cartId': cartId,
        'productId': productId,
        'title': title,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
        'quantity': 1, // Quantidade inicial no carrinho
        'timestamp': FieldValue
            .serverTimestamp(), // Adiciona um campo de timestamp opcionalmente
      };

      // Adicionar o item ao carrinho
      await _db.collection('cart').add(cartData);

      print('Produto adicionado ao carrinho com sucesso');
    } catch (e) {
      print('Erro ao adicionar produto ao carrinho: $e');
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> removeFromCart(String cartId) {
    return _db
        .collection("cart")
        .doc(cartId)
        .delete()
        .then((_) => print("Document deleted"))
        .catchError((e) => print("Error deleting document $e"));
  }

  Stream<List<Map<String, dynamic>>> getFavoriteItems() {
    return _db.collection('favorites').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['favoriteId'] = doc.id; // Inclui o ID do documento
        return data;
      }).toList();
    });
  }

  Future<void> removeFromFavorites(String favoriteId) {
    return _db.collection('favorites').doc(favoriteId).delete();
  }

  Future<void> addToFavorites( String productId, String title,
      double price, String description, String imageUrl) async {
    try {
      
      Map<String, dynamic> favoriteData = {
        'productId': productId,
        'title': title,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
      };

      // Adicionar o item ao carrinho
      await _db.collection('favorites').add(favoriteData);

      print('Produto adicionado aos favoritos com sucesso');
    } catch (e) {
      print('Erro ao adicionar aos favoritos: $e');
      throw Exception('Failed to add to favorites: $e');
    }
  }
}
