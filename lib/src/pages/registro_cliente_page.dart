import 'package:flutter/material.dart';

class RegistroClientePage extends StatefulWidget {
  const RegistroClientePage({Key? key}) : super(key: key);

  @override
  State<RegistroClientePage> createState() => _RegistroClientePageState();
}

class _RegistroClientePageState extends State<RegistroClientePage> {
  var tmpArray = [];
  final boxHeight = 30.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _address;
  late String _card;
  late String _date;
  late String _ccv;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Registro'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
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
                  if (name == null || name.isEmpty || name.length < 20) {
                    return 'Por favor, ingrese un nombre válido';
                  }
                  return null;
                },
                onSaved:(val) => _name = val!,
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
                onSaved:(val) => _phone = val!,
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
                  if (direccion == null || direccion.isEmpty || direccion.length < 20) {
                    return 'Por favor, ingrese una dirección válida';
                  }
                  return null;
                },
                onSaved:(val) => _address = val!,
              ),
              SizedBox(height: boxHeight),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Tarjeta',
                    hintText: 'Tarjeta'),
                validator: (String? tarjeta) {
                  if (tarjeta == null || tarjeta.isEmpty || (tarjeta.length != 16 && tarjeta.length != 19)) {
                    return 'Por favor, ingrese un número de tarjeta válido';
                  }
                  return null;
                },
                onSaved:(val) => _card = val!,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
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
                      ),
                    ),
                    Spacer(),
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
                          }else{
                            
                            return null;
                          }
                        },
                        onSaved:(val) => _ccv = val!,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
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
                                content:  Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text( "Validando "),
                                    Text( _name)
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
