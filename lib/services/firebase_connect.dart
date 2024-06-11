import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/firebase_options.dart';

register(email, password,) async {          //inicializa o firebase

try {

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  await auth.createUserWithEmailAndPassword(email: email, password: password);
  print(auth);
 // await auth.createUserWithEmailAndPassword(email: 'email@email.com', password: '1234');
  return true;
} catch (e) {
  print('Error');
  return false;
}

}

createUser() async {
  // Inicializa o Firebase com as opções do seu projeto
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Cria uma referência ao Firestore
  var db = FirebaseFirestore.instance;
  // Adiciona um documento à coleção 'Users' com o ID '1'
  await db.collection('Users').doc('1').set({
    'name': 'Chrystian',
    'age': '24',
    'job': 'Web Developer',
    'is_user': true  // Corrigido para booleano
  });
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getCategories() {
    return _db.collection('categories').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }

  Stream<List<Map<String, dynamic>>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}
