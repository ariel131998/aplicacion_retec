import 'package:flutter/material.dart';

//import 'package:firebase_auth/firebase_auth.dart';//autentificacion.
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:provider/provider.dart';

import '../../main.dart'; //(firebase)

class LoginScreen extends StatelessWidget {
<<<<<<< HEAD
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
=======
  const LoginScreen({Key? key}) : super(key: key);

>>>>>>> VersionEstable
  //static String id = 'login_page '; // ver si me va a servir
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
<<<<<<< HEAD
          Flexible(// o cambiar por container para evitar que se haga chico
            child: Stack(children: <Widget>[//permite widgets encimados
              Image.asset(
                'assets/fondo_login.jpg',
                //height: 350.0,
                //alignment: Alignment.center,
                width: 550.0,//evita que se haga mas chica la imagen al ser flexible
                
              ),
              Image.asset(
                  'assets/Retec_Blanco_bordes.png',
                  height: 350.0,
                  //width: 450,
                  
              ),
            ]),
          ),
          SizedBox(height: 15.0),
          userTextField(),
          SizedBox(height: 20.0),
          passwordTextField(),
          SizedBox(height: 15.0),
          _bottonLogin(),
          SizedBox(height: 15.0),
          _TextRecuperarCont(),
          SizedBox(height: 15.0),
          _RegistrarUser(),
=======
          Flexible(
            child: Image.asset(
              'assets/fondo_login.jpg',
              height: 350.0,
            ),
          ),
          const SizedBox(height: 15.0),
          userTextField(),
          const SizedBox(height: 20.0),
          passwordTextField(),
          const SizedBox(height: 15.0),
          _bottonLogin(),
          const SizedBox(height: 15.0),
          _TextRecuperarCont(),
>>>>>>> VersionEstable
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
            // se guarda el email ingresado
          },
        ),
      );
    });
  }

  Widget passwordTextField() {
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
<<<<<<< HEAD
    //Future<String> error;
=======
>>>>>>> VersionEstable
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
<<<<<<< HEAD
          //Navigator.of(context).pushNamed('/ClienteScreen2');
          //String mostrarError = context.read<AuthentificationFirebase>().errores.errorLogIn;
          //String error; 

          context.read<AuthentificationFirebase>().signIn(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );


          //error = context.read<AuthentificationFirebase>().errores.errorLogIn2;
          //print('error2: $mostrarError');//ya tengo el error, solo falta saber cuando ya hay error.
          //print('error1: $error');
          // if ( error == 'error' ) {
          //   print('prueba: $mostrarError');}
          // } else {
          //   print(mostrarError);
          // }
          //print('email controlerr:$emailController');
          //ChecarAutentificacion();
          //Navigator.of(context).pushNamed('/LoginScreen');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
=======
          Navigator.of(context).pushNamed('/ClienteScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
>>>>>>> VersionEstable
            'Iniciar Sesion',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }

  // ignore: non_constant_identifier_names
  Widget _TextRecuperarCont() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
<<<<<<< HEAD
        onPressed: () {
          Navigator.of(context).pushNamed('/RecuperarContrasena');
        },
        child: Text('Recuperar contraseña'),
      );
    });
  }


  Widget _RegistrarUser() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/PruebaRegistroUsuario');
        },
        child: Text('Registra usuario'),
      );
    });
  }
=======
        onPressed: () {},
        child: const Text('Recuperar contraseña'),
      );
    });
  }
>>>>>>> VersionEstable
}



//falta agregar boton ver contrasena y logotipo encima de la foto.
// onPressed: () {
//             Navigator.of(context).pushNamed('/ClienteScreen');

//todavia falta checar que hacer cuando se quiera iniciar sesion y a donde mandar.