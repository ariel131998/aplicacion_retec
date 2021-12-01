import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buscarScreen(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Busca Reteccito',
            style: TextStyle(
              fontFamily: 'Myriadpro',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      drawer: const Drawer(), //animacion de dibujado de nuevo widget
      body:  Center(
        child: ImagenLogo(),
      )
  );
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
    height: 350,
    width: 350,
    child: Image.asset(
      'assets/Retec_Negro_SF.png',
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
    //retornaremos los resultados en forma de cards
    // return Card(
    //   //color: ,
    //   shape: StadiumBorder(),
    //   child: Center(
    //     child: Text(query),
    //   ),
    // );
     throw UnimplementedError();
    //var db = FirebaseFirestore.instance;
    //CollectionReference user = db.collection('usuarios');
    //user.snapshots.
    // FirebaseFirestore.instance.collection('usuarios').get().then((value) {
    //   value.docs.forEach((element) {
    //     //element.get('name');
    //     if(element.get('categoria') == query)
    //   });
    // });

    // return Card(
    //   elevation: 10.0,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20.0)), //redondeado de tarjea
    //   child: Column(
    //     children: <Widget>[
    //       //SizedBox(height: 30.0),
    //       ListTile(
    //         //tileColor: Colors.black38,
    //         //leading: Icon(Icons.photo_album, color: Colors.blue),
    //         leading: FadeInImage(
    //           placeholder: const AssetImage('assets/eclipse.gif'),
    //           image: NetworkImage(
    //             logo,
    //           ), //falta cambir por varios.
    //         ),
    //         title: Text(name), //aqui hacer que vaya cambiando
    //         subtitle: Text(categoria),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: <Widget>[
    //           Text(tiempo),
    //           TextButton(
    //             onPressed: () {
    //               _contratarServicio(name, context, logo, categoria);
    //             },
    //             child: Text('Contratar'),
    //           ),
    //           const Icon(Icons.star_outline_sharp),
    //           Text(estrellas),
    //           const SizedBox(width: 15.0),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    //Navigator.of(context).pushNamed('/PagoScreen');

  }

  //no estan funcionando las obtenciones de los datos
  @override
  Widget buildSuggestions(BuildContext context) {
    // mostrar cuando alguien esta buscando algo
    //cambiar al final lo que se va a mostrar en sugerencias
    //final datos = FirebaseFirestore.instance.collection('usuarios').snapshots().length; //obtenemos datos de los primeros 5
    List<String> datosMap =
        []; //obtendremos su nombre de todos los usuarios como sugerencia. despues reducir a unos pocos
    //ya muestra estos datos
    List<String> datosMapCategoria = [];
    FirebaseFirestore.instance.collection('usuarios').get().then((value) {
      value.docs.forEach((element) {
        //element.get('name');
        datosMap.add(element.get('name'));
        datosMapCategoria.add(element.get('categoria'));
      });
    });
    //esta obteniendo nada
    List<String> datosMapQuery = []; //buscaremos por categoria
    List<String> datosCategoriaQuery = [];
    FirebaseFirestore.instance.collection('usuarios').get().then((value) {
      value.docs.forEach((element) {
        String prueba = element.get('categoria');
        if (prueba.contains(query) == true) {
          datosMapQuery.add(element.get('name'));
          datosCategoriaQuery.add(element.get('categoria'));
        }
      });
    });
    // });
    //print(datosMap);
    //final suggestionList = query.isEmpty ? datosMap : cities.where((p) => p.startsWith(query)).toList(); //me permite buscar segun lo que se escriba
    final suggestionList = query.isEmpty ? datosMap : datosMapQuery;
    final suggestionListCate =
        query.isEmpty ? datosMapCategoria : datosCategoriaQuery;
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
            onTap: (){
              Navigator.of(context).pushNamed('/PagoScreen');
              //showResults(context);//ya es un metodo heredado
            },
            leading: const Icon(Icons.person),
            title: Text(suggestionList[index]),
            //title: Text(snapshot.data!.docs.elementAt(index).get("name")),
            //subtitle: Text(snapshot.data!.docs.elementAt(index).get("categoria") ),
            //subtitle: Text(suggestionListCate[index]),
            subtitle: RichText(
              text: TextSpan(
                text: suggestionListCate[index].substring(0, query.length),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: suggestionListCate[index].substring(query.length),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
