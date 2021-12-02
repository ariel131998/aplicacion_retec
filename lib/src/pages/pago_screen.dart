import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String _opcionS = 'Electricista';
  String _opcionP = 'xxxxxxxxxxxxxx2345';
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
  };

  final List<String> _opciones = ['Albañileria', 'Electricista', 'Plomeria'];
  final List<String> _formasP = [
    'xxxxxxxxxxxxxx2345',
    'xxxxxxxxxxxxxx7655',
    'xxxxxxxxxxxxxx8765'
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
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
          children: [
            _infoRectecito(),
            const SizedBox(height: 20.0),
            _servicio(),
            const SizedBox(height: 20.0),
            _formaDePago(),
            _direccionServicio(context),
            _total(),
            _pagar(context),
          ]),
    );
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

  List<DropdownMenuItem<String>> formasdePago() {
    List<DropdownMenuItem<String>> lista = [];
    for (var pago in _formasP) {
      lista.add(DropdownMenuItem(
        alignment: Alignment.centerRight,
        child: Text(pago),
        value: pago,
      ));
    }
    return lista;
  }

  Widget _formaDePago() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Tarjeta',
                  style: TextStyle(
                    fontSize: 20,
                  ))),
          Row(
            children: [
              const Icon(Icons.credit_card),
              const SizedBox(width: 30.0),
              Expanded(
                  child: DropdownButton(
                borderRadius: BorderRadius.circular(20),
                isExpanded: true,
                value: _opcionP,
                items: formasdePago(),
                onChanged: (opt) {
                  setState(() {
                    _opcionP = opt.toString();
                  });
                },
              )),
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Pagar',
                style: TextStyle(
                  fontSize: 18,
                ))));
  }
}
