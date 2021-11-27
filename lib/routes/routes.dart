import 'package:flutter/material.dart';
import 'package:flutter_retec/src/pages/cliente_screen.dart';
import 'package:flutter_retec/src/pages/contrasena_screen.dart';
import 'package:flutter_retec/src/pages/login_screen.dart';
import 'package:flutter_retec/src/pages/pago_screen.dart';
import 'package:flutter_retec/src/pages/perfil_screen.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/LoginScreen': (context) => const LoginScreen(), //ariel
    '/ClienteScreen': (context) => const ClienteScreen(), // ariel
    '/PerfilScreen': (context) => const PerfilScreen(),
    '/ContrasenaScreen': (context) => const ContrasenaScreen(),
    '/PagoScreen': (context) => const PagoScreen(), //Chema
  };
}
