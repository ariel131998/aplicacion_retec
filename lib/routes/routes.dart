import 'package:flutter/material.dart';
import 'package:flutter_retec/src/pages/cliente_screen.dart';
import 'package:flutter_retec/src/pages/login_screen.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/LoginScreen': (context) =>   LoginScreen(), //ariel
    '/ClienteScreen': (context) => ClienteScreen() // ariel
    
  };
}