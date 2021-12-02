import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/src/provider.dart';

class RegistroRetecPage extends StatefulWidget {
  const RegistroRetecPage({Key? key}) : super(key: key);

  @override
  State<RegistroRetecPage> createState() => _RegistroRetecPageState();
}

class _RegistroRetecPageState extends State<RegistroRetecPage> {
    Map<String, bool> values = {
    'Plomería': false,
    'Electricista': false,
    'Albañilería': false,
  };

  var tmpArray = [];
  final boxHeight = 20.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _address;
  late String _card;
  late String _cardDate;
  late String _ccv;
  late DateTime _registerDate;
  late String _email;
  late String _password;
  List<String> _jobs = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference cuentas =
        FirebaseFirestore.instance.collection('cuentas');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return cuentas
          .doc(_email)
          .set({
            'correo': _email,
            'contraseña': _password,
            'nombre': _name,
            'telefono': _phone,
            'direccion': _address,
            'tarjeta': _card,
            'fecha_vencimiento': _cardDate,
            'ccv': _ccv,
            'registro': _registerDate,
            'tipo': "Reteccito",
            'trabajos': _jobs,
            'imagen': "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Registro'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: boxHeight),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Correo electrónico',
                    hintText: 'Correo electrónico'),
                validator: (String? email) {
                  if (email == null ||
                      email.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                    return 'Por favor, ingrese un email válido';
                  }
                  return null;
                },
                onSaved: (val) => _email = val!,
              ),
              SizedBox(height: boxHeight),
              TextFormField(
                obscuringCharacter: '•',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Contraseña'),
                validator: (String? password) {
                  if (password == null ||
                      password.isEmpty ||
                      password.length < 5) {
                    return 'Por favor, ingrese una contraseña válida';
                  }
                  return null;
                },
                onSaved: (val) => _password = val!,
              ),
              SizedBox(height: boxHeight),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Nombre'),
                validator: (String? name) {
                  if (name == null || name.isEmpty || name.length < 15) {
                    return 'Por favor, ingrese un nombre válido';
                  }
                  return null;
                },
                onSaved: (val) => _name = val!,
              ),
              SizedBox(height: boxHeight),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Teléfono',
                    hintText: 'Teléfono'),
                validator: (String? phone) {
                  if (phone == null || phone.isEmpty || phone.length != 10) {
                    return 'Por favor, ingrese un número de teléfono válido';
                  }
                  return null;
                },
                onSaved: (val) => _phone = val!,
              ),
              SizedBox(height: boxHeight),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                    hintMaxLines: 2,
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Dirección',
                    hintText: 'Dirección'),
                validator: (String? direccion) {
                  if (direccion == null ||
                      direccion.isEmpty ||
                      direccion.length < 20) {
                    return 'Por favor, ingrese una dirección válida';
                  }
                  return null;
                },
                onSaved: (val) => _address = val!,
              ),
             Container(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              height: 50,
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                    child: Column(
                      children: values.keys.map((String key) {
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          activeColor: Color.fromRGBO(242, 210, 114, 2.0),
                          title: Text(key),
                          value: values[key],
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                values[key] = value;
                              });
                              if (values[key]!) {
                                print("El checkbox " +
                                    key +
                                    " fue establecido como true");
                                _jobs.add(key);
                              } else {
                                _jobs.remove(key);
                              }
                              print(_jobs);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
              SizedBox(height: boxHeight),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 19,
                decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Tarjeta',
                    hintText: 'Tarjeta'),
                validator: (String? tarjeta) {
                  if (tarjeta == null ||
                      tarjeta.isEmpty ||
                      (tarjeta.length != 16 && tarjeta.length != 19)) {
                    return 'Por favor, ingrese un número de tarjeta válido';
                  }
                  return null;
                },
                onSaved: (val) => _card = val!,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        maxLength: 5,
                        decoration: const InputDecoration(
                            fillColor: Color(0xFFE0E0E0),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'Fecha',
                            hintText: 'Fecha'),
                        validator: (String? date) {
                          if (date == null ||
                              date.isEmpty ||
                              date.length != 5) {
                            return 'Fecha inválida';
                          }
                          return null;
                        },
                        onSaved: (val) => _cardDate = val!,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: const InputDecoration(
                            fillColor: Color(0xFFE0E0E0),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelText: 'CCV',
                            hintText: 'CCV'),
                        validator: (String? ccv) {
                          if (ccv == null || ccv.isEmpty || ccv.length != 3) {
                            return 'Inválido';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) => _ccv = val!,
                      ),
                    ),
                  ],
                ),
              ),
              

            ],
          ),
        ),
        
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _registerDate = DateTime.now();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Dando de alta"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      
                      addUser();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        Fluttertoast.showToast(
                            msg: "La contraseña es muy débil",
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_LONG,
                            timeInSecForIosWeb: 2);
                      } else if (e.code == 'email-already-in-use') {
                        Fluttertoast.showToast(
                            msg: "El correo ya está en uso",
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_LONG,
                            timeInSecForIosWeb: 2);
                      }
                    } catch (e) {
                      print(e);
                    }
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Por favor rellene todos los campos",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 2);
                  }
                },
                child: const Text('Siguiente >')),
          ],
        ),
      ),
    );
  }
}
