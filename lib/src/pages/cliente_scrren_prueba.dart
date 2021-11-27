//import 'dart:js';

//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_retec/authentification/authentification_firebase.dart';
import 'package:flutter_retec/tema/palette.dart';

import 'package:provider/provider.dart'; //(firebase)
import 'package:cloud_firestore/cloud_firestore.dart'; //firestore

class ClienteScreen2 extends StatefulWidget {
  const ClienteScreen2({Key? key}) : super(key: key);
  @override
  State<ClienteScreen2> createState() => _ClienteScreen2();
}

class _ClienteScreen2 extends State<ClienteScreen2> {
  //variables que se van a ir actualizando al ir creando las tarjetas.
  int numTarjeta = 0;
  //Map<String, String> usuarioTarjetaDatos= {"nombre": "", "categoria": "", "logo":"", "tiempo":"", "calificacion":""};
  List<String> mapaUsuarios = [];
  List<String> mapaCategoria = [];
  List<String> mapaLogo = [];
  List<String> mapaTiempo = [];
  List<String> mapaCalificacion = [];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    numTarjeta = 0;
    //colocarNombreDataTarjetas();//checar si aqui funciona puede dar error.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Flexible(//aqui esta el error
                child: FittedBox(    
                  fit: BoxFit.fill, // otherwise the logo will be tiny
                  child: ImagenLogo(),
                ),
              ),
              Container(
                child: TextoAppBar(),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        //child: _widgetOptions.elementAt(_selectedIndex),
        child: _crearVistasMenu(_selectedIndex, context),
      ),
      bottomNavigationBar: _crearBottomNavigator(),
    );
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
      return Text(
        'Encuentra al personal necesario para tu problema',
        style: TextStyle(
          color: Colors.white,
          fontSize: 19.0,
        ),
      );
    });
  }

  Widget _crearTargeta(String name, String categoria, String tiempo, String estrellas, String logo) {
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
              placeholder: AssetImage('assets/jar-loading.gif'),
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
              Text(tiempo),
              TextButton(
                onPressed: () {},
                child: Text('Contratar'),
              ),
              Icon(Icons.star_outline_sharp),
              Text(estrellas),
              SizedBox(width: 15.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _crearListaTarjetas2() {
    String imagen='', categoria='', tiempo='',estrellas='', logo='';
    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child:
                  Text('No hay info aun'), //aqui puede ir un indicador de cargo
            );
          }
          return ListView.builder(
            //retornamos las listas existente
            //shrinkWrap: true,
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            itemCount: snapshot.data!.docs
                .length, //cantidad de elementos que se encuentran en la base de datos
            itemBuilder: (BuildContext context, int index) {
              //inndex cambiar por doc de snapshot
               imagen = snapshot.data!.docs.elementAt(index).get("name");
               categoria = snapshot.data!.docs.elementAt(index).get("categoria");
               tiempo = snapshot.data!.docs.elementAt(index).get("tiempo");
               estrellas = snapshot.data!.docs.elementAt(index).get("Calficacion");
               logo = snapshot.data!.docs.elementAt(index).get("logo");
              return Column(
                children: [
                  _crearTargeta(imagen,categoria,tiempo,estrellas, logo),
                  SizedBox(height: 15.0),
                ],
              );
              //return _crearTargeta(snapshot.data!.doc("name").get().toString());//modificar para mandar parametros
            },
          );
        },
      ),
    );
  }

  Widget _crearBottomNavigator() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.backpack_sharp), //buscar icono externo
          label: 'Pedidos',
          backgroundColor: Colors.black87,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: 'Cuenta',
          backgroundColor: Colors.black87,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Palette.kToDark,
      //backgroundColor: Colors.amber,
      onTap: _onItemTapped,
    );
  }

  Widget _crearVistasMenu(int _selectedIndex, BuildContext context) {
    //crea la vista de cada boton del menu.
    List<Widget> _widgetOptions = <Widget>[
      _crearListaTarjetas2(),
      Text(
        'Prueba cambio',
        style: optionStyle,
      ),
      Text(
        'Index 2: Pedidos',
        style: optionStyle,
      ),
      _vistaCuentaUsuario(context),
    ];
    return _widgetOptions.elementAt(_selectedIndex);
  }

  // Widget _obtenerUbicacion(){
  //   return Center(
  //     child: Text('Ahora| obtener ubicacion')
  //   );
  // }

  Widget _vistaCuentaUsuario(BuildContext context) {
    //mandarDataTarjetas();
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthentificationFirebase>().singOut();
        },
        child: Text('Cerrar Sesion'),
      ),
    );
  }
  //vista de perfil la va a desarrollar jose.
  //no me deja poner el read

  //metodo para registar algun usuario, ya no es utilizado.
  mandarDataTarjetas() {
    //crear varible de los datos a mandar a cloudfirestore
    //es mejor crear una clase especifica para mandar los datos, ya que se puede mandar todos los datos del obj
    Map<String, dynamic> informacionUsuario = {
      "name": "Ariel", //falta capturar informacion del usuario logeado
      "categoria": "Mecanico",
      "tiempo": "A 5 minutos",
      "Calficacion": "5",
      "logo": "ligapuntojpg" //liga de una imagen de los iconos de internet
    };
    //para mas facilidad a la hora de utilizar firebase podemos asignar lo siguiente
    var db = FirebaseFirestore.instance;
    CollectionReference collectionReference = db.collection('usuarios');
    //otra forma
    //CollectionReference collectionReference = FirebaseFirestore.instance.collection('usuarios');
    //para agregar la info a la base de datos
    collectionReference.add(
        informacionUsuario); //se tendria que ir modificando la informacion del usuario.
  }
}

// collectionReference.snapshots().listen((snapshot) {
//   setState(() {
//   //aqui se puede obtener un solo valor de la base de datos o todos al mismo tiempo.
//     usuarios = snapshot.doc("name").get(),
//   });
// })
// collectionReference
// .get()
// .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//         print(doc["name"]);
//         return(doc["name"]);//aqui va a haber un error ya que solo retornara uno
//     });
// });
// return "hola";

//String name;

//funciono para un solo usuario.
// var db = FirebaseFirestore.instance;
// CollectionReference user = db.collection('usuarios');
// DocumentSnapshot snapshot = await user.doc("Wa8k43yDrtexeKkxZ2uN").get();
// var data = snapshot.data() as Map;
// String userName = data['name'];
// return userName;
//   void esperarNombre(){
//   colocarNombreDataTarjetas().then((String result) {
//     setState(() {
//       usuarioTarjetaDatos["nombre"] = result;
//     });
//   });
// }

// void esperarNombre(String name){
//     setState(() {
//       usuarioTarjetaDatos["nombre"] = name;
//     });
// }

// String cambiarCategoria() {
//   //colocarNombreDataTarjetas();
//   if(numTarjeta<mapaUsuarios.length){
//     String temp = (mapaCategoria[numTarjeta]).toString();
//     //numTarjeta++;
//     return temp;
//   }
//   else
//     return "vacio";
// }
// String cambiarTiempo() {
//   //colocarNombreDataTarjetas();
//   if(numTarjeta<mapaUsuarios.length){
//     String temp = (mapaTiempo[numTarjeta]).toString();
//     //numTarjeta++;
//     return temp;
//   }
//   else
//     return "vacio";
// }
// String cambiarIcono() {
//   //colocarNombreDataTarjetas();
//   if(numTarjeta<mapaUsuarios.length){
//     String temp = (mapaLogo[numTarjeta]).toString();
//     //numTarjeta++;
//     return temp;
//   }
//   else
//     return "vacio";
// }
// String cambiarCalificacion() {
//   //colocarNombreDataTarjetas();
//   if(numTarjeta<mapaUsuarios.length){
//     String temp = (mapaCalificacion[numTarjeta]).toString();
//     //numTarjeta++;
//     return temp;
//   }
//   else
//     return "vacio";
// }
// Future<void> colocarNombreDataTarjetas() async{
//   var db = FirebaseFirestore.instance;
//   CollectionReference user = db.collection('usuarios');
//   // DocumentSnapshot snapshot = await user.doc("Wa8k43yDrtexeKkxZ2uN").get();
//   // var data = snapshot.data() as Map;
//   // String userName = data['name'];
//   // return userName;
//   user.get().then((QuerySnapshot querySnapshot){
//     querySnapshot.docs.forEach((element) {
//       mapaUsuarios.add(element["name"]);
//       mapaCategoria.add(element["categoria"]);
//       mapaLogo.add(element["logo"]);
//       mapaTiempo.add(element["tiempo"]);
//       mapaCalificacion.add(element["calificacion"]);
//     });
//   });
// }
// String cambiarNombre() {
//   //colocarNombreDataTarjetas();
//   if(numTarjeta<mapaUsuarios.length){
//     String temp = (mapaUsuarios[numTarjeta]).toString();
//     return temp;
//   }
//   else
//     return "vacio";
// }


// Widget _crearTargetas(){//se encarga de colocar targetas en un listview
  //   return ListView(
  //     padding: EdgeInsets.all(10.0), //espacio en los lados de cada widget
  //     children: <Widget>[
  //       SizedBox(height: 15.0),
  //       _obtenerUbicacion(),
  //       SizedBox(height: 15.0),
  //       _crearTargeta(),
  //       SizedBox(height: 30.0),
  //       _crearTargeta(),
  //       SizedBox(height: 30.0),
  //       _crearTargeta(),
  //       SizedBox(height: 30.0),
  //       _crearTargeta(),
  //       SizedBox(height: 30.0),
  //       _crearTargeta(),
  //       SizedBox(height: 30.0),
  //       //quitar es de prueba para subir datos a base
  //       ElevatedButton(
  //         onPressed: mandarDataTarjetas,
  //         child: Text('subir info'),
  //         ),
  //     ],
  //   );
  // }