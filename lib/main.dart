import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:flutter_retec/routes/routes.dart';
//import 'package:flutter_retec/src/pages/bienvenida_page.dart';
import 'package:flutter_retec/src/pages/cliente_scrren_prueba.dart';
import 'package:flutter_retec/src/pages/login_screen.dart';
//import 'package:flutter_retec/src/pages/registro_cliente_page.dart';
import 'package:flutter_retec/tema/palette.dart';

//pruebas firebase
import 'package:firebase_core/firebase_core.dart'; // (Firebase)
import 'package:firebase_auth/firebase_auth.dart'; // (Firebase)
import 'package:provider/provider.dart'; //(firebase)
Future<void> main() async{//aqui es el problema de la pantalla negra
  WidgetsFlutterBinding.ensureInitialized(); //se asegura que se realize de forma asincrona (Firebase)
  await Firebase.initializeApp(); //tenemos que esperar los servicios de firebase (Firebase)
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(//se encarga de checar los servicios
      providers: [
        Provider<AuthentificationFirebase>(
          create: (context)=> AuthentificationFirebase(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthentificationFirebase>().authStateChanges, //se encargara de checar el estado del usuario
          initialData: null
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Palette.kToDark),
        routes: getAplicationRoutes(),
        //initialRoute: '/LoginScreen',
        home: ChecarAutentificacion(), //vamos a cambiar la pagina de inicio segun el estado del login (Firebase)
      ),
    );
  }

}
//clase que se encargara de definir la ruta inicial segun el estado
class ChecarAutentificacion extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final firebaseUser = context.watch<User?>();//checamos el estado del usuario checar error aqui
      if (firebaseUser != null) {
        //return Text('signed in');
        return ClienteScreen2();
        //Navigator.of(context).pushNamed('/LoginScreen');
      }
    return LoginScreen();
    }
}
