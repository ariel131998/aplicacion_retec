import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:provider/src/provider.dart';

class ContrasenaScreen extends StatefulWidget {
  const ContrasenaScreen({Key? key}) : super(key: key);

  @override
  _ContrasenaScreenState createState() => _ContrasenaScreenState();
}

class _ContrasenaScreenState extends State<ContrasenaScreen> {
  final passwordController1 = TextEditingController();
  final emailController = TextEditingController();
  final passwordControllerActual = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cambiar Contraseña'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            children: [
              _emailActual(emailController),
              const SizedBox(height: 20.0),
              _contrasenaActual(passwordControllerActual),
              const SizedBox(height: 20.0),
              _botonReautentificacion(context),
              const SizedBox(height: 20.0),
              _contrasenaNueva(passwordController1),
              const SizedBox(height: 20.0),
              _guardarCambios(context),
              const SizedBox(height: 20.0),
            ]));
  }

  Widget _contrasenaActual(TextEditingController passwordControllerActual) {
    return TextField(
        //autofocus: true,
        controller: passwordControllerActual,
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password Actual',
            labelText: 'Password Actual',
            suffixIcon: const Icon(Icons.lock_open),
            icon: const Icon(Icons.lock)),
        onChanged: (valor) => setState(() {}));
  }

  Widget _contrasenaNueva(TextEditingController passwordController1) {
    return TextField(
        controller: passwordController1,
        //autofocus: true,
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password Nueva',
            labelText: 'Password Nueva',
            suffixIcon: const Icon(Icons.lock_open),
            icon: const Icon(Icons.lock)),
        onChanged: (valor) => setState(() {}));
  }

  Widget _guardarCambios(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _actualizarDatosBase(context);
          Navigator.pop(context);
        },
        child: const Text('Guardar'));
  }

  void _actualizarDatosBase(BuildContext context) async {
    //print(passwordController1.text.trim());
    //primero tenemos que realizar una reautentificacion para que se pueda cambiar contrasena
    // context.read<AuthentificationFirebase>().autentificarNuevamente(
    //   email: emailController.text.trim(),
    //   password: passwordControllerActual.text.trim()
    // );

    context.read<AuthentificationFirebase>().cambiarContrasenaUsuario(
          newPassword: passwordController1.text.trim(),
        );
    //hasta aqui ya se actualzizo en firebaseauth, falta en firebasebd
    var db = FirebaseFirestore.instance;
    CollectionReference collectionReference = db.collection('cuentas');
    String correoBaseDatos =
        context.read<AuthentificationFirebase>().obtenerUsuario();
    collectionReference
        .doc(correoBaseDatos)
        .update({'contraseña': passwordController1.text.trim()});
  }

  Widget _emailActual(TextEditingController emailController) {
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

  _botonReautentificacion(BuildContext context ){
    return ElevatedButton(
        //style: ,
        onPressed: () {
          context.read<AuthentificationFirebase>().autentificarNuevamente(
              email: emailController.text.trim(),
              password: passwordControllerActual.text.trim());
        },
        child: const Text('Verificar'));
  }
}
