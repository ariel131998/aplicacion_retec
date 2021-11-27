import 'package:flutter/material.dart';

class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({Key? key}) : super(key: key);
  final boxHeight = 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Bienvenido a Retec!'),
      ),
      backgroundColor: Color.fromRGBO(242,210,114, 2.0),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Deseo...'),
          ),
          _botonCliente(context),
          SizedBox(height: boxHeight),
          Container(
            alignment: Alignment.center,
            child: Text('ó'),
          ),
          SizedBox(height: boxHeight),
          _botonRetec(context),
        ],
      ),
    );
  }

  Widget _botonCliente(BuildContext context) {
    final card = Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Solicitar reparaciones o servicios')),
          Image(
            image: AssetImage('assets/cliente.png'),
            height: 200.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/RegistroClientePage'),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: card,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 10.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _botonRetec(BuildContext context) {
    final card = Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Brindar mis servicios')),
          Image(
            image: AssetImage('assets/retec.png'),
            height: 200.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/RegistroRetecPage'),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: card,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 10.0),
            )
          ],
        ),
      ),
    );
  }
}
