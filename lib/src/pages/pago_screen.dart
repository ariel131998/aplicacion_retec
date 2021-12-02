import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

// ignore: unused_import
import 'package:path/path.dart';

class PagoScreen extends StatefulWidget {
  const PagoScreen({Key? key}) : super(key: key);

  @override
  _PagoScreenState createState() => _PagoScreenState();
}

class _PagoScreenState extends State<PagoScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('cuentas');
  var firebaseUser = FirebaseAuth.instance.currentUser;

  String _opcionS = 'Electricista';
  late String _opcionP;
  late String _correo;
  late String _cliente;
  late Position _currentPosition;
  late GoogleMapController mapController;
  String _currentAddress = '';
  final startAddressController = TextEditingController();
  final LatLng _center = const LatLng(45.521563, -122.677433);

  Map? arguments;

  final Map _precio = {
    'Electricista': '500.00',
    'Albañileria': '600.00',
    'Plomeria': '400.00',
    'Mecánico': '800.00',
    'Maestro': '1000.00',
    'Soldador': '300.00',
    'Bartender': '2500.00',
    'Técnico en hardware': '500.00',
    'Constructor': '3000.00',
  };

  final List<String> _opciones = [
    'Albañileria',
    'Electricista',
    'Plomeria',
    'Mecánico',
    'Maestro',
    'Soldador',
    'Bartender',
    'Técnico en hardware',
    'Constructor'
  ];
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as Map?;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Servicio',
            style:
                TextStyle(fontFamily: 'Myriadpro', fontWeight: FontWeight.w700),
          ),
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
              String dat;
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              _correo = data["correo"];
              _cliente = data['nombre'];
              //print(data);
              dat = data["tarjeta"];
              dat =
                  'xxxxxxxxxxxxxxx' + dat.substring(dat.length - 4, dat.length);

              _opcionP = dat.toString();
              //.substring(_formasP[1].length - 4, _formasP[1].length);
            }
            return ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 20.0),
                children: [
                  _infoRectecito(),
                  const SizedBox(height: 20.0),
                  _servicio(),
                  const SizedBox(height: 20.0),
                  _formaDePago(),
                  _direccionServicio(context),
                  _total(),
                  _pagar(context),
                ]);
          },
        ));
  }

  Widget _infoRectecito() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blueGrey[100],
        ),
        height: 100,
        padding: const EdgeInsets.all(10),
        child: Stack(fit: StackFit.passthrough, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                arguments!['logo'],
                width: 60,
                height: 60,
              ),
              /*const Image(
                image: AssetImage('assets/electricista.png'),
                width: 60,
                height: 60,
              ),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    arguments!['name'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(arguments!['categoria'],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  Text(arguments!['tiempo'],
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13))
                ],
              ),
              const SizedBox(width: 50.0),
            ],
          ),
          Positioned(
            child: Row(children: [
              const Icon(Icons.star_border_rounded, size: 30),
              Text(arguments!['estrellas'],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(width: 5.0)
            ]),
            /*Image(
              image: AssetImage('assets/electricista.png'),
              width: 30,
              height: 30,
            ),*/
            bottom: 0,
            right: 0,
          ),
        ]));
  }

  List<DropdownMenuItem<String>> opcionesServicio() {
    List<DropdownMenuItem<String>> lista = [];
    for (var opcion in _opciones) {
      lista.add(DropdownMenuItem(
        alignment: Alignment.centerRight,
        child: Text(opcion),
        value: opcion,
      ));
    }
    return lista;
  }

  Widget _servicio() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Servicio',
                  style: TextStyle(
                    fontSize: 20,
                  ))),
          Row(
            children: [
              const Icon(Icons.build_circle_outlined),
              const SizedBox(width: 30.0),
              Expanded(
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  isExpanded: true,
                  value: _opcionS,
                  items: opcionesServicio(),
                  onChanged: (opt) {
                    setState(() {
                      _opcionS = opt.toString();
                    });
                  },
                ),
              )
            ],
          )
        ]));
  }

  /* List<DropdownMenuItem<String>> formasdePago() {
    //List<DropdownMenuItem<String>> lista = [];
    for (var pago in _formasP) {
      lista.add(DropdownMenuItem(
        alignment: Alignment.centerRight,
        child: Text(pago),
        value: pago,
      ));
    }
    return lista;
  }*/

  Widget _formaDePago() {
    bool? _opc = true;
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Row(children: const [
            Icon(Icons.credit_card),
            SizedBox(width: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Tarjeta',
                    style: TextStyle(
                      fontSize: 20,
                    )))
          ]),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.amber[200],
                  title: Text(_opcionP),
                  value: true,
                  //items: _Pago, //formasdePago(),
                  onChanged: (opt) {
                    setState(() {
                      // _opc = opt as bool?;
                    });
                  },
                  groupValue: _opc,
                ),
              ),
            ],
          )
        ]));
  }

  Widget _direccionServicio(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(10),
              height: 250.0,
              width: 400.0,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      heightFactor: 0.3,
                      widthFactor: 2.5,
                      child: GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 11.0,
                          ))))),
          Positioned(
              child: FloatingActionButton(
                backgroundColor: Colors.white54,
                onPressed: _getCurrentLocation,
                child: Icon(
                  Icons.location_on,
                  color: Colors.amber[700],
                ),
              ),
              bottom: 180,
              right: 18),
        ]),
        const SizedBox(height: 5.0),
        Text(_currentAddress, textAlign: TextAlign.center)
      ],
    );
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        // ignore: avoid_print
        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        // ignore: avoid_print
        print('Dirección: $_currentAddress');
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Widget _total() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Total',
                    style: TextStyle(
                      fontSize: 18,
                    ))),
            const SizedBox(width: 120.0),
            //const SizedBox(width: 5.0),
            Align(
                alignment: Alignment.centerRight,
                child: Row(children: [
                  const Icon(Icons.paid_outlined),
                  Text(_precio[_opcionS],
                      style: const TextStyle(
                        fontSize: 18,
                      ))
                ])),
          ],
        ));
  }

  Widget _pagar(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 25),
        child: ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              try {
                FirebaseFirestore.instance
                    .collection('pedidos')
                    .doc(_correo)
                    .collection('pedidos')
                    .doc(DateTime.now().toString())
                    .set({
                  'Calificacion': arguments!['estrellas'],
                  'Categoria': arguments!['categoria'],
                  'tiempo': arguments!['tiempo'],
                  'imagen': arguments!['logo'],
                  'Cliente': _cliente,
                  'Costo': _precio[_opcionS],
                  'forma_pago': 'Tarjeta',
                  'reteccito': arguments!['name'],
                  'servicio': _opcionS,
                  'status': 'Finalizado',
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
              Navigator.pop(context);
            },
            child: const Text('Pagar',
                style: TextStyle(
                  fontSize: 18,
                ))));
  }
}
