import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({Key? key}) : super(key: key);

  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('cuentas');
  var firebaseUser = FirebaseAuth.instance.currentUser;
  late String _correo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _crearListaTarjetas2(),
    ));
  }

  Widget ImagenLogo() {
    // return StreamBuilder(
    // builder: (BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      height: 150,
      width: 350,
      child: Image.asset(
        'assets/Retec_Blanco_bordes.png',
        //height: 80.0,
        //alignment: Alignment.topLeft,
      ),
    );
    //});
  }

  Widget TextoAppBar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot stapshot) {
      return const Text(
        'Encuentra al personal necesario para tu problema',
        style: TextStyle(
            color: Colors.white,
            fontSize: 19.0,
            fontFamily: 'Myriadpro',
            fontWeight: FontWeight.w700),
      );
    });
  }

  Widget _crearTargeta(String name, String categoria, String tiempo,
      String estrellas, String logo, String costo, String status) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //redondeado de tarjea
      child: Column(
        children: <Widget>[
          //SizedBox(height: 30.0),
          ListTile(
            //tileColor: Colors.black38,
            //leading: Icon(Icons.photo_album, color: Colors.blue),
            leading: FadeInImage(
              placeholder: const AssetImage('assets/eclipse.gif'),
              image: NetworkImage(
                logo,
              ), //falta cambir por varios.
            ),
            title: Text(name), //aqui hacer que vaya cambiando
            subtitle: Text(categoria),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(status),
              Text(costo),
              const Icon(Icons.star_outline_sharp),
              Text(estrellas),
              const SizedBox(width: 15.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearListaTarjetas2() {
    String nombre = '',
        categoria = '',
        tiempo = '',
        estrellas = '',
        logo = '',
        status = '',
        costo = '';
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Flexible(
                  //aqui esta el error
                  child: FittedBox(
                    fit: BoxFit.fill, // otherwise the logo will be tiny
                    child: ImagenLogo(),
                  ),
                ),
                Container(
                  child: TextoAppBar(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pedidos')
                .doc(firebaseUser!.email)
                .collection('pedidos')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child:
                      CircularProgressIndicator(), //aqui puede ir un indicador de cargo
                );
              }
              return ListView.builder(
                //retornamos las listas existente
                //shrinkWrap: true,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                itemCount: snapshot.data!.docs
                    .length, //cantidad de elementos que se encuentran en la base de datos
                itemBuilder: (BuildContext context, int index) {
                  //inndex cambiar por doc de snapshot
                  nombre =
                      snapshot.data!.docs.elementAt(index).get("reteccito");
                  categoria =
                      snapshot.data!.docs.elementAt(index).get("Categoria");
                  tiempo = snapshot.data!.docs.elementAt(index).get("tiempo");
                  estrellas =
                      snapshot.data!.docs.elementAt(index).get("Calficacion");
                  logo = snapshot.data!.docs.elementAt(index).get("imagen");
                  costo = snapshot.data!.docs.elementAt(index).get("Costo");
                  status = snapshot.data!.docs.elementAt(index).get("status");
                  return Column(
                    children: [
                      _crearTargeta(nombre, categoria, tiempo, estrellas, logo,
                          costo, status),
                      const SizedBox(height: 15.0),
                    ],
                  );
                  //return _crearTargeta(snapshot.data!.doc("name").get().toString());//modificar para mandar parametros
                },
              );
            },
          ),
        ));
  }
}
