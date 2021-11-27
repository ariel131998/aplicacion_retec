import 'package:flutter/material.dart';
import 'package:flutter_retec/src/pages/bienvenida_page.dart';
import 'package:flutter_retec/src/pages/cliente_screen.dart';
<<<<<<< HEAD
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
=======
import 'package:flutter_retec/src/pages/cliente_scrren_prueba.dart';
import 'package:flutter_retec/src/pages/login_screen.dart';
import 'package:flutter_retec/src/pages/pruba_registra_usuario.dart';
import 'package:flutter_retec/src/pages/recuperar_contrasena.dart';
import 'package:flutter_retec/src/pages/registro_cliente_page.dart';
import 'package:flutter_retec/src/pages/registro_retec_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/LoginScreen': (context) =>   LoginScreen(), //ariel
    '/ClienteScreen': (context) => ClienteScreen(), // ariel --puede que ya no la use por ser stateless
    '/RecuperarContrasena': (context) => RecuperarContrasena(),
    '/ClienteScreen2': (context) => ClienteScreen2(),
    '/PruebaRegistroUsuario': (context) => PruebaRegistroUsuario(),
    '/BienvenidaPage': (context) => const BienvenidaPage(),     //Isaac
    '/RegistroClientePage': (context) => const RegistroClientePage(),     //Isaac
    '/RegistroRetecPage': (context) => const RegistroRetecPage(),     //Isaac 
>>>>>>> main
  };
}
