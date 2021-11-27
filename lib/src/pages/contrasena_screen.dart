import 'package:flutter/material.dart';

class ContrasenaScreen extends StatefulWidget {
  const ContrasenaScreen({Key? key}) : super(key: key);

  @override
  _ContrasenaScreenState createState() => _ContrasenaScreenState();
}

class _ContrasenaScreenState extends State<ContrasenaScreen> {
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
              _contrasenaActual(),
              const SizedBox(height: 20.0),
              _contrasenaNueva(),
              const SizedBox(height: 20.0),
              _guardarCambios(),
              const SizedBox(height: 20.0),
            ]));
  }

  Widget _contrasenaActual() {
    return TextField(
        //autofocus: true,
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: const Icon(Icons.lock_open),
            icon: const Icon(Icons.lock)),
        onChanged: (valor) => setState(() {}));
  }

  Widget _contrasenaNueva() {
    return TextField(
        //autofocus: true,
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: const Icon(Icons.lock_open),
            icon: const Icon(Icons.lock)),
        onChanged: (valor) => setState(() {}));
  }

  Widget _guardarCambios() {
    return ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Guardar'));
  }
}
