import 'package:flutter/material.dart';
import 'package:flutter_retec/widgets/cliente_screen.dart';
import 'package:flutter_retec/widgets/login_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      routes: {
        '/LoginScreen': (context) => LoginScreen(), //asignamos la pantalla del login
        '/ClienteScreen': (context) => ClienteScreen()
      },
      initialRoute: '/LoginScreen',
    );
  }
}