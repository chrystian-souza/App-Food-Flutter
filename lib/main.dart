import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:flutter_application_1/views/home_page.dart'; // Importe sua HomePage aqui

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu App',
      initialRoute: '/', // Defina a rota inicial, se necessário
      routes: {
        '/': (context) => HomePage(), // Rota para a tela de login
       // '/home': (context) => HomePage(), // Exemplo de rota para a HomePage
        // Outras rotas podem ser definidas aqui conforme necessário
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Rota não encontrada'),
            ),
          ),
        );
      },
    );
  }
}
