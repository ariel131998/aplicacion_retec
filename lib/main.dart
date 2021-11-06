import 'package:flutter/material.dart';
import 'package:flutter_retec/src/routes/routes.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      title: 'Retec App',
      initialRoute: '/LoginScreen',
      routes: getAplicationRoutes(),
    );
  }
}