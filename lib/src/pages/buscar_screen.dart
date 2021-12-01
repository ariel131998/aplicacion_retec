import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buscarScreen(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Busca Reteccito',
            style: TextStyle(fontFamily: 'Myriadpro', fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white,),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      drawer: const Drawer(), //animacion de dibujado de nuevo widget
      body: const Text('hola'));
}

Widget _busqueda() {
  return Center(
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Busqueda',
              style: TextStyle(fontSize: 24, fontFamily: 'Myriadpro'),
              //TextStyle(fontStyle: FontStyle.normal),
            ),
            SizedBox(width: 5),
            // IconButton(
            //   icon: const Icon(Icons.search),
            //   onPressed: () {},
            // )
          ],
        )
      ],
    ),
  );
}

Widget textoAppBar() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot stapshot) {
    return const Text(
      'Busca a tu Reteccito de confianza',
      style: TextStyle(
        fontFamily: 'Myriadpro',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 14.0,
      ),
    );
  });
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

// List<String> datosMap = [];//obtendremos su nombre de todos los usuarios como sugerencia. despues reducir a unos pocos
// queryInicial();

class DataSearch extends SearchDelegate<String> {
  //sustituir por datos de bd
  //final usuarios = FirebaseFirestore.instance.collection('usuarios').snapshots(); //ya tengo todos los usuarios
  //List<String> datosMapQuery = [];//buscaremos por categoria
  final cities = [
    "puebla",
    "oaxaca",
    "guadalajara",
    "canada",
    'mexico',
    'portugal',
    'ecuador'
  ];
  
  final recientes = ['mexico', 'portugal', 'ecuador'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // acciones para el buscador
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        //acciones en boton de X 
        onPressed: () {
          query = '';
        },
      )
    ];
    //throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // mandar al icono a la izquierda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      //acciones en boton de volver
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // mostrar los resultados basados en la direccion
    throw UnimplementedError();
  }
  //no estan funcionando las obtenciones de los datos 
  @override
  Widget buildSuggestions(BuildContext context) {
    // mostrar cuando alguien esta buscando algo
    //cambiar al final lo que se va a mostrar en sugerencias
    //final datos = FirebaseFirestore.instance.collection('usuarios').snapshots().length; //obtenemos datos de los primeros 5
    List<String> datosMap = [];//obtendremos su nombre de todos los usuarios como sugerencia. despues reducir a unos pocos
    //ya muestra estos datos
    List<String> datosMapCategoria =[];
    FirebaseFirestore.instance.collection('usuarios').get().then((value) {
      value.docs.forEach((element) {
        //element.get('name');
        datosMap.add(element.get('name'));
        datosMapCategoria.add(element.get('categoria'));
      });
    } );
    //esta obteniendo nada
    List<String> datosMapQuery = [];//buscaremos por categoria
    List<String> datosCategoriaQuery =[];
    FirebaseFirestore.instance.collection('usuarios').get().then((value) {
        value.docs.forEach((element) { 
          String prueba = element.get('categoria');
          if(prueba.contains(query) == true ){
            datosMapQuery.add(element.get('name'));
            datosCategoriaQuery.add(element.get('categoria'));
          }
        });
      });
    // });
    //print(datosMap);
    //final suggestionList = query.isEmpty ? datosMap : cities.where((p) => p.startsWith(query)).toList(); //me permite buscar segun lo que se escriba
    final suggestionList = query.isEmpty ? datosMap : datosMapQuery;
    final suggestionListCate = query.isEmpty ? datosMapCategoria : datosCategoriaQuery;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child:
              CircularProgressIndicator(), //aqui puede ir un indicador de cargo
          );
        }
        return ListView.builder(
          itemCount: suggestionList.length,
          //itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.person),
          title: Text(suggestionList[index]),
          //title: Text(snapshot.data!.docs.elementAt(index).get("name")),
          //subtitle: Text(snapshot.data!.docs.elementAt(index).get("categoria") ),
          subtitle: Text(suggestionListCate[index]),
          ),
        );
      },
    );
  }


}

