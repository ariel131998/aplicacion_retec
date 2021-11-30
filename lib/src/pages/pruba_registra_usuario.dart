import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';

//import 'package:firebase_auth/firebase_auth.dart';//autentificacion.
//import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; //(firebase)

class PruebaRegistroUsuario extends StatelessWidget {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  PruebaRegistroUsuario({Key? key}) : super(key: key);
  //static String id = 'login_page '; // ver si me va a servir

  //inicializacion firebase

  @override
  Widget build(BuildContext context) {
    //FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      // appBar: AppBar(
      //   //title: const Text('Login retec'),
      //   title: Image.asset('assets/fondo_login.jpg', fit: BoxFit.cover)
      // ),
      body: Center(
          child: Column(
        children: [
          Flexible(
            // o cambiar por container para evitar que se haga chico
            child: Stack(children: <Widget>[
              //permite widgets encimados
              Image.asset(
                'assets/fondo_login.jpg',
                //height: 350.0,
                //alignment: Alignment.center,
                width:
                    550.0, //evita que se haga mas chica la imagen al ser flexible
              ),
              Image.asset(
                'assets/Retec_Blanco_bordes.png',
                height: 350.0,
                //width: 450,
              ),
            ]),
          ),
          const SizedBox(height: 15.0),
          userTextField(),
          const SizedBox(height: 20.0),
          passwordTextField(),
          const SizedBox(height: 15.0),
          _bottonLogin(),
          //SizedBox(height: 15.0),
          //_TextRecuperarCont(),
        ],
      )),
    );
  }

  Widget userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electronico',
          ),
          onChanged: (email) {
            // se guarda el email ingresado //checar si no es aqui donde debo guardar el email
          },
        ),
      );
    });
  }

  Widget passwordTextField() {
    //final passwordController = TextEditingController();
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          controller: passwordController,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (contrasena) {
            // se guarda el email ingresado
          },
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          context.read<AuthentificationFirebase>().signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
          //Navigator.of(context).pushNamed('/LoginScreen');

          //Navigator.of(context).pushNamed('/ClienteScreen2');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Registrar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }

  // Widget _TextRecuperarCont() {
  //   return StreamBuilder(
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //     return TextButton(
  //       onPressed: () {
  //         Navigator.of(context).pushNamed('/RecuperarContrasena');
  //       },
  //       child: Text('Recuperar contraseña'),
  //     );
  //   });
  // }
}

//si sirve el registro de usuarios, pero despues de obtener los valores a donde los mandamos
