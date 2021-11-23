import 'package:flutter/material.dart';
import 'package:flutter_retec/src/pages/cliente_screen.dart';
import 'package:flutter_retec/src/pages/cliente_scrren_prueba.dart';
import 'package:flutter_retec/src/pages/login_screen.dart';
import 'package:flutter_retec/src/pages/pruba_registra_usuario.dart';
import 'package:flutter_retec/src/pages/recuperar_contrasena.dart';


Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
<<<<<<< HEAD
    '/LoginScreen': (context) =>   LoginScreen(), //ariel
    '/ClienteScreen': (context) => ClienteScreen(), // ariel --puede que ya no la use por ser stateless
    '/RecuperarContrasena': (context) => RecuperarContrasena(),
    '/ClienteScreen2': (context) => ClienteScreen2(),
    '/PruebaRegistroUsuario': (context) => PruebaRegistroUsuario()
=======
    '/LoginScreen': (context) => const LoginScreen(), //ariel
    '/ClienteScreen': (context) => const ClienteScreen() // ariel
>>>>>>> VersionEstable
  };
}
