import 'package:flutter/material.dart';
import 'package:flutter_retec/routes/routes.dart';
import 'package:flutter_retec/tema/palette.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Palette.kToDark),
      routes: getAplicationRoutes(),
      initialRoute: '/LoginScreen',
    );
  }
}
