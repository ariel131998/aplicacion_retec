import 'package:flutter/material.dart';
import 'package:flutter_retec/src/pages/tema/palette.dart';
import 'package:flutter_retec/src/routes/routes.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final selection = Colors.green[400]!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
        //Colors.amber 
      ),
      title: 'Retec App',
      initialRoute: '/LoginScreen',
      routes: getAplicationRoutes(),
    );
  }
}