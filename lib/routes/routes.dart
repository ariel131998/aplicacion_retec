import 'package:flutter/material.dart';
import 'package:flutter_retec/src/pages/bienvenida_page.dart';
import 'package:flutter_retec/src/pages/cliente_screen.dart';
import 'package:flutter_retec/src/pages/login_screen.dart';
import 'package:flutter_retec/src/pages/registro_cliente_page.dart';
import 'package:flutter_retec/src/pages/registro_retec_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/LoginScreen': (context) => const LoginScreen(),     //ariel
    '/ClienteScreen': (context) => const ClienteScreen(), // ariel
    '/BienvenidaPage': (context) => const BienvenidaPage(),     //Isaac
    '/RegistroClientePage': (context) => const RegistroClientePage(),     //Isaac
    '/RegistroRetecPage': (context) => const RegistroRetecPage(),     //Isaac 

  };
}
