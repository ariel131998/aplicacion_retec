import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClienteScreen extends StatelessWidget {
  const ClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('Pantalla Cliente'),
      ),*/
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
          _bottonPerfil(),
          const SizedBox(height: 20.0),
          _bottonContrasena(),
          const SizedBox(height: 20.0),
          _bottonCobro(),
        ],
      )),
    );
  }

  // ignore: unused_element
  Widget _bottonPerfil() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/PerfilScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Perfil',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }

  Widget _bottonContrasena() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/ContrasenaScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Contraseña',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }

  Widget _bottonCobro() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/PagoScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Cobro',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }
}
