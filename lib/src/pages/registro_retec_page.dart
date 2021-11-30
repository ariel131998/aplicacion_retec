import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  late DateTime _registerDate;
  late String _ccv;
  List<String> _jobs = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference cuentas =
        FirebaseFirestore.instance.collection('cuentas');

    Future<void> addUser() {

      return cuentas
          .add({
            'nombre': _name,
            'telefono': _phone,
            'direccion': _address,
            'tarjeta': _card,
            'fecha_vencimiento': _cardDate,
            'ccv': _ccv,
            'registro': _registerDate,
            'imagen': "",
            'tipo': "Reteccito",
            'trabajos': _jobs
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Registro'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 30.0,
            right: 30.0,
          ),
          shrinkWrap: true,
          children: <Widget>[
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
              height: 200,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                            if(value != null){
                              setState(() {
                                values[key] = value;
                              });
                              if(values[key]!){
                                print("El checkbox "+key+" fue establecido como true");
                                _jobs.add(key);
                              }else{
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
            TextFormField(
              keyboardType: TextInputType.number,
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                          fillColor: Color(0xFFE0E0E0),
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Fecha',
                          hintText: 'Fecha'),
                      validator: (String? date) {
                        if (date == null || date.isEmpty || date.length != 5) {
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
            /*Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          //Procesar la data
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Validando "),
                                  Text(_name)
                                ],
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: const Text('Siguiente >')),
                ),
              ],
            )*/
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    //Procesar la data
                    _formKey.currentState!.save();
                    _registerDate = DateTime.now();
                    /*values.keys.map((String key) {
                      if (values[key] == true) {
                        print(key);
                      }
                    });*/

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: _listaSeleccion()),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    addUser();
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
      //),
    );
  }

  List<Widget> _listaSeleccion() {
    List<Widget> lista = [];
    values.keys.map((String key) {
      if (values[key] == true) {
        final tempWidget = ListTile(
          title: Text(key),
        );

        lista.add(tempWidget);
      }
    });
    return lista;
  }
}
