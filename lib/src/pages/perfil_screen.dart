import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // ignore: unused_field
  String _nombre = '';
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Perfil'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<AuthentificationFirebase>().singOut(),
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          children: [
            Stack(fit: StackFit.passthrough, children: [
              _imagenPerfil(),
              Positioned(child: _cambiarImagen(context), bottom: 0, right: 30)
            ]),
            const SizedBox(height: 30.0),
            _nombrePerfil(),
            const SizedBox(height: 20.0),
            _telefonoPerfil(),
            const SizedBox(height: 20.0),
            _direccionPerfil(),
            const SizedBox(height: 20.0),
            _guardarCambios(),
            const SizedBox(height: 20.0),
            _cambiarContrasena(context)
          ],
        ),
        floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () => _infoAplicacion(context),
            child: const Icon(Icons.info)));
  }

  void _infoAplicacion(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text('Información de la aplicación'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Version: 1.0.0'),
                SizedBox(height: 10),
                Text(
                    'Editores: \nOrtega Zitle Ariel\nCanalizo Mendoza Andree Isaac\nAguirre Olvera José Manuel'),
                Image(
                  image: AssetImage('assets/Retec_Negro_SF.png'),
                  height: 150,
                ),
              ],
            ),
          );
        });
  }

  Widget _imagenPerfil() {
    // ignore: unnecessary_null_comparison
    if (_imageFile != null) {
      return Container(
          width: 190.0,
          height: 190.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: FileImage(File(_imageFile!.path)),
              )));
    } else {
      return Container(
          width: 190.0,
          height: 190.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/user.png'),
              )));
    }
    /*return const Image(
      image: AssetImage('assets/user.png'),
      width: 50.0,
      fit: BoxFit.contain,
    );*/
  }

  Widget _cambiarImagen(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            FloatingActionButton(
              onPressed: () => _elegirImagen(context),
              child: const Icon(Icons.edit),
            )
          ],
        ),
        const SizedBox(height: 15.0)
      ],
    );
  }

  Future<void> _elegirImagen(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("¿De donde quieres elegir tu foto?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Galeria"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    /*GestureDetector(
                      child: const Text("Camara"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )*/
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  /*Future<void> _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }*/

  Widget _nombrePerfil() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre Completo',
          labelText: 'Nombre',
          icon: const Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _telefonoPerfil() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Teléfono',
          labelText: 'Teléfono',
          icon: const Icon(Icons.phone_android)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _direccionPerfil() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Dirección',
          labelText: 'Dirección',
          icon: const Icon(Icons.location_on_outlined)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _guardarCambios() {
    return ElevatedButton(
        onPressed: () => Navigator.pop(context), child: const Text('Guardar'));
  }

  Widget _cambiarContrasena(BuildContext context) {
    return TextButton(
        onPressed:
            () {}, //=> Navigator.of(context).pushNamed('/ContrasenaScreen'),
        child: const Text('Cambiar contraseña'));
  }
}
