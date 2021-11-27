//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RecuperarContrasena extends StatelessWidget {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar contrasena'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 25.0),
              Text(
                'Ingresa tu correo electronico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 15.0),
              userTextField(),
              SizedBox(height: 15.0),
              botonRecuperar(context),
            ],
          ),
        ),
      ),
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

  botonRecuperar(BuildContext context) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () async {
          context.read<AuthentificationFirebase>().recuperarContra(
            email: emailController.text.trim(),
          );



          //Navigator.pushNamed(context, '/BienvenidaPage');
          // try {
          //   await FirebaseAuth.instance
          //       .sendPasswordResetEmail(email: emailController.text);
          // } on FirebaseAuthException catch (e) {
          //   Fluttertoast.showToast(
          //     gravity: ToastGravity.BOTTOM,
          //     msg: e.message.toString(),
          //   );
          // }
          // Fluttertoast.showToast(
          //     gravity: ToastGravity.BOTTOM,
          //     msg: 'Revisa la bandeja de tu correo electronico',
          //   );
          //Navigator.pushNamed(context, '/LoginScreen');
        },
        child: Text('Recuperar'),
        //style: ButtonStyle(backgroundColor: ),
      );
    });
  }
}
