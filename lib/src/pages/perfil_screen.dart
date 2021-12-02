import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.Dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('cuentas');
  var firebaseUser = FirebaseAuth.instance.currentUser;
  // ignore: unused_field
  String _nombre = '';
  String _nom = '';
  String _foto = '';
  String _telefono = '';
  String _tel = '';
  String _direccion = '';
  String _dir = '';
  File? _imageFile;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Perfil',
            style:
                TextStyle(fontFamily: 'Myriadpro', fontWeight: FontWeight.w700),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<AuthentificationFirebase>().singOut(),
                icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: FutureBuilder(
          future: users.doc(firebaseUser!.email).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child:
                    CircularProgressIndicator(), //aqui puede ir un indicador de cargo
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              //print(data);
              _foto = data["imagen"];
              _nombre = data["nombre"];
              _telefono = data["telefono"];
              _direccion = data["direccion"];
            }
            return ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              children: [
                Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black87),
                    width: 220,
                    height: 220,
                    child: Stack(fit: StackFit.passthrough, children: [
                      _imagenPerfil(),
                      Positioned(
                          child: _cambiarImagen(context), bottom: 3, right: 50)
                    ])),
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
            );
          },
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
      return CircleAvatar(
        foregroundImage: FileImage(File(_imageFile!.path)),
        radius: 10,
        backgroundColor: Colors.transparent,
      );
    } else {
      // ignore: unnecessary_null_comparison
      if (_foto != null) {
        return CircleAvatar(
          foregroundImage: NetworkImage(_foto),
          backgroundImage: const AssetImage('assets/eclipse.gif'),
          radius: 10,
          backgroundColor: Colors.amber,
        );
      } else {
        return const CircleAvatar(
          foregroundImage: AssetImage('assets/usuario.png'),
          radius: 10,
          backgroundColor: Colors.amber,
        );
      }
    }
  }

  Widget _cambiarImagen(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _elegirImagen(context),
      child: const Icon(Icons.edit),
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
                    GestureDetector(
                      child: const Text("Camara"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        _imageFile = File(picture.path);
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (picture != null) {
        _imageFile = File(picture.path);
      }
    });
    Navigator.of(context).pop();
  }

  Widget _nombrePerfil() {
    return TextFormField(
        initialValue: _nombre,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Nombre Completo',
            labelText: 'Nombre',
            icon: const Icon(Icons.account_circle)),
        onChanged: (valor) {
          setState(() {
            _nom = valor;
            // ignore: avoid_print
            print(_nom);
          });
        });

    /* TextField(
      //autofocus: true,
      controller: TextEditingController(text: _nombre),
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
    );*/
  }

  Widget _telefonoPerfil() {
    return TextFormField(
        initialValue: _telefono,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Teléfono',
            labelText: 'Teléfono',
            icon: const Icon(Icons.phone_android)),
        onChanged: (valor) {
          setState(() {
            _tel = valor;
          });
        });

    /*TextField(
      //autofocus: true,
      controller: TextEditingController(text: _telefono),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Teléfono',
          labelText: 'Teléfono',
          icon: const Icon(Icons.phone_android)),
      onChanged: (_telefono) {
        setState(() {
          _telefono = _telefono;
        });
      },
    );*/
  }

  Widget _direccionPerfil() {
    return TextFormField(
        initialValue: _direccion,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Dirección',
            labelText: 'Dirección',
            icon: const Icon(Icons.location_on_outlined)),
        onChanged: (valor) {
          setState(() {
            _dir = valor;
            // print(_dir);
          });
        });
    /*TextField(
      //autofocus: true,
      controller: TextEditingController(text: _direccion),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Dirección',
          labelText: 'Dirección',
          icon: const Icon(Icons.location_on_outlined)),
      onChanged: (valor) {
        setState(() {
          _direccion = valor;
        });
      },
    );*/
  }

  Widget _guardarCambios() {
    return ElevatedButton(
        onPressed: () => upChanges(),
        child: const Text(
            'Guardar')); //=> Navigator.pop(context), child: const Text('Guardar'));
  }

  Future<String?> uploadImage(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    if (image != null) {
      String? fileName = firebaseUser!.email;
      Reference storageRef = storage.ref().child(fileName!);
      await storageRef.putFile(image);
      return await storageRef.getDownloadURL();
    }
    return null;
  }

  void upChanges() async {
    if (_imageFile != null) {
      try {
        if (_nom == "") {
          _nom = _nombre;
        }
        if (_tel == "") {
          _tel = _telefono;
        }
        if (_dir == "") {
          _dir = _direccion;
        }
        await uploadImage(_imageFile!).then((value) {
          users.doc(firebaseUser!.email).update({
            "imagen": value ?? _foto,
            "nombre": _nom,
            "telefono": _tel,
            "dirección": _dir,
          });
        });
        Fluttertoast.showToast(
          msg: "Información Actualizada",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          backgroundColor: Colors.amber[200],
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          backgroundColor: Colors.amber[200],
        );
      }
    } else {
      try {
        if (_nom == "") {
          _nom = _nombre;
        }
        if (_tel == "") {
          _tel = _telefono;
        }
        if (_dir == "") {
          _dir = _direccion;
        }
        users.doc(firebaseUser!.email).update({
          "nombre": _nom,
          "telefono": _tel,
          "dirección": _dir,
        });
        Fluttertoast.showToast(
          msg: "Información Actualizada",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          backgroundColor: Colors.amber[200],
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          backgroundColor: Colors.amber[200],
        );
      }
    }
  }

  /*upload() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    //pick image   use ImageSource.camera for accessing camera.
    //File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    //basename() function will give you the filename

    //passing your path with the filename to Firebase Storage Reference
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_imageFile!);
    uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }*/

  Widget _cambiarContrasena(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.of(context).pushNamed('/ContrasenaScreen'),
        child: const Text('Cambiar contraseña'));
  }
}
