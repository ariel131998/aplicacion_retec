import 'package:flutter/material.dart';

Widget buscarScreen() {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(90.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: <Widget>[
            const SizedBox(height: 40.0),
            Flexible(
              //aqui esta el error
              child: FittedBox(
                fit: BoxFit.fill, // otherwise the logo will be tiny
                child: ImagenLogo(),
              ),
            ),
            Container(
              child: TextoAppBar(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
          ],
        ),
      ),
    ),
    body: Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Busqueda',
                style: TextStyle(fontSize: 24, fontFamily: 'Myriadpro'),
                //TextStyle(fontStyle: FontStyle.normal),
              ),
              SizedBox(width: 5),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget TextoAppBar() {
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
