import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  //static String id = 'login_page '; // ver si me va a servir
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   //title: const Text('Login retec'),
      //   title: Image.asset('assets/fondo_login.jpg', fit: BoxFit.cover)
      // ),
      body: Center(
          child: Column(
        children: [
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
          Navigator.of(context).pushNamed('/ClienteScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
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
        onPressed: () {},
        child: const Text('Recuperar contraseña'),
      );
    });
  }
}
